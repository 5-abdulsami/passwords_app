
class Password {
  int? id;
  String title;
  String username;
  String password;
  String createdAt;

  Password({
    this.id,
    required this.title,
    required this.username,
    required this.password,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'username': username,
      'password': password,
      'created_at': createdAt,
    };
  }

  factory Password.fromMap(Map<String, dynamic> map) {
    return Password(
      id: map['id'],
      title: map['title'],
      username: map['username'],
      password: map['password'],
      createdAt: map['created_at'],
    );
  }

  // To JSON for backup
  Map<String, dynamic> toJson() => toMap();
  
  // From JSON for restore
  factory Password.fromJson(Map<String, dynamic> json) => Password.fromMap(json);
}
