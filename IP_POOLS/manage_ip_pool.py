import pymysql
'''
把所有重任都放在这里，
管理IP池
1. 测试未测试的IP
2. 不断轮询有效IP
'''
import requests
import re
import time
# 获取代理后，构建一个有效代理IP池，即两个轮询动作，一个是不断请求新的代理IP测试有效性，有效则放入数据库中，
# 另一个轮询是定时运行数据库中的IP测试有效性，没有效果则建立打分淘汰制度直至IP淘汰为之

# 利用MySQL构建代理IP池,关键是API的设计，一定要简洁明了


test_url = 'http://jzsc.mohurd.gov.cn/asite/jsbpp/index'
test_headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36',
}


db = pymysql.connect(user='root', password='root', port=3306, db='test')
cursor = db.cursor()


# 使用IP的接口
def get_ip():
    '''
    取出有效ip，并更改IP使用状态  该操作必须为原子操作，多线程下必须利用锁机制或者其他方式保护
    '''
    # 应该只取出一个，且更新使用状态，且应该从分数最高到低取出
    sql = 'select * from free_ip_pool where score=(select max(score) from free_ip_pool)  and use_status=0 limit 1'
    cursor.execute(sql)
    one = cursor.fetchone()
    if one:
        print(one)
    # 本来应该是有更高级的同时查询并更新操作
    try:
        sql_update = 'UPDATE free_ip_pool set use_status=1 where id={}'.format(
            one[0])
        cursor.execute(sql_update)
        db.commit
    except:
        db.rollback

# 使用IP的接口


def put_ip(ip, test_url):
    '''
    为什么放回来，当然是因为该IP使用出问题了，即大概率是因为被目标网站封禁了
    '''
    update_sql = 'UPDATE free_ip_pool set use_status=0, score=score-10, test_url=\'{}\' where ip=\'{}\''.format(
        test_url, ip)
    cursor.execute(update_sql)
    db.commit


# 存入合法IP的接口
def save_ip(ip, score=100, use_status=0, test_status=0):
    '''
    存储有效IP，初始分数100分
    '''
    sql_repeat = 'SELECT * from free_ip_pool where ip=\'{}\''.format(ip)
    cursor.execute(sql_repeat)
    one = cursor.fetchone()
    if one:
        print('已存在')
        return
    sql = 'INSERT INTO free_ip_pool(ip, score, use_status, test_status) values (%s, %s, %s, %s)'
    cursor.execute(sql, (ip, score, use_status, test_status))
    db.commit


# 最好的方式就是并行测试，比如多个线程同时测试，提高效率 还可以利用主线程等待机制主动杀掉异常超时线程
def proxy_ip_test(url, headers, proxy_ip):
    try:
        response = requests.get(url=url, headers=headers,
                                proxies=proxy_ip, timeout=240)
        if response.status_code == 200:
            return True
        else:
            return False
    except:
        return False


'''
测试 目的即维护一个
未测试IP初始分数为零分，
两个进程，一个用于测试0分选手，另一个测试有效IP
'''


def update_ip_score(ip):

    sql_update = 'UPDATE free_ip_pool set score=100 where ip=\'{}\''.format(
            ip)
    cursor.execute(sql_update)


def update_ip_test_status(ip, test_status):
    sql_update = 'UPDATE free_ip_pool set test_status={} where ip=\'{}\''.format(
        test_status, ip)
    cursor.execute(sql_update)


def delete_ip(ip):
    sql_delete = 'delete from free_ip_pool where ip=\'{}\''.format(ip)
    try:
        cursor.execute(sql_delete)
        db.commit
    except:
        db.rollback


def poll_test_0_ip():
    '''
    先测试IP池内socre为0的IP  既包括没有测试过的，和IP分数逐渐减至0的

    针对单进程程轮询测试socre=0 的IP

    '''

    while True:
        sql = 'select * from free_ip_pool where score=0 limit 1'
        cursor.execute(sql)
        one = cursor.fetchone()
        if one: 
            ip = one[1]
            print(ip) 
            ip_test = proxy_ip_test(
                url=test_url, headers=test_headers, proxy_ip={'http': ip})
            if ip_test:
                update_ip_score(ip)
                print('IP Valid. set 100 score')
            else:
                # 即无效，删除
                print('IP invalid. Deleted')
                delete_ip(ip)
        else:
            # 即没有合法的数据，需要等待，或者等待另一个线程的信号来处理，即一旦出现了就立马通知该线程来处理
            # 暂时没有线程通信，就用延时处理了吧，后续更新
            print('wait for 0 score IP come...')
            time.sleep(1)

            ...
poll_test_0_ip()

