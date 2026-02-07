import 'package:frida_query_builder/src/query/alter/alter.dart';

class DropColumn extends Alter {
  String columnName;

  DropColumn(String tableName, this.columnName) : super(tableName);
}
