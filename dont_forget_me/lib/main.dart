import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:dont_forget_me/controller/percentage.dart';
import 'package:dont_forget_me/model/itemInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ItemInfo> items = [ItemInfo(itemTitle: 'item1', subitemlist:[]),ItemInfo(itemTitle: 'item2', subitemlist:[])];

  late Percentage percentage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                      child:Image.asset('images/Check_me.png'),
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
                        //adding tree in list
                      },
                      constraints: BoxConstraints.tightFor(),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: LinearPercentIndicator(
                  lineHeight: 20,
                  animation: true,
                  percent: percentage.getPercentage(items), //percent
                  center: Text(
                      '${(percentage.getPercentage(items) * 100).toStringAsFixed(2)}%'
                  ),
                  progressColor: Colors.green.shade400,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.black,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context,index){
              final item = items[index];
              return Dismissible(
                  key: Key(item.itemTitle),
                  onDismissed: (direction){
                    setState(() {
                      items.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item removed')));
                  },
                  child: ListTile(
                      title: Text('${item.itemTitle}'),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
