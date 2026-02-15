import 'package:frida_query_builder/src/query/alter/alter.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';
import 'package:frida_query_builder/src/query/create/column/column.dart';

class AddColumn extends Alter {
  Column column;

  AddColumn(String tableName, this.column) : super(tableName);

  @override
  T accept<T>(StatementVisitor<T> visitor) => visitor.visitAddColumn(this);
}
