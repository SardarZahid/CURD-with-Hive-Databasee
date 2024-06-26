import 'package:hive/hive.dart';

part 'userModel.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String password;

  @HiveField(2)
  late String email;
}

@HiveType(typeId: 1)
class NotesModel extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late String userId;

  NotesModel({
    required this.title,
    required this.description,
    required this.userId,
  });
}
