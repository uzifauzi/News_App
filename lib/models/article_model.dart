import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/models/source_model.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  final SourceModel? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  ArticleModel(this.source, this.author, this.title, this.description, this.url,
      this.urlToImage, this.publishedAt, this.content);

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}
