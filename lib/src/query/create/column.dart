import 'package:frida_query_builder/src/query/create/column_data_type.dart';
export 'package:frida_query_builder/src/query/create/column_data_type.dart';

class Column {
  String name;
  ColumnDataType type;
  bool isPrimaryKey;
  bool isNotNull;
  bool isAutoIncrement;
  String? defaultValue;

  Column({
    required this.name,
    required this.type,
    this.isPrimaryKey = false,
    this.isNotNull = false,
    this.isAutoIncrement = false,
    this.defaultValue,
  });
}
