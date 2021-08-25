import 'package:dont_forget_me/model/subItemInfo.dart';
import 'package:flutter/cupertino.dart';

class ItemInfo{
  ItemInfo({required this.itemTitle, this.isDone = false,required this.subitemlist});

  String itemTitle;
  bool isDone;
  List<SubItemInfo> subitemlist;
  bool existSub = false;
  bool showSub = true;

  bool subAllDone(){
    bool result = true;
    for(int i = 0; i<subitemlist.length;i++){
      if(subitemlist[i].isDone == false){
        result = false;
        break;
      }
    }
    return result;
  }

  void setItemTitle(String input){
    itemTitle = input;
  }
}