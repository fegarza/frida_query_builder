import 'package:frida_query_builder/src/query/alter/alter.dart';

class RenameTable extends Alter {
  String newName;

  RenameTable(String tableName, this.newName) : super(tableName);
}
