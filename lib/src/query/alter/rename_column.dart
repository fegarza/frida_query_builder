import 'package:frida_query_builder/src/query/alter/alter.dart';

class RenameColumn extends Alter {
  String oldName;
  String newName;

  RenameColumn(String tableName, this.oldName, this.newName) : super(tableName);
}
