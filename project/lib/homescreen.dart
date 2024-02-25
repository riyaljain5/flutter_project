// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:project/posts.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> posts = [];
  List<dynamic> images = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpost();
    getimage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(58, 43, 4, 46),
      appBar: AppBar(
        title: Center(
            child: Text(
          "Project",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        )),
        backgroundColor: Color.fromARGB(255, 42, 4, 45),
        actions: [
          Icon(Icons.camera_alt_outlined),
          Padding(padding: EdgeInsets.all(20))
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(226, 211, 183, 213),
        child: Column(
          children: [
            DrawerHeader(
                child: Icon(
              Icons.favorite,
              size: 48,
            )),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("H O M E"),
              // onTap: () {
              //   // Navigator.pop(context);
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => Homepage()));
              // },
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            final title = post['title'];
            final body = post['body'];

            final image = images[index];
            final imageurl = image['download_url'];

            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          // color: Color.fromARGB(226, 211, 183, 213),
                          // color: Colors.grey.withOpacity(0.5),
                          color: Color.fromARGB(58, 43, 4, 46),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromARGB(255, 42, 4, 45),
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    height: 500,
                    width: 500,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 20, top: 20),
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                color: Color.fromARGB(255, 43, 4, 46),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 300,
                          width: 500,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(226, 211, 183, 213),
                                  // color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(imageurl))),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              body,
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                                color: Color.fromARGB(255, 42, 4, 45),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  void getpost() async {
    const url = "https://jsonplaceholder.typicode.com/posts";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      posts = json;
    });
  }

  void getimage() async {
    const url = "https://picsum.photos/v2/list?page=2&limit=100";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      images = json;
    });
  }
}
