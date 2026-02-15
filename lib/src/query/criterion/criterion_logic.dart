import 'package:frida_query_builder/src/query/common/statement_visitor.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';

abstract class CriterionLogic extends Criterion {
  List<Criterion> criteria;

  CriterionLogic(
    this.criteria,
    String criterionOperator,
  ) : super(criterionOperator);

  @override
  T accept<T>(StatementVisitor<T> visitor) => visitor.visitCriterionLogic(this);
}
