import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';
import 'package:frida_query_builder/src/query/create/column/column.dart';

class Create extends Statement {
  List<Column> columns;

  Create({
    required String tableName,
    required this.columns,
  }) : super(tableName);

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitCreate(this);
  }
}
