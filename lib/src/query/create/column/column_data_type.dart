enum ColumnDataType {
  integer,
  text,
  real,
  blob
}

extension ColumnDataTypeExtension on ColumnDataType {
  String getString() {
    switch (this) {
      case ColumnDataType.integer:
        return 'INTEGER';
      case ColumnDataType.text:
        return 'TEXT';
      case ColumnDataType.real:
        return "REAL";
      case ColumnDataType.blob:
        return "BLOB";
    }
  }
}
