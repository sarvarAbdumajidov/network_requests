import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:network_requests/service/http_service.dart';
import 'package:network_requests/service/log_service.dart';

import '../model/post_model.dart';

class NetworkPage extends StatefulWidget {
  static const String id = '/network_page';

  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  bool isLoading = false;
  List items = [];

  void _apiPostLIst() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      setState(() {
        isLoading = false;
        items = Network.parsePostList(response);
      });
    } else {}
  }

  void _apiPostCreate(Post post) {
    Network.POST(Network.API_CREATE, Network.paramsCreate(post))
        .then((response) => {LogService.i(response.toString())});
  }

  void _apiPostUpdate(Post post) {
    Network.PUT(Network.API_UPDATE + post.id.toString(), Network.paramsUpdate(post))
        .then((response) => {LogService.i(response.toString())});
  }

  void _apiPostDelete(Post post) {
    Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    _apiPostLIst();
  }

  @override
  void initState() {
    super.initState();
    // var post = Post(id: 10, title: 'og\'riq bormi', body: 'hi', userId: 7);
    // _apiPostCreate(post);
    _apiPostLIst();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        LogService.i('width: $width, height: $height');
      }),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Networking',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return itemHomePost(items[index]);
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget itemHomePost(Post post) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              //delete api
              _apiPostDelete(post);
            },
            flex: 3,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: CupertinoIcons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title!.toUpperCase(),
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(post.body!),
          ],
        ),
      ),
    );
  }
}
