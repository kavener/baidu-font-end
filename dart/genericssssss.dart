// 泛型

main() {
  // 列表字符串类型检查
  var names = new List<String>();
  names.addAll(['iterable', 'dddd', 'dsda']);
  print(names);
  // names.add(1);
  var name_s = <String>['se', 'ff', 'fd'];
  var pages = <String, String>{
    'index.html': 'HomePage',
    'robots.txt': 'Hints for web robots'
  };
  print(pages);
}