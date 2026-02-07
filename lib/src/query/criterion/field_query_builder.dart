import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/field.dart';

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
