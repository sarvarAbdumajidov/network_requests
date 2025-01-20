import 'package:flutter/material.dart';
import 'package:network_requests/service/http_service.dart';
import 'package:network_requests/service/log_service.dart';

import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // _apiPostList();
    var post = Post(id: 1, title: 'easy', body: 'offline', userId: 1);
    // _apiPostCreate(post);
    // _apiPostUpdate(post);
    _apiPostDelete(post);
  }

  void _apiPostList() {
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
          LogService.i(response.toString()),
        });
  }

  void _apiPostCreate(Post post) {
    Network.POST(Network.API_CREATE, Network.paramsCreate(post))
        .then((response) => {
              LogService.i(response.toString()),
            });
  }

  void _apiPostUpdate(Post post) {
    Network.PUT(Network.API_UPDATE+post.id.toString(), Network.paramsUpdate(post))
        .then((response) => {
      LogService.i(response.toString()),
    });
  }

  void _apiPostDelete(Post post) {
    Network.DEL(Network.API_DELETE+post.id.toString(), Network.paramsEmpty())
        .then((response) => {
      LogService.i(response.toString()),
    });
  }

  void _showResponse() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
