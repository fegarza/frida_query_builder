enum JoinType {
  left,
  right,
  inner,
}

extension JoinTypeExtension on JoinType {
  String getString() {
    switch (this) {
      case JoinType.left:
        return 'LEFT JOIN';
      case JoinType.right:
        return 'RIGHT JOIN';
      case JoinType.inner:
        return "INNER JOIN";
    }
  }
}
