import 'package:http/http.dart' as http;
import 'package:lets_earn/Model/signin_model.dart';

class RemoteService {

  static var client = http.Client();

  static Future post({required String key,required Map body}) async {
  String baseUrl = "https://letsearn.online/account/api/";
    var response = await client
        .post(Uri.parse(baseUrl+key), body: body);

    if (response.statusCode == 200) {
      var data = response.body;
      return data;
    } else {
      return null;
    }
  }
  static Future get({required String key}) async {
  String baseUrl = "https://letsearn.online/account/api/";
    var response = await client
        .post(Uri.parse(baseUrl+key));

    if (response.statusCode == 200) {
      var data = response.body;
      return data;
    } else {
      return null;
    }
  }
}
