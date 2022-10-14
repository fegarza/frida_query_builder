import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';
import 'package:frida_query_builder/src/query/select/join.dart';

class Select extends CriteriaStatement {
  List<String> columns;
  List<String> orderBy;
  List<String> groupBy;
  List<Join> joins;
  String? alias;

  int? limit;
  int? offset;

  Select({
    required String from,
    this.columns = const [],
    this.groupBy = const [],
    this.orderBy = const [],
    this.joins = const [],
    this.alias,
    this.limit,
    this.offset,
    List<Criterion> criteria = const [],
  }) : super(
          from,
          criteria: criteria,
        );
}
