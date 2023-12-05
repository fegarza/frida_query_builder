import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/field_query_builder.dart';

class CriterionCompareQueryBuilder extends CriterionQueryBuilder {
  CriterionCompare criterionCompare;

  CriterionCompareQueryBuilder(
    this.criterionCompare, {
    this.quoted = true,
  }) : super(
          criterionCompare,
        );

  /// Indicates if the comparison is a database object, which means it should not be wrapped with "".</br>
  /// It must be used on joins and other operations
  /// where you are referencing something the following way: tableName.field</br>
  /// By default it's false
  final bool quoted;

  @override
  String build() {
    criterion = criterion as CriterionCompare;

    return " ${FieldQueryBuilder(
      criterionCompare.firstField,
      quoted: quoted,
    ).build()} ${criterionCompare.criterionOperator} ${FieldQueryBuilder(
      criterionCompare.secondField,
      quoted: quoted,
    ).build()} ";
  }
}
