import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'constant.dart';
import 'package:dont_forget_me/controller/percentage.dart';
import 'package:dont_forget_me/model/itemInfo.dart';
import 'package:dont_forget_me/model/subItemInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ItemInfo> items = [ItemInfo(itemTitle: 'item1', subitemlist:[]),ItemInfo(itemTitle: 'item2', subitemlist:[])];
  Percentage percentage = new Percentage();
  double percent = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: appBackgroudColor,
        appBar: AppBar(
          toolbarHeight: 150,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RawMaterialButton(
                      child:Icon(
                        FontAwesomeIcons.bars,
                        color: Colors.black,
                        size: 40,
                      ),
                      onPressed: (){
                        //menu open
                      },
                      constraints: BoxConstraints.tightFor(),
                    ),
                    RawMaterialButton(
                      child:Image(
                        height: 60,
                        width: 60,
                        image: AssetImage('images/checkme.png'),
                      ),
                      onPressed: (){
                        //timer set
                      },
                      constraints: BoxConstraints.tightFor(),
                    ),
                    RawMaterialButton(
                      child: Icon(
                        FontAwesomeIcons.plus,
                        color: Colors.black,
                        size: 40,
                      ),
                      onPressed: (){
                        setState(() {
                          items.add(ItemInfo(itemTitle: 'new item!',subitemlist: []));
                          percent = percentage.getPercentage(items);
                        });
                        //adding tree in list
                      },
                      constraints: BoxConstraints.tightFor(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: LinearPercentIndicator(
                  lineHeight: 20,
                  animation: true,
                  percent: percent, //percent
                  center: Text(
                      '${(percent* 100).toStringAsFixed(2)}%'
                  ),
                  progressColor: Colors.green.shade400,
                ),
              ),
            ],
          ),
        ),
        body: Container(
           //color: appBackgroudColor,
           child: ListView.builder(
             shrinkWrap: true,
             itemCount: items.length,
             itemBuilder: (context,index){
               final item = items[index];
               return Dismissible(
                   key: UniqueKey(),
                   onDismissed: (direction){
                     setState(() {
                       items.removeAt(index);
                       percent = percentage.getPercentage(items);
                     });
                   },
                 background: Container(color: appBackgroudColor),
                 child: Column(
                   children: [
                     ListTile(
                       title: Text(item.itemTitle),//item.itemTitle),
                       tileColor: item.isDone ? Colors.greenAccent.shade200 : Colors.grey.shade300,
                       onTap: (){
                         setState(() {
                           if(item.existSub == false)item.isDone ? item.isDone = false : item.isDone = true;
                           percent = percentage.getPercentage(items);
                         });
                       },
                       onLongPress: (){
                         //reset itemtitle
                       },
                       trailing: Container(
                         width: 100,
                         child: Row(
                           children: [
                             RawMaterialButton(
                               child: Icon(
                                 item.existSub ? item.showSub ? underarrow: uparrow : minus,
                                 color: Colors.black,
                               ),
                               onPressed: (){
                                 setState(() {
                                   item.showSub ? item.showSub = false : item.showSub = true;
                                 });
                               },
                               constraints: BoxConstraints.tightFor(),
                             ),
                             RawMaterialButton(
                               child: Icon(
                                 add,
                                 color: Colors.black,
                               ),
                               onPressed: (){
                                 setState(() {
                                   item.existSub = true;
                                   item.subitemlist.add(SubItemInfo(itemTitle: 'new sub item!'));
                                   item.isDone = false;
                                   percent = percentage.getPercentage(items);
                                 });
                               },
                               constraints: BoxConstraints.tightFor(),
                             ),
                           ],
                         ),
                       ),
                     ),
                     Visibility(
                       visible: item.showSub,
                         child: ListView.builder(
                           shrinkWrap: true,
                           itemCount: item.subitemlist.length,
                             itemBuilder: (context,index){
                             final subitem = item.subitemlist[index];
                             return Dismissible(
                               key: UniqueKey(),
                               onDismissed: (direction){
                                 setState(() {
                                   item.subitemlist.removeAt(index);
                                   if(item.subitemlist.length == 0){
                                     item.existSub = false;
                                   }
                                 });
                               },
                               background: Container(color: appBackgroudColor),
                               child: ListTile(
                                 title: Text(subitem.itemTitle),//item.itemTitle),
                                 tileColor: subitem.isDone ? Colors.greenAccent.shade200 : Colors.grey.shade300,
                                 onTap: (){
                                   setState(() {
                                     subitem.isDone ? subitem.isDone = false : subitem.isDone = true;
                                     //if all of the subitems are done, change the color of father item box
                                     item.subAllDone() ? item.isDone = true : item.isDone = false;
                                     percent = percentage.getPercentage(items);
                                   });
                                 },
                                 onLongPress: (){
                                   //reset subitemtitle
                                 },
                               ),
                             );
                             },
                         ),
                     ),
                   ],
                 ),
               );
             },
           ),
        ),
      ),
    );
  }
}
