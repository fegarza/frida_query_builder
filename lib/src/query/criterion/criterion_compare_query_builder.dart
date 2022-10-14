import 'package:frida_query_builder/src/query/criterion/criterion_compare.dart';
import 'package:frida_query_builder/src/query/criterion/criterion_query_builder.dart';

class CriterionCompareQueryBuilder extends CriterionQueryBuilder {
  CriterionCompare criterionCompare;

  CriterionCompareQueryBuilder(this.criterionCompare) : super(criterionCompare);

  @override
  String build() {
    criterion = criterion as CriterionCompare;
    return " ${criterionCompare.firstField} ${criterionCompare.criterionOperator} ${criterionCompare.secondField} ";
  }
}
