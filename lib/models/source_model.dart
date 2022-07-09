import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/builder.dart';

part 'source_model.g.dart';

@JsonSerializable()
class SourceModel {
  final String id;
  final String name;

  SourceModel(this.id, this.name);
}
