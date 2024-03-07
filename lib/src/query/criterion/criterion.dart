abstract class Criterion {
  String criterionOperator;
  final bool firstFieldQuoted;
  final bool secondFieldQuoted;
  Criterion(
    this.criterionOperator, {
    this.firstFieldQuoted = true,
    this.secondFieldQuoted = true,
  });
}
