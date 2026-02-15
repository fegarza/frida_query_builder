enum ForeignKeyAction {
  cascade,
  setNull,
  setDefault,
  restrict,
  noAction;

  String getString() {
    switch (this) {
      case ForeignKeyAction.cascade:
        return 'CASCADE';
      case ForeignKeyAction.setNull:
        return 'SET NULL';
      case ForeignKeyAction.setDefault:
        return 'SET DEFAULT';
      case ForeignKeyAction.restrict:
        return 'RESTRICT';
      case ForeignKeyAction.noAction:
        return 'NO ACTION';
    }
  }
}

class ForeignKey {
  final String referencedTable;
  final String referencedColumn;
  final ForeignKeyAction? onDelete;
  final ForeignKeyAction? onUpdate;

  ForeignKey({
    required this.referencedTable,
    required this.referencedColumn,
    this.onDelete,
    this.onUpdate,
  });
}
