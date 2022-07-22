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
  String _title = '';
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

    print(_newsModel?.articles[0].author ?? "-");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  const CircleAvatar(
                    backgroundColor: Colors.green,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.done) if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occured',
                        style: GoogleFonts.roboto(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data as NewsModel;
                    return ListView.builder(
                        itemCount: 7,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(data.articles[index].title ?? "-"),
                                      InkWell(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewsWebview(
                                              title:
                                                  data.articles[index].title ??
                                                      "Title",
                                              url: data.articles[index].url ??
                                                  "google.com",
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          data.articles[index].url ?? "-",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (data.articles[index].urlToImage != null)
                                  Image.network(
                                    data.articles[index].urlToImage!,
                                    width: 100,
                                    height: 100,
                                  )
                              ],
                            ),
                          );
                        });
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                future: ApiService().getNews(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
