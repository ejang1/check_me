import 'package:flutter/material.dart';
import 'sub_item_box.dart';
import 'button_icon.dart';
import 'constants.dart';

class ItemBox extends StatefulWidget {
  ItemBox({this.onSlide});
  final Function onSlide;
  @override
  _ItemBoxState createState() => _ItemBoxState();
}
class _ItemBoxState extends State<ItemBox> {
  bool tree = false;
  bool visible = true;
  List <SubItemBox> subItems = [];

  IconData iconStatus(){
    if(tree && visible) return showTree;
    else if (tree && visible == false) return hideTree;
    else return noTree;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragCancel: (){
      },
      child: Column(
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right:10),
                    child: TextField(
                    ),
                  ),
                ),
                Container(
                  child:ButtonIcon(
                icon: iconStatus(),
                onPress: (){
                  if(visible){
                    setState(() {
                      visible = false;
                    });
                  }
                  else{
                    setState(() {
                      visible = true;
                    });
                  }
                  },),
                ),
                Container(
                  child: ButtonIcon(icon: addTree, onPress: (){
                    setState(() {
                      tree = true;
                      subItems.add(SubItemBox());
                    });
                  },),
                ),
              ],
            ),
            height:30.0,
            width: double.infinity,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Container(
            child: Visibility(
              visible: visible,
              child: Column(
                children: subItems,
              ),
            ),
          )
        ],
      ),
    );;
  }
}

