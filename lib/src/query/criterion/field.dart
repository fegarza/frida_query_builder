class Field {
  String field;
  String? alias;

  Field(this.field, {this.alias});

  Field as(String alias) {
    this.alias = alias;
    return this;
  }
}
