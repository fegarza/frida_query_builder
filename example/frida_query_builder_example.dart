import 'package:frida_query_builder/frida_query_builder.dart';

void main() {
  //Create table
  print(
    FridaQueryBuilder(
      Create(
        tableName: "students",
        columns: [
          Column(
              name: "student_id",
              type: ColumnDataType.integer,
              isAutoIncrement: true,
              isPrimaryKey: true),
          Column(
            name: "name",
            type: ColumnDataType.text,
          ),
          Column(
            name: "email",
            type: ColumnDataType.text,
            isNotNull: true,
          ),
        ],
      ),
    ).build(),
  );
  /*
    Output:
    CREATE TABLE students (
      id INTEGER AUTO INCREMENT  ,
      name TEXT  ,
      email TEXT NOT NULL ,
      PRIMARY KEY ( id)
    );
  */

  //Select query
  print(
    FridaQueryBuilder(
      Select(
        from: "students",
      ),
    ).build(),
  );
  /* 
    Output:
    SELECT * FROM person
  */

  // Select complex query
  print(
    FridaQueryBuilder(
      Select(
        from: "students",
        columns: [
          Field("s.name"),
          Field("s.student_id"),
          Field("s.email"),
          Field('"Text" AS simpleText '),
          2,
          2.22,
          "Text x2"
        ],
        joins: [
          Join(
            "student_classes",
            alias: "c",
            criteria: [
              Equals(
                Field("c.student_id"),
                Field("s.student_id"),
              ),
              NotEquals(
                Field("c.description"),
                "math",
              ),
            ],
          )
        ],
        alias: "s",
        limit: 2,
        offset: 3,
        orderBy: ["c.description"],
        criteria: [
          In(Field("s.name"), ["Felipe", "Juan"]),
          Or(
            [
              Equals("b", "b"),
              And([Equals("1", "1"), Equals("1", "1")])
            ],
          )
        ],
      ),
    ).build(),
  );

  print(
    FridaQueryBuilder(
      Update(
        table: "students",
        values: {"name": "Juan"},
        criteria: [
          Equals(Field("name"), "Felipe"),
        ],
      ),
    ).build(),
  );

  print(
    FridaQueryBuilder(
      Delete(
        table: "students",
        criteria: [
          Equals(Field("name"), "Felipe"),
        ],
      ),
    ).build(),
  );
}
