class User {
  bool admin;

  User(this.admin);
  Map<String, dynamic> toJson() => {'admin': admin};
}
