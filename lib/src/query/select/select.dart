import 'package:frida_query_builder/src/query/common/criteria_statement.dart';
import 'package:frida_query_builder/src/query/common/statement_visitor.dart';
import 'package:frida_query_builder/src/query/criterion/criterion.dart';
import 'package:frida_query_builder/src/query/select/join.dart';

export 'package:frida_query_builder/src/query/select/join.dart';

/// Represents an SQL SELECT statement.
///
/// Use the constructor for basic settings and fluent methods to chain more configuration.
class Select extends CriteriaStatement {
  /// The columns to select. Can be [String], [Field], or [Operator].
  List<Object> columns;

  /// The columns to use in the ORDER BY clause. Can be [String], [Field], [Operator], or [Sort].
  List<Object> orderBy;

  /// The columns to use in the GROUP BY clause.
  List<String> groupBy;

  /// The joins to perform.
  List<Join> joins;

  /// Optional alias for the table listed in [from].
  String? alias;

  /// The maximum number of rows to return.
  int? limit;

  /// The number of rows to skip before starting to return rows.
  int? offset;

  /// Whether to use the DISTINCT keyword.
  bool distinct;

  /// List of criteria for the HAVING clause.
  List<Criterion> having;

  Select({
    String? from,
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
          criteria: [...where],
        );

  /// Appends [columns] to the select list.
  Select addColumns(List<Object> columns) {
    this.columns = [...this.columns, ...columns];
    return this;
  }

  /// Replaces existing select list with [columns].
  Select setColumns(List<Object> columns) {
    this.columns = columns;
    return this;
  }

  /// Appends [criteria] to the WHERE clause using an AND connector.
  Select where(List<Criterion> criteria) {
    this.criteria = [...this.criteria, ...criteria];
    return this;
  }

  /// Appends [columns] to the GROUP BY clause.
  Select groupByColumns(List<String> columns) {
    this.groupBy = [...this.groupBy, ...columns];
    return this;
  }

  /// Appends [columns] to the ORDER BY clause.
  Select orderByColumns(List<Object> columns) {
    this.orderBy = [...this.orderBy, ...columns];
    return this;
  }

  /// Sets the LIMIT value.
  Select setLimit(int limit) {
    this.limit = limit;
    return this;
  }

  /// Sets the OFFSET value.
  Select setOffset(int offset) {
    this.offset = offset;
    return this;
  }

  /// Sets whether the query is DISTINCT.
  Select setDistinct(bool distinct) {
    this.distinct = distinct;
    return this;
  }

  /// Adds a [join] to the query.
  Select addJoin(Join join) {
    this.joins = [...this.joins, join];
    return this;
  }

  /// Adds an INNER JOIN to the query.
  Select innerJoin(String table, {required List<Criterion> on, String? alias}) {
    return addJoin(
        Join(table, type: JoinType.inner, criteria: on, alias: alias));
  }

  /// Adds a LEFT JOIN to the query.
  Select leftJoin(String table, {required List<Criterion> on, String? alias}) {
    return addJoin(
        Join(table, type: JoinType.left, criteria: on, alias: alias));
  }

  /// Appends [criteria] to the HAVING clause.
  Select havingCriteria(List<Criterion> criteria) {
    this.having = [...this.having, ...criteria];
    return this;
  }

  @override
  T accept<T>(StatementVisitor<T> visitor) {
    return visitor.visitSelect(this);
  }
}
