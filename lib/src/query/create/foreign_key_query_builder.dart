import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/create/column/column.dart';

class ForeignKeyQueryBuilder implements QueryBuilder {
  List<Column> columns;

  ForeignKeyQueryBuilder(this.columns);

  @override
  String build() {
    var groupedByTable = <String, List<Column>>{};

    for (var column in columns) {
      groupedByTable
          .putIfAbsent(column.foreignKey!.referencedTable, () => [])
          .add(column);
    }

    var sb = StringBuffer();

    final List<String> fkConstraints = [];
    for (var tableGroup in groupedByTable.entries) {
      String tableName = tableGroup.key;
      List<Column> fkColumns = tableGroup.value;

      String fkConstraint = "FOREIGN KEY(" +
          fkColumns.map((e) => e.name).join(", ") +
          ") REFERENCES " +
          tableName +
          "(" +
          fkColumns.map((e) => e.foreignKey!.referencedColumn).join(", ") +
          ")";

      if (fkColumns.first.foreignKey!.onDelete != null) {
        fkConstraint +=
            " ON DELETE ${fkColumns.first.foreignKey!.onDelete!.getString()}";
      }

      if (fkColumns.first.foreignKey!.onUpdate != null) {
        fkConstraint +=
            " ON UPDATE ${fkColumns.first.foreignKey!.onUpdate!.getString()}";
      }

      fkConstraints.add(fkConstraint);
    }

    sb.write(fkConstraints.join(",\n "));

    return sb.toString();
  }
}
