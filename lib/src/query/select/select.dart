import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';
import 'package:frida_query_builder/src/query/select/join.dart';

export 'package:frida_query_builder/src/query/select/join.dart';

class Select extends CriteriaStatement {
  List<Object> columns;
  List<String> orderBy;
  List<String> groupBy;
  List<Join> joins;
  String? alias;

  int? limit;
  int? offset;
  bool distinct;
  List<Criterion> having;

  Select({
    required String from,
    this.columns = const [],
    this.groupBy = const [],
    this.orderBy = const [],
    this.joins = const [],
    this.alias,
    this.limit,
    this.offset,
    this.having = const [],
    this.distinct = false,
    List<Criterion> where = const [],
  }) : super(
          from,
          criteria: where,
        );

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitSelect(this);
  }
}
