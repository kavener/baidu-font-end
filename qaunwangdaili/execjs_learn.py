import execjs
import requests
import re
name = execjs.get().name

# execjs 的简单使用
ctx = execjs.compile("""
       function add(x, y) {
               return x + y;
          }
""")
result = ctx.call("add", 1, 2)
print(result)

_ = ['\x2e\x70\x6f\x72\x74', "\x65\x61\x63\x68", "\x68\x74\x6d\x6c", "\x69\x6e\x64\x65\x78\x4f\x66", '\x2a', "\x61\x74\x74\x72", '\x63\x6c\x61\x73\x73', "\x73\x70\x6c\x69\x74",
     "\x20", "", "\x6c\x65\x6e\x67\x74\x68", "\x70\x75\x73\x68", '\x41\x42\x43\x44\x45\x46\x47\x48\x49\x5a', "\x70\x61\x72\x73\x65\x49\x6e\x74", "\x6a\x6f\x69\x6e", '']

_ = ['.port', 'each', 'html', 'indexOf', '*', 'attr', 'class', 'split',
     ' ', '', 'length', 'push', 'ABCDEFGHIZ', 'parseInt', 'join', '']
''' 
js 加密混淆代码 复原 https://tool.lu/js（解密，解码工具）
$(function() {
    $('.port')['each'](function() {
        var a = $(this)['html']();
        if (a['indexOf']('*') != -0x1) {
            return
        };
        var b = $(this)['attr']('class');
        try {
            b = (b['split'](" "))[0x1];
            var c = b['split']('');
            var d = c['length'];
            var f = [];
            for (var g = 0x0; g < d; g++) {
                f['push']('ABCDEFGHIZ'['indexOf'](c[g]))
            };
            $(this)['html'](window['parseInt'](f['join']('')) >> 0x3)
        } catch(e) {}
    })
})
'''

js_ex = '''
function get_port(c){
// c = 'GEA';
d = c['length'];
var f = [];
for (var g = 0; g < d; g++) {
    f['push']('ABCDEFGHIZ'['indexOf'](c[g]))
}  
result = f.join('') >> 3;
// alert(c);
// alert(d);
// alert(f);
// alert(result);
return result
}
'''

ctx = execjs.compile(js_ex)
port = ctx.call('get_port', 'HZZZC')
print(port)


def get_port(port_s):
    return str(int(''.join([str('ABCDEFGHIZ'.index(port_s[i])) for i in range(len(port_s))])) >> 3)


def get_page(url, headers):
    try:
        response = requests.get(url=url, headers=headers, timeout=120)
        if response.status_code == 200:
            return response.text
        else:
            print('Status_code Exception')
            return
    except:
        print('Requests-get Exception')
        return


def parse_date(html):
    '''
    使用正则解析页面的IP  破解IP字段灵感：https://www.cnblogs.com/cc11001100/p/8647080.html
    '''
    pat = re.compile('<td class="ip">(.*?:)<span class="port (.*?)"', re.S)
    results = re.findall(pat, html)
    if results:
        ips = []
        for result in results:
            # 过滤标签拼接IP
            # print(result)
            # <p style='display:none;'>10</p>
            ip = re.sub(
                '<p style=\'display: none;\'>.*?</p>|<p style=\'display:none;\'>.*?</p>', '', result[0])
            ip = re.sub('<.*?>', '', ip)
            # print(ip)
            # 接下来在破解端口
            port = get_port(result[1])
            proxy_ip = ip + port
            ips.append(proxy_ip)
        return ips
    else:
        print('parse failed.')
        return 

url = 'http://www.goubanjia.com/'
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36',
}

# html = get_page(url=url, headers=headers)
# if html:
#     parse_date(html)
# 获取代理后，构建一个有效代理IP池，即两个轮询动作，一个是不断请求新的代理IP测试有效性，有效则放入数据库中，
# 另一个轮询是定时运行数据库中的IP测试有效性，没有效果则建立打分淘汰制度直至IP淘汰为之

# 利用MySQL构建代理IP池,关键是API的设计，一定要简洁明了
import pymysql
db = pymysql.connect(user='root', password='root', port=3306, db='test')
cursor = db.cursor()
def save_ip(ip, score=100, use_status=0):
    '''
    存储有效IP，初始分数100分
    '''
    sql_repeat = 'SELECT * from free_ip_pool where ip=\'{}\''.format(ip)
    cursor.execute(sql_repeat)
    one = cursor.fetchone()
    if one:
        print('已存在')
        return 
    sql = 'INSERT INTO free_ip_pool(ip, score, use_status) values (%s, %s, %s)'
    cursor.execute(sql, (ip, score, use_status))
    db.commit

save_ip('211.24.102.168:80')

# 最好的方式就是并行测试，比如多个线程同时测试，提高效率 还可以利用主线程等待机制主动杀掉异常超时线程
def proxy_ip_test(url, headers, proxy_ip):
    try:
        response = requests.get(url=url, headers=headers, proxies=proxy_ip, timeout=240)
        if response.status_code == 200:
            return True
        else:
            return False
    except:
        return False

test_url = 'http://jzsc.mohurd.gov.cn/asite/jsbpp/index'
test_headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36',
}

def lunxun():
    html = get_page(url=url, headers=headers)
    if html:
        ips = parse_date(html)
        for ip in ips:
            proxy_ip = {'http': ip}
            ip_status = proxy_ip_test(test_url, headers=test_headers, proxy_ip=proxy_ip)
            if ip_status:
                save_ip(ip)
                print('存储')
                continue
            print('无效')

# 还需要一个持续运行IP池维护程序，不断轮询检测IP池内的IP质量(其实质量还可以细分，比如IP的访问时间可以优化打分机制，现在的打分机制是能用就行啦哈哈)
# 而维护程序也可以处理为防止重复测试，将每次测试的结果都放进IP_POOL 当时分数可以设置为0，甚至负数，用于检测防止下次测试的重复？

# 而轮询请求的时间间隔就根据不同的代理网站的更新时间进行呗，而且也要防止IP被封禁
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
        sql_update = 'UPDATE free_ip_pool set use_status=1 where id={}'.format(one[0])
        cursor.execute(sql_update)
        db.commit
    except:
        db.rollback
get_ip()

# --然而代理IP存在着两种不可用状态： 1 IP本身不能用 2 被目标网站使用到封禁
# 即采集速度需要根据目标网站的封禁程度+IP池质量和IP池中IP数量


# 然后是设计一个通用的接口（存储IP），和一个通用的IP池维护进程，自动维护IP池的运用   最重要的是一个通用IP使用接口，能够正确的使用，并正确的放回IP 其实还应该放置一个字段用于存储上一次IP使用的目标测试URL
def put_ip(ip, test_url):
    '''
    为什么放回来，当然是因为该IP使用出问题了，即大概率是因为被目标网站封禁了
    '''
    update_sql = 'UPDATE free_ip_pool set use_status=0, score=score-10, test_url=\'{}\' where ip=\'{}\''.format(test_url, ip)
    cursor.execute(update_sql)
    db.commit

put_ip('211.24.102.168:80', 'www.baidu.com')

### 更新设计目标：   针对单网站的数据采集-代理IP池构建




