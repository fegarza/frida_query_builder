import 'package:frida_query_builder/src/query/criterion/field.dart';
import 'package:frida_query_builder/src/query/select/select.dart';

/// Represents a subquery that can be used in other statements.
class Subquery extends Field {
  /// The select statement for the subquery.
  final Select select;

  Subquery(this.select, {String? alias}) : super("SUBQUERY", alias: alias);
}
