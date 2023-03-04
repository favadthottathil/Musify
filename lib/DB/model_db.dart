import 'package:hive/hive.dart';
part 'model_db.g.dart';

@HiveType(typeId: 1)
class SongsDB extends HiveObject {
  SongsDB({required this.name, required this.songid,this.count});

  @HiveField(0)
  String name;

  @HiveField(1)
  List<int> songid;

  @HiveField(2)
  int? count;

  add(int id) async {
    if (!songid.contains(id)) {
      songid.add(id);
      save();
    }
  }

  deletedata(int id) async {
    songid.remove(id);
    save();
  }

  bool isvalue(int id) {
    return songid.contains(id);
  }
}
