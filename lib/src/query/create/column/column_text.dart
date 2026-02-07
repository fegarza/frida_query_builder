import "package:frida_query_builder/src/query/create/column/column.dart";
import "package:frida_query_builder/src/query/create/column/column_data_type.dart";
import "package:frida_query_builder/src/query/create/foreign_key.dart";

class ColumnText extends Column {
  ColumnText(
      {required String name,
      bool isPrimaryKey = false,
      bool isNotNull = false,
      String? defaultValue,
      ForeignKey? foreignKey})
      : super(
            name: name,
            type: ColumnDataType.text,
            isPrimaryKey: isPrimaryKey,
            isNotNull: isNotNull,
            isAutoIncrement: false,
            defaultValue: defaultValue,
            foreignKey: foreignKey);
}
