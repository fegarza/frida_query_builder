import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/field.dart';

class FieldQueryBuilder extends QueryBuilder {
  Object? field;

  FieldQueryBuilder(this.field);

  @override
  String build() {
    if (field == null) {
      return "NULL";
    }
    if (field is String) {
      return '"$field"';
    }
    if (field is Field) {
      Field f = (field as Field);

      return f.field;
    }

    return field.toString();
  }
}
