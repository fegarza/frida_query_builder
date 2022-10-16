import 'package:frida_query_builder/frida_query_builder.dart';

void main() {
  print(
    FridaQueryBuilder(
      Create(
        tableName: "oc_vehiculo",
        columns: [
          Column(
            name: "id_vehiculo",
            type: ColumnDataType.integer,
            isAutoIncrement: true,
            isPrimaryKey: true,
            isNotNull: true,
          ),
          Column(
            name: "id_tipo_operacion",
            type: ColumnDataType.text,
            isPrimaryKey: true,
            isNotNull: true,
            defaultValue: "'0'"

          ),
        ],
      ),
    ).build(),
  );

  print(
    FridaQueryBuilder(
      Select(
        from: "oc_vehiculo",
        alias: "v",
        columns: ["a", "2"],
        offset: 2,
        limit: 3,
        joins: [
          Join(
            "fcliente",
            type: JoinType.left,
            alias: "c",
            criteria: [Equals("v.id_cliente", "c.id_cliente")],
          ),
        ],
        criteria: [
          Equals("v.numero_vehiculo", "'0004'"),
          Or([
            Equals("1", "1"),
            Or(
              [
                Equals("2", "2"),
                In("firstField", ["1", "2"])
              ],
            )
          ]),
          NotEquals("v.id_cliente", "'000078'")
        ],
      ),
    ).build(),
  );

  print(
    FridaQueryBuilder(
      Update(
        table: "oc_vehiculo",
        values: {"id_vehiculo": "'002'"},
        criteria: [
          Equals("v.numero_vehiculo", "'0004'"),
          Or([
            Equals("1", "1"),
            Or(
              [
                Equals("2", "2"),
              ],
            )
          ]),
          NotEquals("v.id_cliente", "'000078'")
        ],
      ),
    ).build(),
  );

  print(
    FridaQueryBuilder(
      Delete(
        table: "oc_vehiculo",
        criteria: [
          Equals("v.numero_vehiculo", "'0004'"),
          Or([
            Equals("1", "1"),
            Or(
              [
                Equals("2", "2"),
              ],
            )
          ]),
          NotEquals("v.id_cliente", "'000078'")
        ],
      ),
    ).build(),
  );
}
