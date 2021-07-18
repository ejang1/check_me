import 'package:dont_forget_me/model/subItemInfo.dart';

class ItemInfo{
  ItemInfo({required this.itemTitle, this.isDone = false, required this.subitemlist});

  final String itemTitle;
  bool isDone;
  List<SubItemInfo> subitemlist;
}