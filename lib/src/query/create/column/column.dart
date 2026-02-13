import 'package:frida_query_builder/src/query/create/column/column_data_type.dart';
import 'package:frida_query_builder/src/query/create/foreign_key.dart';
import 'package:frida_query_builder/src/query/criterion/all.dart';

/// Represents a base column definition for a table.
abstract class Column {
  /// The name of the column.
  String name;

  /// The data type of the column.
  ColumnDataType type;

  /// Whether the column is part of the primary key.
  bool isPrimaryKey;

  /// Whether the column can be NULL.
  bool isNotNull;

  /// Whether the column is an AUTOINCREMENT field.
  bool isAutoIncrement;

  /// Default value for the column.
  dynamic defaultValue;

  /// Whether the column has a UNIQUE constraint.
  bool isUnique;

  /// Optional foreign key relationship.
  ForeignKey? foreignKey;

  /// List of criteria for CHECK constraints.
  List<Criterion>? checkConstraints;

  Column(
      {required this.name,
      required this.type,
      this.isPrimaryKey = false,
      this.isNotNull = false,
      this.isAutoIncrement = false,
      this.defaultValue,
      this.isUnique = false,
      this.foreignKey,
      this.checkConstraints});
}
