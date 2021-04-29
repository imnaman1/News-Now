import 'package:flutter/material.dart';
import 'package:news_app/Backend/backend.dart';
import 'package:news_app/main.dart';
import 'package:news_app/web_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Backend/category_model.dart';

class CategoryNewsClass extends StatefulWidget {
  final String newsCategory;
  CategoryNewsClass(this.newsCategory);

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNewsClass> {
  List<CategoryModel> categories = [];
  var newsList;
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
    categories = getCategory();
  }

  getNews() async {
    CategoryNews categoryNews = CategoryNews();
    await categoryNews.getNewsForCategory(widget.newsCategory);
    newsList = categoryNews.newsList;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'News App',
          style: GoogleFonts.merriweather(
              fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        backgroundColor: Colors.grey[300],
        centerTitle: true,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 80.0,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            categories[index].categoryName,
                          );
                        }),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 130.0,
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              leading: newsList[index].urltoImage != null
                                  ? AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.network(
                                        newsList[index].urltoImage!,
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
                                        builder: (context) => NewsWebView(
                                            url: newsList[index].url)));
                              },
                              isThreeLine: true,
                              title: Text(
                                newsList[index].title,
                                maxLines: 3,
                              ),
                              subtitle: newsList[index].description != null
                                  ? Text(
                                      newsList[index].description!,
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
                                          builder: (context) => NewsWebView(
                                              url: newsList[index].url)));
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
                    },
                  )
                ],
              ),
            ),
    );
  }
}
