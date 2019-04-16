// // 定义一个方法 参数定义带有预定义类型
// printNumber(num aNumber) {
//   print('The number is $aNumber.');
// }

// // 一些方法简单操作
// // bool isNoble(int atomicNumber) {
// //   return _nobleGases[atomicNumber] != null;
// // }
// // bool isNoble(int atomicNumber) => _bobleGases[atomicNumber] != null;

// print_one({var onething='OK,defult value.'}) => print(onething);

// // String say(String from, String msg, [String device]) {
// //   var result = '$from say $msg';
// //   if (device != null){
// //     result = '$result with a $device.';
// //   }
// //   print(result);
// // }

// String say(String from, String msg, [String device = 'carrier piggen', String mood]) {
//   var result = '$from say $msg';
//   if (device != null) {
//     result = '$result with a $device';
//   }
//   if (mood != null) {
//     result = '$result (in a $mood mood)';
//   }
//   return result;
// }

// printElent(element) {
//   print(element);
// }

// main(){
//   //基础类型测试
//   final person_name = 'd';

//   num number = 33;
//   printNumber(number);

//   var x = 12;
//   var hex = 0xDEADBEEF;
//   var bigInt = 3465376845729;

//   var y = 1.1;
//   var exponents = 1.42e5;

//   var one = int.parse('1');
//   var onePointone = double.parse('1.1');
//   print(one);
//   print(onePointone);

//   String oneAsString = 1.toString();
//   String piAsString = 3.14159.toStringAsFixed(2);

//   print(piAsString);

//   const msPerSecond = 1000;
//   const secondsUntilRetry = 5;
//   const msUntilRetry = msPerSecond * secondsUntilRetry;
//   print(msUntilRetry);
//   var hello = '''Hello
//   nice world!
//   ''';
//   var world = 'world$hello';
//   var hw = hello + world;
//   print(hw);

//   const String aConstNum = 'like';
//   const aConstBool = true;
//   const aConstString = 'a constant string';

//   var aNum = 0;
//   var aBool = true;

//   // 必须也为常量才能定义
//   const validConstString = '$aConstNum';

//   print(validConstString);

//   // Dart bool值这里差异化巨大，第一次看到这种，bool值必须为 true 才是真，其他所有值都是 false，但是也会自动检测是否为bool值
//   bool name_bool = true;
//   if (name_bool) {
//     print('true');
//   }
//   var fullName = '';
//   assert(fullName.isEmpty);
//   print(fullName.isEmpty);

//   var list = [1,2,3];
//   print(list);
//   for (one in list) {
//     print(one);
//   }
//   print(list.length);
//   var constList = const [1,3,4,5];
//   print(constList);
//   var gifts = new Map();
//   gifts['first'] = 'partridge';
//   print(gifts);
//   print(gifts['second']);
//   print_one();
//   var result;
//   result = say('bob', 'howly');
//   print(result);
//   result = say('bob', 'howly', 'like', 'love');
//   print(result);
//   list.forEach(printElent);
//   var loudify = (msg) => '$msg is the msg';
//   print(loudify('heate'));
// }

// 闭包
Function makeAdder(num addBy) {
  return (i) => addBy + i;
}

// 顶级方法，静态函数，实例函数 都是相等的！
foo() {}

class A {
  static void bar() {}
  void baz() {}
}

// 条件表达式的实例
String toString(msg) => msg ?? msg.supper();

final fooss = '';

// void misbehave() {
//   try {
//     fooss = "You can't change a final variable's value.";
//   } catch (e) {
//     print('misbehave() partially handled ${e.runtimeType}.');
//     rethrow; // Allow callers to see the exception.
//   }
// }

main() {
  // 创建匿名方法
  var furite_list = ['apples', 'oringes', 'bananas'];
  furite_list.forEach((i) {
    print(furite_list.indexOf(i).toString() + ': ' + i);
  });
  furite_list
      .forEach((i) => print(furite_list.indexOf(i).toString() + ': ' + i));

  var add1 = makeAdder(1);
  var add4 = makeAdder(4);

  print(add4(2));

  var x;
  x = foo;
  print(x == foo);

  x = A.bar;
  print(x == A.bar);

  var v = new A();
  var w = new A();

  var y = w;

  x = w.baz;

  print(y.baz == x);

  print(v.baz != w.baz);
  // 方法默认返回null;
  var numbers = -4;
  print(numbers);

  var a, b;
  a = 0;
  b = a++;
  print(a.toString() + ' ' + b.toString());
  a = 0;
  b = ++a;
  print(a.toString() + ' ' + b.toString());
  print(identical(a, b));
  // 似乎和Python一致，引用内存中同样的值，即可以动态改变变量本身的值：
  a = 'ddd';

  var message = new StringBuffer("Dart is fun");
  for (var i = 0; i < 5; i++) {
    message.write('!');
  }
  print(message);

  // 闭包？
  var callbacks = [];
  for (var i = 0; i < 2; i++) {
    callbacks.add(() => print(i));
  }
  callbacks.forEach((c) => c());

  var command = 'OP EN';
  switch (command) {
    case 'CLOSED':
      print('CLOSED');
      break;
    case 'OPEN':
      print('OPEN');
      break;
    default:
      print('NONE');
  }
  // 主动抛出异常
  // throw new FormatException('Expected at least 1 section');
  
  // class
  var jsondata = JSON.decode('{"x":2}');


}
