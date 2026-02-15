import "package:frida_query_builder/frida_query_builder.dart";
import "package:frida_query_builder/src/query/create/column/column.dart";
import "package:frida_query_builder/src/query/create/column/column_data_type.dart";
import "package:frida_query_builder/src/query/create/foreign_key.dart";

class ColumnReal extends Column {
  ColumnReal(
      {required String name,
      bool isPrimaryKey = false,
      bool isNotNull = false,
      bool isUnique = false,
      dynamic defaultValue,
      List<Criterion>? checkConstraints,
      ForeignKey? foreignKey})
      : super(
            name: name,
            type: ColumnDataType.real,
            isPrimaryKey: isPrimaryKey,
            isNotNull: isNotNull,
            checkConstraints: checkConstraints,
            isUnique: isUnique,
            isAutoIncrement: false,
            defaultValue: defaultValue is double
                ? defaultValue.toStringAsFixed(2)
                : defaultValue,
            foreignKey: foreignKey);
}
