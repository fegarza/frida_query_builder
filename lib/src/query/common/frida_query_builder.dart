import 'package:frida_query_builder/src/query/create/create_query_builder.dart';
import 'package:frida_query_builder/src/query/criterion/criteria_query_builder.dart';
import 'package:frida_query_builder/src/query/insert/insert_query_builder.dart';
import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/common/query_builder.dart';
import 'package:frida_query_builder/src/query/common/statement.dart';
import 'package:frida_query_builder/src/query/create/create.dart';
import 'package:frida_query_builder/src/query/insert/insert.dart';

class FridaQueryBuilder implements QueryBuilder {
  Statement statement;

  FridaQueryBuilder(this.statement);

  QueryBuilder _getQueryBuilder() {
    if (statement is CriteriaStatement) {
      return CriteriaQueryBuilder(statement as CriteriaStatement);
    }
    if (statement is Insert) {
      return InsertQueryBuilder(statement as Insert);
    }
    if (statement is Create) {
      return CreateQueryBuilder(statement as Create);
    }
    throw Exception();
  }

  @override
  String build() {
    return _getQueryBuilder().build();
  }
}
