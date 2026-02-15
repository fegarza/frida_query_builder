import 'package:frida_query_builder/src/query/common/statement_visitor.dart';

abstract class Criterion {
  String criterionOperator;
  final bool firstFieldQuoted;
  final bool secondFieldQuoted;
  Criterion(
    this.criterionOperator, {
    this.firstFieldQuoted = true,
    this.secondFieldQuoted = true,
  });

  T accept<T>(StatementVisitor<T> visitor);
}
