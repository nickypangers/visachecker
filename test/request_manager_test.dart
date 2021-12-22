import 'package:test/test.dart';
import 'package:visachecker/common/models/country_list.dart';
import 'package:visachecker/common/models/visa.dart';
import 'package:visachecker/manager/request_manager.dart';

void main() {
  group("RequestManager", () {
    test(".getCountryList() returns CountryList.list length of 199", () async {
      final requestManager = RequestManager();
      CountryList countryList = await requestManager.getCountryList();
      expect(countryList.list!.length, equals(199));
    });

    test(
        ".getCountryVisaResult(\"HK\") returns CountryCategoryList total length of 198",
        () async {
      final requestManager = RequestManager();
      CountryCategoryList countryCategoryList =
          await requestManager.getCountryVisaResult("HK");

      int vfLength = countryCategoryList.getCountryCategoryListVfLength;
      int voaLength = countryCategoryList.getCountryCategoryListVoaLength;
      int vrLength = countryCategoryList.getCountryCategoryListVrLength;
      int cbLength = countryCategoryList.getCountryCategoryListCbLength;
      int naLength = countryCategoryList.getCountryCategoryListNaLength;

      int totalLength = vfLength + voaLength + vrLength + cbLength + naLength;

      expect(totalLength, equals(198));
    });

    test(".getVisaData() returns VisaData.data length of 199", () async {
      final requestManager = RequestManager();
      VisaData visaData = await requestManager.getVisaData();
      expect(visaData.data?.length, equals(199));
    });

    test(".getVisaInfo(\"HK\", \"GB\") returns non empty string", () async {
      final requestManager = RequestManager();
      VisaInfo visaInfo = await requestManager.getVisaInfo("HK", "GB");
      expect(visaInfo.getStatus, isNot(equals("")));
    });

    test(".getLatestAppVersion returns non empty string", () async {
      final requestManager = RequestManager();
      String latestAppVersion = await requestManager.getLatestAppVersion();
      print(latestAppVersion);
      expect(latestAppVersion, isNot(equals("")));
    });
  });
}
