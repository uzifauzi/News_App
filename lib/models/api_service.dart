import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:news_app/models/constants.dart';
import 'package:news_app/models/news_model.dart';
import 'package:flutter/services.dart';

class ApiService {
  Future<List<NewsModel>?> getMoreNews() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var _model = moreNewsModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<NewsModel?> getNews(String z) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint + '/$z');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var _model = NewsModel.fromJson(jsonDecode(response.body));
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
