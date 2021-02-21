import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jsonparsing/model/post.dart';

class JsonParsingMap extends StatefulWidget {
  @override
  _JsonParsingMapState createState() => _JsonParsingMapState();
}

class _JsonParsingMapState extends State<JsonParsingMap> {
  Future<PostList> data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Network network = Network("https://jsonplaceholder.typicode.com/posts");
    data = network.loadposts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("P-O-D-O"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: data,
              builder: (context, AsyncSnapshot<PostList> snapshot) {
                List<Post> allposts;
                if (snapshot.hasData) {
                  allposts = snapshot.data.posts;
                  return CreateListView(allposts, context);
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }

  Widget CreateListView(List<Post> data, BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, int index) {
            return Column(
              children: <Widget>[
                Divider(
                  height: 10.0,
                ),
                ListTile(
                  title: Text("${data[index].title}"),
                  subtitle: Text("${data[index].body}"),
                  leading: Column(children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 23,
                      child: Text("${data[index].id}"),
                    )
                  ]),
                ),
              ],
            );
          }),
    );
  }
}

class Network {
  final String url;

  Network(this.url);

  Future<PostList> loadposts() async {
    final response = await get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      //OK
      return PostList.fromJson(json.decode(response.body)); //We get json object
    } else {
      throw Exception("Failed to get posts");
    }
  }
}
