// dart 中的异步编程

String lookUpVersionSync() => '1.0.0';

class WannabeFunction {
  call(String a, String b, String c) => '$a $b $c'; 
}


class SortedCollection {
  Function compare;

  SortedCollection (int f(Object a, Object b)) {
    compare = f;
  }

}

  int sort(Object a, Object b) => 0;

main(){
  var wf =  new WannabeFunction();
  // 把类当做函数使用
  var out = wf('Hi', 'there', 'gang');
  print(out);
  SortedCollection coll = new SortedCollection(sort);

  print(coll.compare is Function);
  print(coll.compare is Compare);    
}
