import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quotes/Quotes.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "Men Are men, vows are words, and words are wind. ";
  String author = "George R.R. Martin";
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quotes App"),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/mgs3.jpg"),
                  fit: BoxFit.cover)),
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 110,
              ),
              Container(
                  child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  ListTile(
                    title: Text(
                      '"' + text + '"',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: '.SF UI Display',
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(author,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  )
                ],
              )),
              SizedBox(
                height: 20,
              ),
              Visibility(
                  visible: _visible,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                      child: LinearProgressIndicator())),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text("Generate Quote"),
                onPressed: () {
                  setState(() {
                    _visible = true;
                  });
                  http
                      .get(Uri.parse(
                          "https://api.quotable.io/random?tags=famous-quotes"))
                      .then((response) {
                    var result = json.decode(response.body);
                    Quotes quote = Quotes.fromJSON(result);
                    setState(() {
                      _visible = false;
                      text = quote.content;
                      author = quote.author;
                    });
                  }).catchError((e) {
                    setState(() {
                      _visible = false;
                    });
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
