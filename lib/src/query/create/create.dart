import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/create/column/column.dart';

class Create extends Statement {
  List<Column> columns;

  Create({
    required String tableName,
    required this.columns,
  }) : super(tableName);
}
