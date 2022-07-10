import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/builder.dart';
import 'package:news_app/models/article_model.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel {
  final String status;
  final int totalResults;
  final ArticleModel articles;

  NewsModel(this.status, this.totalResults, this.articles);

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);
}
