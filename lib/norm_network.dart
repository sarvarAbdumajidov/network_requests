import 'dart:async';
import 'dart:convert';
import 'dart:io';


class Network {


  // class setting: singleton
  Network._();
  static final _instance = Network._();
  factory Network() => _instance;


  // object for connection network
  final _network = HttpClient();
  void close() => _network.close();



  // Methods

  /// Get
  Future<String> get(String baseUrl, String path, [int? id]) async {
    final url = Uri.https(baseUrl, "$path${id != null ? "/$id": ""}");
    final request = await _network.getUrl(url);
    request.headers.contentType = ContentType("application", "json", charset: "utf-8");
    final response = await request.close();
    String result = await response.transform(utf8.decoder).join();
    return result;
  }

  /// Post
  Future<String> post(String baseUrl, String path, Map<String, dynamic> body) async {
    final url = Uri.https(baseUrl, path);
    final request = await _network.postUrl(url);
    request.headers.contentType = ContentType("application", "json", charset: "utf-8");

    String data = jsonEncode(body);
    List<int> dataByte = utf8.encode(data);
    request.add(dataByte);

    final response = await request.close();
    String result = await response.transform(utf8.decoder).join();
    return result;
  }

  /// Put
  Future<String> put(String baseUrl, String path, int id, Map<String, dynamic> body) async {
    final url = Uri.https(baseUrl, "$path/$id");
    final request = await _network.putUrl(url);
    request.headers.contentType = ContentType("application", "json", charset: "utf-8");

    String data = jsonEncode(body);
    List<int> dataByte = utf8.encode(data);
    request.add(dataByte);

    final response = await request.close();
    String result = await response.transform(utf8.decoder).join();
    return result;
  }

  /// Patch
  Future<String> patch(String baseUrl, String path, int id, Map<String, dynamic> body) async {
    final url = Uri.https(baseUrl, "$path/$id");
    final request = await _network.patchUrl(url);
    request.headers.contentType = ContentType("application", "json", charset: "utf-8");

    String data = jsonEncode(body);
    List<int> dataByte = utf8.encode(data);
    request.add(dataByte);

    final response = await request.close();
    String result = await response.transform(utf8.decoder).join();
    return result;
  }


  /// Delete
  Future<String> delete(String baseUrl, String path, int id) async {
    final url = Uri.https(baseUrl, "$path/$id");
    final request = await _network.deleteUrl(url);
    request.headers.contentType = ContentType("application", "json", charset: "utf-8");
    final response = await request.close();
    String result = await response.transform(utf8.decoder).join();
    return result;
  }

  List<Post> parseAllPost(String data) {
    List post = jsonDecode(data);
    List<Post> posts = post.map<Post>((map) => Post.fromJson(map)).toList();
    return posts;
  }
}

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post(this.userId, this.id, this.title, this.body);

  factory Post.fromJson(Map<String , dynamic> json){
    int userId = json["userId"];
    int id = json["id"];
    String title = json["title"];
    String body = json["body"];
    return Post(userId, id, title, body);
  }

  Map<String , dynamic> toJson() => {
    "userId"  : userId,
    "id" : id,
    "title" : title,
    "body" : body,
  };

  @override
  String toString() {
    return 'Post{userId: $userId, id: $id, title: $title, body: $body}';
  }
}

enum Api {
  post("/posts"),
  comments("/comments"),
  albums("/albums"),
  photos("/photos"),
  todos("/todos"),
  products("/products");

  const Api(this.path);
  final String path;

  static const baseUrl = "jsonplaceholder.typicode.com";
}