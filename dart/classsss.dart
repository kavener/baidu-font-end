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

import 'dart:math';

class Point {
  final num x;
  final num y;
  final num distanceFromOrgin;

  // 构造函数初始化变量属性
  Point(x, y)
      : x = x,
        y = y,
        distanceFromOrgin = sqrt(x * x + y * y);
}

void main() {
  var p = new Point(2, 3);
  print(p.distanceFromOrgin);
}
