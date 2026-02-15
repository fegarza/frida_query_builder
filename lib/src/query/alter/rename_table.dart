import 'package:frida_query_builder/src/query/alter/alter.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

class RenameTable extends Alter {
  String newName;

  RenameTable(String tableName, this.newName) : super(tableName);

  @override
  T accept<T>(StatementVisitor<T> visitor) => visitor.visitRenameTable(this);
}
