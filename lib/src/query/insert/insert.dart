import 'package:frida_query_builder/src/query/common/statement.dart';

class Insert extends Statement {
  Map<String, Object?> values;
  Insert({required into, required this.values}) : super(into);
}
