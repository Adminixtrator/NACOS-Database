class Session {
  String year;
  int id;

  Session({this.id, this.year});

  Session.fromJson(Map<String, dynamic> json) {
    year = json["year"];
    id = json["id"];
  }
}
