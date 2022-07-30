import 'package:http/http.dart' as http;
import 'package:lets_earn/Model/signin_model.dart';

class RemoteService {
  static var client = http.Client();

  static Future signIn(String phone, String password) async {
    var response = await client.get(Uri.parse(
        "https://letsearn.online/account/api/signin_user.php?submit=&phone=$phone&password=$password"));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return signInModelFromJson(jsonString);
    } else {
      return null;
    }
  }
}
