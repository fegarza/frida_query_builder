# 🔨 Frida query builder 

A dart library that helps you create SQLITE queries using statements and the builder design pattern.

## 📄 UML Diagram classes
<details>
<summary>Statements classes</summary>
<img src="https://raw.githubusercontent.com/fegarza/frida_query_builder/main/out/uml/statementClasses/statement_classes.png"/>
</details>
<details>
<summary>Builders classes</summary>
<img src="https://raw.githubusercontent.com/fegarza/frida_query_builder/main/out/uml/buildersClasses/builder_classes.png"/>
</details>


## 👉 Ussage

```dart
  void main(){

    //1. Create a statement instance (SELECT, UPDATE, DELETE, INSERT, CREATE)
    final selectStatement = Select(
      from: "students", 
      alias: "s", 
      columns: [
        "name".field,
        "age".field,
        "gender".field,
        "Simple Text",
        22
      ],
    );

    //2. Create a FridaQueryBuilder instance and pass the statement to the constructor
    final fridaQueryBuilder = FridaQueryBuilder(selectStatement);

    //3. Build and get yout query string
    final queryString = fridaQueryBuilder.build();

    print(queryString);

    /* 
      OUTPUT:
      SELECT name , age , gender , "Simple Text" , 22
      FROM students AS s
    */
  }

```

## 🧪 Examples

...