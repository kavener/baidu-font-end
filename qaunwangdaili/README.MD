### 示例网站：https://blog.csdn.net/qq_40925239/article/details/88394484
## 涉及技术，简单execjs使用，js解码解密，混淆元素过滤
## 项目目的 获取 全网代理的IP [地址](http://www.goubanjia.com/)

自己学习过程记录，实现代码过程，搞清楚原理
该过程目的即获取全网代理正确的代理IP，其端口号被JS修改了 JS文件：http://www.goubanjia.com/theme/goubanjia/javascript/pde.js?v=1.0
js 代码如下：
```javascript
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('1M(17(p,a,c,k,e,r){e=17(c){18(c<a?\'\':e(1w(c/a)))+((c=c%a)>1s?1b.1r(c+1q):c.1v(1u))};19(!\'\'.1a(/^/,1b)){1c(c--)r[e(c)]=k[c]||e(c);k=[17(e){18 r[e]}];e=17(){18\'\\\\w+\'};c=1};1c(c--)19(k[c])p=p.1a(1t 1y(\'\\\\b\'+e(c)+\'\\\\b\',\'g\'),k[c]);18 p}(\'i h$=[\\\'\\\\E\\\\n\\\\x\\\\s\\\\j\\\',"\\\\l\\\\m\\\\v\\\\o","\\\\o\\\\j\\\\G\\\\p","\\\\r\\\\q\\\\H\\\\l\\\\I\\\\J\\\\K",\\\'\\\\M\\\',"\\\\m\\\\j\\\\j\\\\s",\\\'\\\\v\\\\p\\\\m\\\\k\\\\k\\\',"\\\\k\\\\n\\\\p\\\\r\\\\j","\\\\O","","\\\\p\\\\l\\\\q\\\\Q\\\\j\\\\o","\\\\n\\\\R\\\\k\\\\o",\\\'\\\\S\\\\T\\\\V\\\\z\\\\A\\\\B\\\\C\\\\D\\\\u\\\\F\\\',"\\\\n\\\\m\\\\s\\\\k\\\\l\\\\u\\\\q\\\\j","\\\\16\\\\x\\\\r\\\\q",\\\'\\\'];$(y(){$(h$[0])[h$[1]](y(){i a=$(t)[h$[2]]();L(a[h$[3]](h$[4])!=-w){N};i b=$(t)[h$[5]](h$[6]);P{b=(b[h$[7]](h$[8]))[w];i c=b[h$[7]](h$[9]);i d=c[h$[10]];i f=[];U(i g=W;g<d;g++){f[h$[11]](h$[12][h$[3]](c[g]))};$(t)[h$[2]](X[h$[13]](f[h$[14]](h$[15]))>>Y)}Z(e){}})})\',1A,1B,\'|||||||||||||||||1C|1x|1z|1p|1h|1i|1d|1e|1f|1m|1n|1o|1g|1k|1l|1j|1W|17|1X|1Y|1V|1S|1T|1U|1Z|23|25|24|20|21|19|22|18|1R|1H|1I|1J|1G|1D|1E|1F|1O|1P|1Q|1N|||||||1K\'.1L(\'|\'),0,{}))',62,130,'|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||function|return|if|replace|String|while|x70|x68|x6c|this|x65|x61|0x1|x49|x63|x6e|x69|x72|x73|29|fromCharCode|35|new|36|toString|parseInt|var|RegExp|x74|62|69|_|x42|for|x43|x41|try|x67|x75|x6a|split|eval|catch|0x0|window|0x3|x20|x47|x48|x2e|x46|x6f|x44|x45|x5a|x4f|x66|x2a|x6d|x78|x64'.split('|'),0,{}))
```
利用解码，解密网站：https://tool.lu/js 得：
```JavaScript
var _$ = ['.port', "each", "html", "indexOf", '*', "attr", 'class', "split", " ", "", "length", "push", 'ABCDEFGHIZ', "parseInt", "join", ''];
$(function() {
	$(_$[0])[_$[1]](function() {
		var a = $(this)[_$[2]]();
		if (a[_$[3]](_$[4]) != -0x1) {
			return
		};
		var b = $(this)[_$[5]](_$[6]);
		try {
			b = (b[_$[7]](_$[8]))[0x1];
			var c = b[_$[7]](_$[9]);
			var d = c[_$[10]];
			var f = [];
			for (var g = 0x0; g < d; g++) {
				f[_$[11]](_$[12][_$[3]](c[g]))
			};
			$(this)[_$[2]](window[_$[13]](f[_$[14]](_$[15])) >> 0x3)
		} catch (e) {}
	})
})
```
在将数组中的值替换：
```javascript
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
```
接下来即分析这段代码对我们的端口干了啥？？？
```javascript

$(function() {
    // 利用选择器定位所有的端口元素位置
    $('.port')['each'](function() {
        var a = $(this)['html']();
        if (a['indexOf']('*') != -0x1) {
            return
        };
        // 获取元素内class属性的值  <span class="port HIDHG">9017</span>  即 "port HIDHG"
        var b = $(this)['attr']('class');
        try {
            // 分割字符串获取HIDHG
            b = (b['split'](" "))[0x1];
            // c=b
            var c = b['split']('');
            // 获取字符串长度 5
            var d = c['length'];
            var f = [];
            for (var g = 0x0; g < d; g++) {
                // 从'ABCDEFGHIZ' 中获取'HIDHG'每个字符的位置并组成数组 7,8,3,7,6
                f['push']('ABCDEFGHIZ'['indexOf'](c[g]))
            };
            // 组成字符串'78376' 然后转为整形 78376 再右移三位
            $(this)['html'](window['parseInt'](f['join']('')) >> 0x3)
        } catch(e) {}
    })
})
```
将其中的DOM对象替换为自己的，然后重写JS代码：
``` javascript 
//alert('我要学JavaScript!');
c = 'GEA';
d = c['length'];
var f = [];
for (var g = 0; g < d; g++) {
    f['push']('ABCDEFGHIZ'['indexOf'](c[g]))
}  
result = f.join('') >> 3;
alert(c);
alert(d);
alert(f);
alert(result);
```

### 下面尝试利用 execjs 运行这段代码：
```python
import execjs
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
port = ctx.call('get_port', 'GEA')
print(port)
```
### 转化为Python代码
鉴于这段js代码挺简单的，可以尝试转化为Python代码，提高运行效率：
```python
def get_port(port_s):
return int(''.join([str('ABCDEFGHIZ'.index(port_s[i])) for i in range(len(port_s))])) >> 3
```

### IP字段破解过程
IP字段源码中有许多混淆元素，即没用的信息，利用正则过滤，然后把有效的字段拼接即可获取正确的IP地址
```python
pat = re.compile('<td class="ip">(.*?:)<span class="port (.*?)"', re.S)
    results = re.findall(pat, html)
    if results:
        for result in results:
            # 过滤标签拼接IP
            # print(result)
            # <p style='display:none;'>10</p>
            ip = re.sub('<p style=\'display: none;\'>.*?</p>|<p style=\'display:none;\'>.*?</p>', '', result[0])
            ip = re.sub('<.*?>', '', ip)
            print(ip)
```

### 大致测试代码：
```python
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
            print(proxy_ip)
    else:
        print('parse failed.')


url = 'http://www.goubanjia.com/'
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36',
}

html = get_page(url=url, headers=headers)
if html:
    parse_date(html)

```