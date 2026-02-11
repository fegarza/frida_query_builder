import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';
import 'package:frida_query_builder/src/query/create/column/column.dart';

class Create extends Statement {
  List<Column> columns;

  Create({
    required String tableName,
    this.columns = const [],
  }) : super(tableName);

  Create addColumn(Column column) {
    this.columns = [...this.columns, column];
    return this;
  }

  Create addColumns(List<Column> columns) {
    this.columns = [...this.columns, ...columns];
    return this;
  }

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitCreate(this);
  }
}
