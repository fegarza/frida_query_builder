import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/field.dart';
import 'package:frida_query_builder/src/query/operators/operator.dart';

class FieldQueryBuilder extends QueryBuilder {
  Object? field;
  final bool quoted;
  FieldQueryBuilder(
    this.field, {
    this.quoted = true,
  });

  @override
  String build() {
    if (field == null) {
      return "NULL";
    }
    if (field is String) {
      if (!quoted) {
        return "$field";
      }
      if ((field as String).contains('"')) {
        field = (field as String).replaceAll('"', '""');
      }

      return '"$field"';
    }
    // Check for Operator BEFORE Field, since Operator extends Field
    if (field is Operator) {
      final op = field as Operator;
      final leftBuilder = FieldQueryBuilder(op.left, quoted: false);
      final rightBuilder = FieldQueryBuilder(op.right, quoted: false);
      String result =
          '(${leftBuilder.build()} ${op.operator} ${rightBuilder.build()})';

      // Handle alias if present
      if (op.alias != null) {
        result += ' AS ${op.alias}';
      }

      return result;
    }
    if (field is Field) {
      Field f = (field as Field);
      String result = f.field;
      if (f.alias != null) {
        result += " AS ${f.alias}";
      }

      return result;
    }

    return field.toString();
  }
}
