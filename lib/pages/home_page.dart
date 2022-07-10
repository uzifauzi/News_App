import 'package:flutter/material.dart';
import 'package:news_app/models/api_service.dart';
import 'package:news_app/models/news_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _title = '';
  List<NewsModel> _newsModel = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() async {
    var _moreNews = (await ApiService().getMoreNews())!;

    setState(() {
      _newsModel = _moreNews;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Judul Berita'),
      ),
    );
  }
}
