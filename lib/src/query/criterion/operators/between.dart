import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';
import 'package:frida_query_builder/src/query/criterion/field.dart';
import 'package:frida_query_builder/src/query/criterion/field_query_builder.dart';

class Between extends CriterionCompare {
  Between(
    dynamic field,
    dynamic lower,
    dynamic upper,
  ) : super(
          field,
          Field(
            "${FieldQueryBuilder(lower).build()} AND ${FieldQueryBuilder(upper).build()}",
          ),
          "BETWEEN",
        );
}
