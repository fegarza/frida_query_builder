import 'package:frida_query_builder/src/query/create/column/column_data_type.dart';
import 'package:frida_query_builder/src/query/create/foreign_key.dart';
import 'package:frida_query_builder/src/query/criterion/all.dart';

abstract class Column {
  String name;
  ColumnDataType type;
  bool isPrimaryKey;
  bool isNotNull;
  bool isAutoIncrement;
  String? defaultValue;
  ForeignKey? foreignKey;
  List<Criterion>? checkConstraints;

  Column(
      {required this.name,
      required this.type,
      this.isPrimaryKey = false,
      this.isNotNull = false,
      this.isAutoIncrement = false,
      this.defaultValue,
      this.foreignKey,
      this.checkConstraints});
}
