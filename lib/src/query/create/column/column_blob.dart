import "package:frida_query_builder/src/query/create/column/column.dart";
import 'package:frida_query_builder/src/query/create/column/column_data_type.dart';

class ColumnBlob extends Column {
  ColumnBlob({required String name, bool isNotNull = false})
      : super(
          name: name,
          type: ColumnDataType.blob,
          isPrimaryKey: false,
          isNotNull: isNotNull,
          isAutoIncrement: false,
        );
}
