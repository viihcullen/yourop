class User {
  bool admin;
  bool meter; // usuario que pode comentar

  User(this.admin, this.meter);
  Map<String, dynamic> toJson() => {'admin': admin};
}
