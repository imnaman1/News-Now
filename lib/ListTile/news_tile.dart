import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Backend/backend.dart';
import 'package:news_app/web_view.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    Key? key,
    required this.news,
  }) : super(key: key);

  // final VoidCallback onTap;
  final News news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 130.0,
        width: MediaQuery.of(context).size.width * 0.75,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: news.urltoImage != null
                ? AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      news.urltoImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.question_answer,
                    color: Colors.grey,
                  ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsWebView(url: news.url)));
            },
            isThreeLine: true,
            title: Text(
              news.title,
              maxLines: 3,
            ),
            subtitle: news.description != null
                ? Text(
                    news.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                : Text('No description'),
            trailing: IconButton(
              icon: Icon(Icons.chevron_right_sharp),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsWebView(url: news.url)));
              },
            ),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.grey[300],
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500]!,
                offset: Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
            ]),
      ),
    );
  }
}
