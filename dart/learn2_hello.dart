// void main(List<String> arguments) {
//   var aNumber = 5;
//   printNumber(aNumber);
//   int clo;
//   // 然而并没有抛出异常？
//   assert(clo != null);
//   const Name = 'ye qing';
//   var baz = const [];
//   baz = [1];
//   num x = 5.9;
//   // ceil floor 两对冤家
//   print(x.floor());
//   int dd = 3465374729;
//   // 只能接受bool进行if判断
//   // if (dd) {

//   // }
//   List lists = [1, 2, 4];
//   print(lists.length);
//   var gifs = new Map();
//   gifs['d'] = 4;
//   print(gifs);
//   print('\u2665,\u{1f600}');
//   printName(Name);
//   // 面向对象的处理机制
//   // var jsonData = JSON.decode('{"x":1}');
//   // print(jsonData);

// }

// // 其余的函数位置随意，但是顶级函数main作为执行的入口必须存在
// printNumber(num aNumber) {
//   print('The number is $aNumber.');
// }

// printName(String name) => print(name);

// enableFlag({bool bold = false, bool hidden = false}) {
//   // ...
// }

import 'dart:math';

class Point {
  final num x;
  final num y;
  final num dis;

  Point(x, y)
      : this.x = x,
        this.y = y,
        this.dis = sqrt(x * x + y * y);
}

main() {
  
}