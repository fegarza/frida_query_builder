enum JoinType {
  left,
  inner,
}

extension JoinTypeExtension on JoinType {
  String getString() {
    switch (this) {
      case JoinType.left:
        return 'LEFT JOIN';
      case JoinType.inner:
        return "INNER JOIN";
    }
  }
}
