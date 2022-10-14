import 'package:frida_query_builder/src/query/common/statement.dart';

class Insert extends Statement {
  Map<String, String> values;
  Insert(String source, {required this.values}) : super(source);
}
