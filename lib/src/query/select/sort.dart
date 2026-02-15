/// Represents the order of sorting.
enum OrderBy {
  /// Ascending order.
  asc,

  /// Descending order.
  desc,
}

extension OrderByExtension on OrderBy {
  /// Returns the SQL representation of the order.
  String getString() {
    switch (this) {
      case OrderBy.asc:
        return 'ASC';
      case OrderBy.desc:
        return 'DESC';
    }
  }
}

/// Represents a sort configuration for an ORDER BY clause.
class Sort {
  /// The column/field to sort by.
  final Object column;

  /// The order of the sort.
  final OrderBy order;

  Sort(this.column, this.order);
}
