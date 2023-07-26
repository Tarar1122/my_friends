import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'friends_model.g.dart';

@HiveType(typeId: 0)
class FriendsModel {

  @HiveField(0)
  Uint8List? friendImage;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? number;

  @HiveField(3)
  String? description;

  FriendsModel(
    this.friendImage,
    this.name,
    this.number,
    this.description,
  );
}
