import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restapi_flutter_newsapp/models/news.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<News> news = [];

  fetchNews() async {
    Dio _dio = Dio();
    var res = await _dio.get("https://hubblesite.org/api/v3/news");
    res.data.forEach((ele) => news.add(News.fromJson(ele)));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  void goToNews(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      debugPrint("Error while launching url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Flutter Rest API"),
        ),
        body: news.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  News singleNews = news[index];
                  return Card(
                    child: ListTile(
                      trailing: IconButton(
                        icon: Icon(Icons.launch),
                        onPressed: () {
                          goToNews(singleNews.url);
                        },
                      ),
                      title: Text(
                        "${singleNews.name}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(singleNews.newsId),
                      onTap: () async {
                        goToNews(singleNews.url);
                      },
                    ),
                  );
                }),
      ),
    );
  }
}
