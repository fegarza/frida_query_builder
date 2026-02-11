import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';

class Update extends CriteriaStatement {
  Map<String, Object?> values;

  Update({
    required String table,
    List<Criterion> criteria = const [],
    required this.values,
  }) : super(
          table,
          criteria: [...criteria],
        );

  Update where(List<Criterion> criteria) {
    this.criteria = [...this.criteria, ...criteria];
    return this;
  }

  Update setValues(Map<String, Object?> values) {
    this.values = values;
    return this;
  }

  Update addValue(String column, Object? value) {
    this.values[column] = value;
    return this;
  }

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitUpdate(this);
  }
}
