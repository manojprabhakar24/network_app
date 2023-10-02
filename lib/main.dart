
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MyApp());
}

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/6'));
  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}


class Album {
  final String username;
  final String name;
  final String email;

  Album( {
    required this.name,
    required this.username,
    required this.email,
  });

  factory Album.fromJson(Map<String,dynamic> json) {
    return Album(
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}
class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          title:Text('Update Data'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState==ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data!.name),
                      Text(snapshot.data!.username),
                      Text(snapshot.data!.email),

                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }
              // By default, show a loading spinner.
              return  CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}