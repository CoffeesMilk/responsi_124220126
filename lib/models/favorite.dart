import 'package:hive/hive.dart';
import 'package:responsi_124220126/pages/registerpage.dart';
part 'favorite.g.dart';

@HiveType(typeId: 0)
class favorite extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  late String like;

  favorite({
    required this.like,
  });
}
