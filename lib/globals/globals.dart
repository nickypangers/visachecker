import 'package:visa_checker/common/models/country.dart';

Country _country;

Country get currentCountry {
  return _country;
}

set currentCountry(Country country) {
  _country = country;
}
