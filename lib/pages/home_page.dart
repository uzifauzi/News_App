import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/api_service.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/pages/news_webview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NewsModel? _newsModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() async {
    var _moreNews = (await ApiService().getNews());

    setState(() {
      _newsModel = _moreNews;
    });

    // print(_newsModel?.articles[0].author ?? "-");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'WEDNESDAY, NOVEMBER 29',
                          style: GoogleFonts.roboto(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Top News',
                          style: GoogleFonts.roboto(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/avatar.png',
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    contentPadding: EdgeInsets.all(8.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Color(0xffdbdbdb),
                    label: Text('Search'),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FutureBuilder(
                  builder: (ctx, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occured',
                          style: GoogleFonts.roboto(fontSize: 18),
                        ),
                      );
                    } else {
                      if (snapshot.hasData) {
                        final data = snapshot.data as NewsModel;
                        final articles = data.articles;
                        return ListView.builder(
                            itemCount: 7,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (articles[index].source != null)
                                            Container(
                                              padding: EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        Colors.blue,
                                                        Colors.red,
                                                      ])),
                                              child: Text(
                                                articles[index].source!.name ??
                                                    "name",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          InkWell(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    NewsWebview(
                                                  title:
                                                      articles[index].title ??
                                                          "Title",
                                                  url: articles[index].url ??
                                                      "google.com",
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              articles[index].title ?? "-",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (articles[index].urlToImage != null)
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.network(
                                          articles[index].urlToImage!,
                                          width: 120,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                  ],
                                ),
                              );
                            });
                      }
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  future: ApiService().getNews(),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'nyoba doang',
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
