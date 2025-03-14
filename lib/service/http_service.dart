import 'dart:convert';

import 'package:http/http.dart';
import 'package:network_requests/service/log_service.dart';

import '../model/post_model.dart';

class Network {
  static String BASE = "jsonplaceholder.typicode.com";

  static Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  /* HTTP Apis */

  static String API_LIST = '/posts';
  static String API_CREATE = '/posts';
  static String API_UPDATE = '/posts/'; // {id}
  static String API_DELETE = '/posts/'; // {id}

/* HTTP Requests */

  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 202) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
  /* HTTP Requests */

  static Map<String,String> paramsEmpty(){
    Map<String,String> params = {};
    return params;
  }

  static Map<String,String> paramsCreate(Post post){
    Map<String,String> params = {};
    params.addAll({


      'title':post.title!,
      'body':post.body!,
      'userId':post.userId.toString(),
    });
    return params;
  }

  static Map<String,String> paramsUpdate(Post post){
    Map<String,String> params = {};
    params.addAll({
      'id':post.id.toString(),
      'title':post.title!,
      'body':post.body!,
      'userId':post.userId.toString(),
    });
    LogService.w(params.toString());
    return params;
  }


  /* HTTP Requests */
}
