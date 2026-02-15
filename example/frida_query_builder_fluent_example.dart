import 'package:frida_query_builder/frida_query_builder.dart';

void main() {
  var artistsTable = Create(tableName: "artists")
      .addColumn(ColumnInteger(name: "id", isAutoIncrement: true))
      .addColumn(ColumnText(name: "name", isNotNull: true))
      .addColumn(ColumnText(name: "country", isNotNull: true))
      .addColumn(
          ColumnText(name: "created_at", defaultValue: CurrentTimestamp()))
      .build();

  print(artistsTable);

  var alterArtistTable =
      AddColumn("artists", ColumnText(name: "birth_date")).build();

  print(alterArtistTable);

  var songsTable = Create(tableName: "songs")
      .addColumn(ColumnInteger(name: "id", isAutoIncrement: true))
      .addColumn(ColumnText(name: "title", isNotNull: true))
      .addColumn(
          ColumnText(name: "created_at", defaultValue: CurrentTimestamp()))
      .build();

  print(songsTable);

  var songsArtistsTable = Create(tableName: "songs_artists")
      .addColumn(ColumnInteger(
          name: "song_id",
          isPrimaryKey: true,
          foreignKey:
              ForeignKey(referencedTable: "songs", referencedColumn: "id")))
      .addColumn(ColumnInteger(
          name: "artist_id",
          isPrimaryKey: true,
          foreignKey:
              ForeignKey(referencedTable: "artists", referencedColumn: "id")))
      .build();

  print(songsArtistsTable);

  var insertArtists = Insert(into: "artists").addRows([
    {"name": "Luis Miguel", "country": "Mexico", "birth_date": "1970-04-19"},
    {"name": "Frank Sinatra", "country": "USA", "birth_date": "1915-12-12"},
    {"name": "Cristian Castro", "country": "Mexico", "birth_date": "1974-12-08"}
  ]).build();

  print(insertArtists);

  var songs = Insert(into: "songs").addRows([
    {"title": "Sol, arena y mar"},
    {"title": "Quiero"},
    {"title": "Labios de miel"},
    {"title": "No podras"},
    {"title": "Hoy el aire huele a ti"},
    {"title": "Oro de ley"},
    {"title": "Come Fly With Me"},
  ]).build();

  print(songs);

  var insertSongsArtists = Insert(into: "songs_artists").addRows([
    {"song_id": 1, "artist_id": 1},
    {"song_id": 2, "artist_id": 1},
    {"song_id": 3, "artist_id": 1},
    {"song_id": 4, "artist_id": 3},
    {"song_id": 5, "artist_id": 1},
    {"song_id": 6, "artist_id": 1},
    {"song_id": 7, "artist_id": 1},
    {"song_id": 7, "artist_id": 2},
  ]).build();

  print(insertSongsArtists);

  var selectReport = Select(from: "artists")
      .setColumns([
        "artists.name".f,
        "artists.country".f,
        "artists.birth_date".f,
        "COUNT(songs_artists.song_id)".f.as("song_count"),
      ])
      .innerJoin(
        "songs_artists",
        on: [
          "artists.id".f.equals("songs_artists.artist_id".f),
        ],
      )
      .innerJoin(
        "songs",
        on: [
          "songs_artists.song_id".f.equals("songs.id".f),
        ],
      )
      .groupByColumns(["artists.id"])
      .orderByColumns([
        "artists.name".f.asc,
      ])
      .setLimit(10)
      .setOffset(1)
      .build();

  print(selectReport);
}
