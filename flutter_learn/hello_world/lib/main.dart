// 一些汇总总结，迫在眉睫的需求，比如英文文档阅读能力（Dart文档，Flutter文档，外国社区等必须的能力要求，甚至文档翻译能力）
// Dart、Flutter 中需多的类思想，函数式编程等思想
// 不断实践，思考，理解其本质，即尝试源码的阅读，尤其是Dart和Flutter的源码极其优秀，再加之注释的完美搭配

// 导入Material UI组件库
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

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
        "counter_page": (context) => CounterWidget(),
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
                }),
            FlatButton(
              child: Text('open new counter'),
              textColor: Colors.blue,
              onPressed: () => Navigator.pushNamed(context, "new_page"),
            ),
            new RandomWordsWidget(),
            Echo(
              text: "hello, world",
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
        appBar: AppBar(title: Text('This is new route.')),
        body: Center(child: Text('nice route.')));
  }
}

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Text(wordPair.toString()));
  }
}

class Echo extends StatelessWidget {
  const Echo({
    Key key,
    @required this.text,
    this.backgroundColor: Colors.grey,
  }) : super(key: key);
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      color: backgroundColor,
      child: Text(text),
    ));
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key key,
    this.initValue: 0,
  });

  final int initValue;

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;
  @override
  void initState() {
    super.initState();
    // 初始化状态
    _counter = widget.initValue;
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return new Center(
      child: FlatButton(
        child: Text('$_counter'),
        // 然后自增
        onPressed: () => setState(() => _counter++),
      ),
    );
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);
  @override
  _TapboxAState createState() => new _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: _handleTap,
        child: new Container(
            child: new Center(
                child: new Text(
          _active ? 'Active' : 'Inactive',
          style: new TextStyle(fontSize: 32.0, color: Colors.white),
        ))));
  }
}
