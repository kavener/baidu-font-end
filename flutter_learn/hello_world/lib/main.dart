// 导入Material UI组件库
import 'package:flutter/material.dart';

// 应用程序入口，runApp功能即启动Flutter应用，接收的参数为Widget参数
void main() => runApp(new MyApp());

// 继承一个无状态Widget组件
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp 设置应用名称、主题、语言、首页及路由列表等，其本身也是个Widget组件
    return new MaterialApp(
      // 应用名称
      title: 'Flutter Demos',
      // 应用主题
      theme: new ThemeData(
        // 蓝色主题
        primarySwatch: Colors.blue,
      ),
      // 使用命名路由管理route，首先注册路由表
      routes: {
        "new_page": (context) => NewRoute(),
      },
      // 应用首页路由
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // 泛型Widget，即接受Widget组件类型构建列表
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            new Text('''这个看似是个
                        组件列表
            多行书写'''),
            // 添加一个按钮组件，用于跳转新路由（新页面）
            FlatButton(
              child: Text('open new route'),
              textColor: Colors.blue,
              // 导航至新路由
              onPressed: () {
                // 推至路由栈，路由管理Widget组件，通过栈来管理一个路由widget集合 即先进先出管理原则，这样好理解多了
                // Navigator.push(context,
                //   new MaterialPageRoute(builder: (context){
                //     return new NewRoute();
                // // 通过路由名称也可以打开新的路由页
                
                //   }, 
                //   )
                // );
                Navigator.pushNamed(context, "new_page");
              }
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// 根据路由管理，尝试新的页面构建：
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('This is new route.')
      ),
      body: Center(
        child: Text('nice route.')
      )
    );
  }
}