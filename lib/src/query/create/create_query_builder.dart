import 'package:frida_query_builder/src/query/common/frida_query_builder.dart';
import 'package:frida_query_builder/src/query/create/column_query_builder.dart';
import 'package:frida_query_builder/src/query/create/create.dart';

class CreateQueryBuilder extends FridaQueryBuilder {
  Create create;

  CreateQueryBuilder(this.create) : super(create);

  @override
  String build() {
    var sb = StringBuffer();
    sb.writeln("CREATE TABLE ${create.source} (");
    sb.writeln(create.columns
            .map((e) {
              return ColumnQueryBuilder(e).build();
            })
            .toList()
            .join(" ,\n") +
        ",");

    sb.writeln(
      "PRIMARY KEY ( " +
          create.columns
              .where((element) => element.isPrimaryKey)
              .map((e) => e.name)
              .join(" , ") +
          ")",
    );
    sb.writeln(");");
    /*create.columns.asMap().forEach((index, column) {
      bool isLastColumn = index == (create.columns.length - 1);
      sb.writeln(
        ColumnDefinitionBuilder(
          column,
          includeComa:
              (!isLastColumn) || (isLastColumn && _isCompositePrimaryKey),
          includePrimaryKey: !_isCompositePrimaryKey,
        ).build(),
      );
    });

    if (_isCompositePrimaryKey) {
      var sbCompositeKey = StringBuffer();
      sbCompositeKey.write("  PRIMARY KEY(");
      List<Column> primaryKeys =
          table.columns.where((element) => element.isPrimaryKey).toList();

      primaryKeys.asMap().forEach((indice, primaryKey) {
        bool isLastItem = indice == (primaryKeys.length - 1);
        String coma = isLastItem ? "" : ", ";
        sbCompositeKey.write("${primaryKey.name}$coma");
      });
      sbCompositeKey.write(")");
      sb.writeln(sbCompositeKey);
    }

    sb.writeln(");");*/
    return sb.toString();
  }
}
