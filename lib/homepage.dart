import 'dart:convert';
import 'package:flutter/material.dart';
import './api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  APIService client = APIService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<String> title = [];
          List<String> content = [];
          List<String> url = [];

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final res = jsonDecode(snapshot.data.body);
              List arts = ((res['articles'] ?? []) as List);
              for (var art in arts) {
                title.add(art['title']);
                content.add(art['content']);
                url.add(art['urlToImage'] ?? '');
              }
              break;
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
          return Center(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: title.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.grey.shade200,
                        Colors.grey.shade300,
                        Colors.grey.shade400,
                        Colors.grey.shade500,
                      ],
                    ),
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.5),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: url[index].isEmpty
                        ? Container(
                            color: Colors.black,
                            width: 100,
                            height: 100,
                          )
                        : Image.network(
                            url[index],
                            width: 100,
                            height: 100,
                          ),
                    title: Text(title[index]),
                    subtitle: Text(content[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
