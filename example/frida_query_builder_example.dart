import 'package:frida_query_builder/frida_query_builder.dart';
import 'package:frida_query_builder/src/query/common/statement.dart';

void main() {
  Statement statement;

  statement = Create(
    tableName: "students",
    columns: [
      Column(
        name: "student_id",
        type: ColumnDataType.integer,
        isAutoIncrement: true,
        isPrimaryKey: true,
      ),
      Column(
        name: "name",
        type: ColumnDataType.text,
        isNotNull: true,
        defaultValue: "2",
      ),
      Column(
        name: "email",
        type: ColumnDataType.text,
        isNotNull: true,
      ),
    ],
  );

  print(FridaQueryBuilder(statement).build());
  /* OUTPUT:
  CREATE TABLE students (
  student_id INTEGER AUTO INCREMENT  ,
  name TEXT NOT NULL DEFAULT("2")  ,
  email TEXT NOT NULL ,
  PRIMARY KEY ( student_id)
  );
  */

  statement = Select(from: "students");

  print(FridaQueryBuilder(statement).build());
  /* OUTPUT:
  SELECT *
  FROM students 
  */

  statement = Select(
    from: "students",
    alias: "s",
    columns: [
      "name".field,
      "age".field,
      "gender".field,
      "Simple Text",
      22,
    ],
  );

  print(FridaQueryBuilder(statement).build());
  /* OUTPUT:
  SELECT name , age , gender , "Simple Text" , 22
  FROM students AS s
  */

  statement = Select(
    from: "students",
    columns: [
      "s.name".field,
      "s.student_id",
      "s.email",
      '"Text" AS simpleText',
      2.field,
      2.22.field,
      "Text x2",
    ],
    joins: [
      Join(
        "student_classes",
        alias: "c",
        criteria: [
          Equals("c.student_id".field, "s.student_id".field),
          NotEquals("c.description".field, "math"),
        ],
      )
    ],
    alias: "s",
    limit: 2,
    offset: 3,
    orderBy: ["c.description"],
    criteria: [
      In("s.name".field, ["Felipe", "Juan"]),
      Or(
        [
          Equals("b", "b"),
          And([Equals("1", "1"), Equals("1", "1")])
        ],
      )
    ],
  );

  print(FridaQueryBuilder(statement).build());
  /* OUTPUT:
  SELECT s.name , "s.student_id" , "s.email" , ""Text" AS simpleText" , 2 , 2.22 , "Text x2"
  FROM students AS s
  INNER JOIN student_classes AS c
  ON  c.student_id = s.student_id  AND  c.description <> "math" 
  WHERE  s.name IN ( "Felipe" , "Juan" )  OR (  "b" = "b"  AND (  "1" = "1"  AND  "1" = "1"  )  ) 
  ORDER BY c.description
  LIMIT 2 OFFSET 3
  */

  statement = Update(
    table: "students",
    values: {"name": "Juan"},
    criteria: [
      Equals("name".field, "Felipe"),
    ],
  );
  print(FridaQueryBuilder(statement).build());
  /* OUTPUT:
  UPDATE students SET name = "Juan" 
  WHERE  name = "Felipe" 
  */

  statement = Delete(
    table: "students",
    criteria: [
      Equals("name".field, "Felipe"),
    ],
  );
  print(FridaQueryBuilder(statement).build());
  /* OUTPUT:
  DELETE students 
  WHERE  name = "Felipe"
  */
}
