import 'package:frida_query_builder/src/query/alter/alter.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

class DropColumn extends Alter {
  String columnName;

  DropColumn(String tableName, this.columnName) : super(tableName);

  @override
  T accept<T>(StatementVisitor<T> visitor) => visitor.visitDropColumn(this);
}
