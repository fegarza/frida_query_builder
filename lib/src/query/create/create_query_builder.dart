import 'package:frida_query_builder/src/query/common/frida_query_builder.dart';
import 'package:frida_query_builder/src/query/create/column/column_query_builder.dart';
import 'package:frida_query_builder/src/query/create/create.dart';
import 'package:frida_query_builder/src/query/create/foreign_key_query_builder.dart';
import 'package:frida_query_builder/src/query/create/primary_key_query_builder.dart';

class CreateQueryBuilder extends FridaQueryBuilder {
  Create create;

  CreateQueryBuilder(this.create) : super(create);

  @override
  String build() {
    var sb = StringBuffer();

    final tableName = create.source;

    sb.writeln(
        "CREATE TABLE ${create.isIfNotExists ? "IF NOT EXISTS " : ""}$tableName(");

    final definitionsBuilders = [];

    definitionsBuilders
        .addAll(create.columns.map((e) => ColumnQueryBuilder(e)));

    if (create.columns.where((w) => w.isAutoIncrement).isEmpty) {
      definitionsBuilders.add(PrimaryKeyQueryBuilder(
          create.columns.where((w) => w.isPrimaryKey).toList()));
    }

    var foreignKeyColumns =
        create.columns.where((w) => w.foreignKey != null).toList();

    if (foreignKeyColumns.isNotEmpty) {
      definitionsBuilders.add(ForeignKeyQueryBuilder(foreignKeyColumns));
    }

    sb.writeln(definitionsBuilders.map((e) => " " + e.build()).join(",\n"));

    sb.write(");");

    return sb.toString();
  }
}
