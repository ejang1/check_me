import 'package:flutter/cupertino.dart';

class SubItemInfo{
  SubItemInfo({required this.itemTitle,this.isDone = false});

  String itemTitle;
  bool isDone;

  void setSubItemTitle(String input){
    itemTitle = input;
  }
}