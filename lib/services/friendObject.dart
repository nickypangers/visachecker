class Friend {

  String name;
  String country;

  Friend({this.name, this.country});

  Friend.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'country': country,
  };

}