class MapBoxCredentails {
  static const _publicToken =
      "pk.eyJ1IjoiY3hib3kiLCJhIjoiY2tuMG42cWt1MHA1cjJvbWx6eWgxY3EydyJ9.T7lj-QG1SkJCGjzXJo90aA";

  static const _urlTemplate =
      "https://api.mapbox.com/styles/v1/cxboy/cktmmwfmf1axb18utckd7rmil/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY3hib3kiLCJhIjoiY2tuMG42cWt1MHA1cjJvbWx6eWgxY3EydyJ9.T7lj-QG1SkJCGjzXJo90aA";

  static const _styleString = "mapbox://styles/cxboy/cktmmwfmf1axb18utckd7rmil";

  static const _tilesetId = "mapbox.country-boundaries-v1";

  String get publicToken => _publicToken;
  String get urlTemplate => _urlTemplate;
  String get tilesetId => _tilesetId;
  String get styleString => _styleString;
}
