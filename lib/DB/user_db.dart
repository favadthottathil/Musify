import 'package:hive_flutter/adapters.dart';
part 'user_db.g.dart';

@HiveType(typeId: 0)
class UserDB {
  @HiveField(0)
  int? key;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String photo;

  UserDB({
    required this.name,
    required this.email,
    required this.photo,
    this.key,
  });
}
