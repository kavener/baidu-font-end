# 设计目标构建基于站大爷的代理IP池
# 管理代理IP池
import requests
import re
import time
# 获取代理后，构建一个有效代理IP池，即两个轮询动作，一个是不断请求新的代理IP测试有效性，有效则放入数据库中，
# 另一个轮询是定时运行数据库中的IP测试有效性，没有效果则建立打分淘汰制度直至IP淘汰为之

# 利用MySQL构建代理IP池,关键是API的设计，一定要简洁明了
import pymysql
db = pymysql.connect(user='root', password='root', port=3306, db='test')
cursor = db.cursor()

def save_ip(ip, score=0, use_status=0, test_status=0):
    '''
    存储未测试IP，初始分数0分
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



def get_zhandaye_proxy():
    '''
    功能很简单，只需要请求出格式正确的IP即可！
    '''
    # 请求，返回，就这么简单
    proxy_api = 'http://s.zdaye.com/?api=201809060931142252&count=1&px=2'
    try:
        response = requests.get(proxy_api)
        response.encoding = response.apparent_encoding
        return response.text
    except:
        print('IP Get Failed.')
        return 'IP Get Failed.'

 # 设计一个站大爷轮询取得IP并放入的函数


def poll_zhadaye():
    '''
    持续访问并放入代理IP池中，这个一个增加的过程，即站大爷的代理往里面放，而其他的网站的代理IP也可以往里面放，后续会有自动同意的IP测试和IP池维护程序！

    而轮询的时间等待根据网站而异
    需要这样，直接将获取的IP放入数据库中，状态为微测试状态，因为获取和测试必须分开，不然浪费时间
    '''
    while True:
        ip = get_zhandaye_proxy()
        print(ip)
        
        # 测试IP 合法性即可 并尝试放入数据库中  应该  ....凑合能用吧......
        pat = re.compile('[0-9]{0,3}\.[0-9]{0,3}\.[0-9]{0,3}\.[0-9]{0,3}:', re.S)
        result = re.search(pat, ip)
        if result:
            print('Save IP.')
            save_ip(ip)
        else:
            print('illegal IP.')
        # 每秒钟请求一次
        time.sleep(1)
'<bad>请求过快，请再等3秒</bad>'
# 一个进程，用于不断存储新的有效的站大爷的代理IP
poll_zhadaye()

# 持续运行其他事情交给同意管理的代理IP池维护程序