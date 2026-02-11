import 'package:frida_query_builder/src/query/alter/alter.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

class RenameColumn extends Alter {
  String oldName;
  String newName;

  RenameColumn(String tableName, this.oldName, this.newName) : super(tableName);

  @override
  T accept<T>(StatementVisitor<T> visitor) => visitor.visitRenameColumn(this);
}
