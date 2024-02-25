import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic joke;
  getjoke() {
    http
        .get(Uri.parse("https://official-joke-api.appspot.com/random_joke"))
        .then((value) => jsonDecode(value.body))
        .then((val) => joke);
    print(joke);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project"),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
    );
  }

  void fetchUsers() {
    print("users fetched");
  }
}
