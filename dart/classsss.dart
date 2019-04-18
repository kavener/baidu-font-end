// //  class
// class Point() {
//   num x;
//   num y;

//   // Point(num x, num y) {
//   //   this.x = x;
//   //   this.y = y;
//   // }

//   Poibnt(this.x, this.y);

//   Point.origin() {
//     x = 0;
//     y = 0;
//   }
// }
// main(){
//   // var p = Point(2, 2);

// }

// class Person {
//   String firstName;

//   Person.fromJson(Map data) {
//     print('in Person');
//   }
// }

// class Employee extends Person {
//   // Person does not have a default constructor;
//   // you must call super.fromJson(data).
//   Employee.fromJson(Map data) : super.fromJson(data) {
//     print('in Employee');
//   }
// }

// main() {
//   var emp = new Employee.fromJson({});

//   // Prints:
//   // in Person
//   // in Employee
//   if (emp is Person) {
//     // Type check
//     emp.firstName = 'Bob';
//   }
//   (emp as Person).firstName = 'Bob';
// }

// import 'dart:math';

// class Point {
//   final num x;
//   final num y;
//   final num distanceFromOrgin;

//   // 构造函数初始化变量属性
//   Point(x, y)
//       : x = x,
//         y = y,
//         distanceFromOrgin = sqrt(x * x + y * y);
// }

// class ImmutablePoint {
//   final x;
//   final y;
//   const ImmutablePoint(this.x, this.y);
//   static final ImmutablePoint origin = const ImmutablePoint(0, 0);
// }

// void main() {
//   var p = new Point(2, 3);
//   print(p.distanceFromOrgin);
// }

// import 'dart:math';

// class Point {
//   final x;
//   final y;

//   // 构造函数类似于__init__
//   Point(this.x, this.y);

//   num distanceTo(Point other) {
//     var dx = x - other.x;
//     var dy = y - other.y;
//     return sqrt(dx * dx + dy * dy);
//   }
// }

// void main() {
//   var p = new Point(1, 2);
//   var result = p.distanceTo(new Point(3, 4));
//   print(result);
// }

// class Rectangle {
//   num left;
//   num top;
//   num width;
//   num heigth;

//   Rectangle(this.left, this.top, this.width, this.heigth);

//   num get right => left + width;
//   set right(num value) => left = value - width;
//   num get bottom => top + heigth;
//   set bottom(num value) => top = value - heigth;
// }

// main() {
//   var rect = new Rectangle(3, 4, 20, 15);
//   print(rect.left);
//   print(rect.right);
//   rect.right = 10;
//   print(rect.left);
// }

// class Vector {
//   final int x;
//   final int y;

//   const Vector(this.x, this.y);

//   Vector operator +(Vector v) {
//     return new Vector(x + v.x, y + v.y);
//   }

//   Vector operator -(Vector v) {
//     return new Vector(x - v.x, y - v.y);
//   }
// }

// void main() {
//   final v = new Vector(2, 3);
//   final w = new Vector(2, 2);

// }

// class Person {
//   final _name;
//   Person(this._name);

//   String green(who) => 'Hello, $who, i am $_name';
// }

// class Imposter implements Person {
//   final _name = '';

//   String green(who) => 'Hi, $who, do you know i am ?';
// }

// greenBob(Person person) => person.green('bob');

// enum Color { red, green, blue }

// void main() {
//   print(greenBob(new Person('Kathy')));
//   print(greenBob(new Imposter()));
//   // 寻找索引
//   Color aColor = Color.blue;
//   print(Color.blue.index);
//   switch (aColor){
//     case Color.blue:
//       print('bule');
//       break;
//     default:
//       print('nothing');
//   }
// }

import 'dart:math';
abstract class Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    }
    else if (canConduct) {
      print('Waving hands');
    }
    else {
      print('Humming to self');
    }
  }
}

class Color {
  static const red = const Color('red');
  final String name;
  const Color(this.name);

}


class Point {
  num x;
  num y;
  Point(this.x, this.y);

  static num distanceBetween(Point a, Point b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy);
  }
}

main() {
  var a = new Point(1, 2);
  var b = new Point(2, 3);
  var distance = Point.distanceBetween(a, b);
  print(distance < 2.9);
  // 强类型语言
  var x = 'ss';
  // x = 1000;
}