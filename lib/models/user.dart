import 'package:hive/hive.dart';
import 'package:responsi_124220126/pages/registerpage.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class user extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  late String username;

  @HiveField(2)
  late String password;

  @HiveField(3)
  List<String> like;

  user({
    this.username = '',
    this.password = '',
    this.like = const [''],
  });
}
