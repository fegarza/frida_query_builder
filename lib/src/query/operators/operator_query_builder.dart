import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/field_query_builder.dart';
import 'package:frida_query_builder/src/query/operators/operator.dart';

class OperatorQueryBuilder extends QueryBuilder {
  final Operator operator;

  OperatorQueryBuilder(this.operator);

  @override
  String build() {
    final leftBuilder = FieldQueryBuilder(operator.left, quoted: false);
    final rightBuilder = FieldQueryBuilder(operator.right, quoted: false);

    return '${leftBuilder.build()} ${operator.operator} ${rightBuilder.build()}';
  }
}
