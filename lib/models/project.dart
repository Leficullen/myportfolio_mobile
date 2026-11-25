import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// The project schema exposed by the portfolio's Django API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    this.id,
    required this.title,
    required this.description,
    required this.techStack,
    this.urlLink = '',
    this.image = '',
  });

  @JsonKey(includeToJson: false)
  final String? id;
  final String title;
  final String description;
  final String techStack;
  @JsonKey(defaultValue: '')
  final String urlLink;
  @JsonKey(defaultValue: '')
  final String image;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
