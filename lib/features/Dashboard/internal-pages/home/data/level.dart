class Level {
  int? id;
  String? name;

  Level({this.id, this.name});

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'],
      name: json['name'],
    );
  }
}



// class Level {
//   final int? id;
//   final String? name;

//   Level({this.id, this.name});
// }
