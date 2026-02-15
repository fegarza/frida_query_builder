import "package:frida_query_builder/frida_query_builder.dart";
import "package:frida_query_builder/src/query/create/column/column.dart";
import "package:frida_query_builder/src/query/create/foreign_key.dart";
import 'package:frida_query_builder/src/query/create/column/column_data_type.dart';

class ColumnInteger extends Column {
  ColumnInteger(
      {required String name,
      bool isPrimaryKey = false,
      bool isNotNull = false,
      bool isUnique = false,
      bool isAutoIncrement = false,
      dynamic defaultValue,
      ForeignKey? foreignKey,
      List<Criterion>? checkConstraints})
      : super(
            name: name,
            type: ColumnDataType.integer,
            isPrimaryKey: isPrimaryKey,
            isNotNull: isNotNull,
            isUnique: isUnique,
            isAutoIncrement: isAutoIncrement,
            checkConstraints: checkConstraints,
            defaultValue:
                defaultValue is int ? defaultValue.toString() : defaultValue,
            foreignKey: foreignKey);
}
