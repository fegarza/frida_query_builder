class ForeignKey {
  final String referencedTable;
  final String referencedColumn;

  ForeignKey({
    required this.referencedTable,
    required this.referencedColumn,
  });
}