import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Backend/category_model.dart';
import 'package:news_app/ListTile/news_tile.dart';
import 'package:news_app/category_news.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'Backend/backend.dart';

void main() {
  final backend = Backend(
      hostUrl: 'https://newsapi.org/v2/top-headlines?country=in&apiKey=');
  runApp(MyApp(
    backend: backend,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.backend}) : super(key: key);

  final Backend backend;
  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: backend,
      child: MaterialApp(
        title: 'News_App',
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          duration: 2000,
          nextScreen: HomePage(),
          centered: true,
          splashIconSize: 400.0,
          backgroundColor: Colors.white,
          splash: 'assets/images/n..png',
          splashTransition: SplashTransition.scaleTransition,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({this.backend});

  final Backend? backend;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategory();
  }

  @override
  Widget build(BuildContext context) {
    final backend = Provider.of<Backend>(context);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'News App',
          style: GoogleFonts.merriweather(
              fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        backgroundColor: Colors.grey[300],
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: FutureBuilder<List<News>>(
                      future: backend.getNews(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else if (!snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Center(
                              child: Image.asset(
                                'assets/images/n.gif',
                                color: Colors.grey[300],
                                colorBlendMode: BlendMode.darken,
                              ),
                            ),
                          );
                        } else {
                          final data = snapshot.data!;
                          return ListView(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children: [
                              for (final news in data)
                                NewsTile(
                                  news: news,
                                )
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String categoryName;
  CategoryCard(this.categoryName);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNewsClass(
              categoryName.toLowerCase(),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
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
          child: Center(
            child: Text(categoryName),
          ),
        ),
      ),
    );
  }
}
