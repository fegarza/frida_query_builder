import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';

abstract class CriterionQueryBuilder implements QueryBuilder {
  Criterion criterion;

  CriterionQueryBuilder(this.criterion);
}
