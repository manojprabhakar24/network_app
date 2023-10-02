import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final url="https://jsonplaceholder.typicode.com/posts";
  var _Mydata = [];
  void MyPost()async{
    try {
      final response = await get(Uri.parse(url));
      final MyData = jsonDecode(response.body) ;
      setState(() {
        _Mydata=MyData;
      });
    }catch(err) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
         title: Text("Network Fetched")
        ),
        body: ListView.builder(
            itemCount: _Mydata.length,
            itemBuilder: (context,index){
              final display=_Mydata[index];
              return Text("Title:${display["title"]}\n"
                    "Body:${display["body"]}\n");
            }
    ),
      ),
    );
  }
}

