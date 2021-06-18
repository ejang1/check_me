import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'button_icon.dart';
import 'item_box.dart';
void main() =>runApp(CheckList());

class CheckList extends StatefulWidget {
  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  List <ItemBox> items = [ItemBox()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonIcon(icon: menu, onPress: (){
                      //show menu
                    }),
                    SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: Icon(
                        FontAwesomeIcons.clipboard,
                      ),
                    ),
                    ButtonIcon(icon: addTree, onPress: (){
                      setState(() {
                        items.add(new ItemBox());
                      });
                    },)
                  ],
                ),
              ),
              Container(
                //acheivement bar
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: items,
          ),
        ),
      ),
    );
  }
}
