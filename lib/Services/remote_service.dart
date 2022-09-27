import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class RemoteService {
  static var client = http.Client();

  static Future post({required String key, required var body}) async {
    String baseUrl = "https://letsearn.online/account/api/";
    var response = await client.post(Uri.parse(baseUrl + key), body: body);
    if (response.statusCode == 200) {
      var data = response.body;
      return data;
    } else {
      return null;
    }
  }

  static Future get({required String key}) async {
    String baseUrl = "https://letsearn.online/account/api/";
    var response = await client.post(Uri.parse(baseUrl + key));

    if (response.statusCode == 200) {
      var data = response.body;
      return data;
    } else {
      return null;
    }
  }

  static Future multipart(
      {String? path,
      File? file,
      required String key,
      required Map<String, String> body}) async {
    String baseUrl = "https://letsearn.online/account/api/";
    var request = http.MultipartRequest("POST", Uri.parse(baseUrl + key));
    request.fields.addAll(body);
    var stream = http.ByteStream(Stream.castFrom(file!.openRead()));
    var length = await file.length();

    var multipartFileSign = http.MultipartFile(
      'fileToUpload',
      stream,
      length,
      filename: file.path,
    );
    request.files.add(multipartFileSign);
    request.headers.addAll({"Content-Type": "multipart/form-data;"});
    var response = await request.send();
    var res = await response.stream.bytesToString();
    var data = json.decode(res);
    return data;
  }
}
