class Friend {

  String name;
  String country;
  String result;

  Friend({this.name, this.country, this.result});

  Friend.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'country': country,
    'result': result,
  };

}