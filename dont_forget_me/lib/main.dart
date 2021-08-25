import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'constant.dart';
import 'package:dont_forget_me/controller/percentage.dart';
import 'package:dont_forget_me/model/itemInfo.dart';
import 'package:dont_forget_me/model/subItemInfo.dart';
import 'package:dont_forget_me/model/timerSetting.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification:(int id, String? title, String? body, String? payload,) async{});

  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid,iOS: initializationSettingsIOS);
  print('here');
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  onSelectNotification: (String? payload) async{
    if(payload != null){
      debugPrint('notification payload: ' + payload);
    }
  });

  runApp(MyApp());
}
String itemInput = "";

late TimerSetting timer;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: myScaffold(),
    );
  }
}

class myScaffold extends StatefulWidget {
  @override
  _myScaffoldState createState() => _myScaffoldState();
}

class _myScaffoldState extends State<myScaffold> {
  List<ItemInfo> items = [];
  Percentage percentage = new Percentage();
  double percent = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = new TimerSetting();
    //dateAlarm = DateTime(DateTime.now().year,timer.month,timer.date,timer.hour,timer.min);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroudColor,
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: appBarColor,
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
                      menu,
                      color: iconColor,
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
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => StatefulBuilder(
                        builder: (context,setState) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          content: Container(
                            height: timer.timerSet? 530 : 130,
                            width: 370,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //setting alarm?
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: ListTile(
                                    title: Center(
                                      child: Text(
                                          'SET ALARM?',
                                      ),
                                    ),
                                    tileColor: timer.timerSet? colorDone : colorUndone,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    onTap: (){
                                      setState(() {
                                        timer.timerSet? timer.timerSet = false : timer.timerSet = true;
                                      });
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: timer.timerSet,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: ListTile(
                                          title: Center(child: Text('ONE TIME')),
                                          tileColor: timer.onetime? colorDone : colorUndone,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          onTap: (){
                                              setState(() {
                                                if(timer.onetime == true){
                                                  timer.onetime = false;
                                                }
                                                else{
                                                  timer.onetime = true;
                                                  timer.daily = false;
                                                  timer.weekly = false;
                                                }
                                              });
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: ListTile(
                                          title: Center(child: Text('DAILY')),
                                          tileColor: timer.daily? colorDone : colorUndone,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          onTap: (){
                                              setState(() {
                                                if(timer.daily == true){
                                                  timer.daily = false;
                                                }
                                                else{
                                                  timer.daily = true;
                                                  timer.onetime = false;
                                                  timer.weekly = false;
                                                }
                                              });
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: ListTile(
                                          title: Center(child: Text('WEEKLY')),
                                          tileColor: timer.weekly? colorDone : colorUndone,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          onTap: (){
                                            setState(() {
                                              if(timer.weekly == true){
                                                timer.weekly = false;
                                              }
                                              else{
                                                timer.weekly = true;
                                                timer.onetime = false;
                                                timer.daily = false;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      // time
                                      Visibility(
                                        visible: timer.onetime,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Container(
                                            height: 60,
                                            child: CupertinoDatePicker(
                                              initialDateTime: timer.getDateTime(),
                                              mode: CupertinoDatePickerMode.date,
                                              onDateTimeChanged: (value){
                                                timer.oneTimeSetting(value.year, value.month, value.day, 0, 0);
                                              },
                                            )
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: timer.weekly,
                                        child: Container(
                                          height: 60,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                weekSelectionButton(setState,'M',0),
                                                weekSelectionButton(setState,'T',1),
                                                weekSelectionButton(setState,'W',2),
                                                weekSelectionButton(setState,'R',3),
                                                weekSelectionButton(setState,'F',4),
                                                weekSelectionButton(setState,'A',5),
                                                weekSelectionButton(setState,'S',6),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      Visibility(
                                        visible: timer.onetime || timer.daily || timer.weekly,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Container(
                                            height: 60,
                                            child: CupertinoDatePicker(
                                              initialDateTime: timer.getDateTime(),
                                              mode: CupertinoDatePickerMode.time,
                                              onDateTimeChanged: (value){
                                                timer.timeSetting(value.hour, value.minute);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: (){
                                        timer.cancled();
                                        Navigator.pop(context,'CANCLE');
                                      },
                                      child: Text('CANCLE'),
                                    ),
                                    TextButton(
                                      onPressed: (){
                                        Navigator.pop(context,'OK');
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    constraints: BoxConstraints.tightFor(),
                  ),
                  RawMaterialButton(
                    child: Icon(
                      add,
                      color: iconColor,
                      size: 40,
                    ),
                    onPressed: (){
                      setState(() {
                        items.add(ItemInfo(itemTitle: 'new item!',subitemlist: []));
                        percent = percentage.getPercentage(items);

                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => buildInitialItemAlertDialog(context,'Input New Item'),
                        );
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
                progressColor: colorDone,
              ),
            ),
          ],
        ),
      ),
      body:
      //main item box
      ListView.builder(
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  //main item box contents
                  child: ListTile(
                    title: Text(item.itemTitle),//item.itemTitle),
                    tileColor: item.isDone ? colorDone : colorUndone,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onTap: (){
                      setState(() {
                        if(item.existSub == false)item.isDone ? item.isDone = false : item.isDone = true;
                        percent = percentage.getPercentage(items);
                      });
                    },
                    //alert dialog for main box input
                    onLongPress: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => buildLongPressAlertDialog(context, item),
                    ),

                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          RawMaterialButton(
                            child: Icon(
                              item.existSub ? item.showSub ? underarrow: uparrow : minus,
                              color: iconColor,
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
                              color: iconColor,
                            ),
                            onPressed: (){
                              setState(() {
                                item.existSub = true;
                                item.subitemlist.add(SubItemInfo(itemTitle: 'new sub item!'));
                                item.isDone = false;
                                percent = percentage.getPercentage(items);
                                //alert dialog when press + in main item box
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => buildInitialSubItemAlertDialog(context, item),
                                );

                              });
                            },
                            constraints: BoxConstraints.tightFor(),
                          ),
                        ],
                      ),
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
                            item.subAllDone() ? item.isDone = true : item.isDone = false;
                            percent = percentage.getPercentage(items);
                          });
                        },
                        background: Container(color: appBackgroudColor),
                        child: Padding(
                          padding: EdgeInsets.only(left: 50, right: 15, bottom:10),
                          child: ListTile(
                            title: Text(subitem.itemTitle),//item.itemTitle),
                            tileColor: subitem.isDone ? colorDone : colorUndone,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onTap: (){
                              setState(() {
                                subitem.isDone ? subitem.isDone = false : subitem.isDone = true;
                                //if all of the subitems are done, change the color of father item box
                                item.subAllDone() ? item.isDone = true : item.isDone = false;
                                percent = percentage.getPercentage(items);
                              });
                            },
                            onLongPress: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => buildLongPressSubItemAlertDialog(context, subitem),
                            ),
                          ),
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
    );
  }

  Container weekSelectionButton(StateSetter setState,String week,int selection) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:5),
      width: 40,
      child: TextButton(
        child: Text(week,
        style: TextStyle(
          color: Colors.black,
        ),),
        onPressed: (){
          setState((){
            timer.weeklySetting(selection);
          });
          },
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => timer.weekSelection[selection]? colorDone : colorUndone),
        ),
      ),
    );
  }
  AlertDialog buildLongPressSubItemAlertDialog(BuildContext context, SubItemInfo subitem) {
    return AlertDialog(
                              title: Text('Input New Sub Item!'),
                              content: Container(
                                height: 130,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Sub Item',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onChanged:(input){
                                        itemInput = input;
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                          onPressed: (){
                                            Navigator.pop(context,'CANCLE');
                                          },
                                          child: const Text('CANCLE'),
                                        ),
                                        TextButton(
                                          onPressed: (){
                                            setState(() {
                                              subitem.setSubItemTitle(itemInput);
                                              itemInput = "";
                                            });
                                            Navigator.pop(context,'OK');
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
  }

  AlertDialog buildInitialSubItemAlertDialog(BuildContext context, ItemInfo item) {
    return AlertDialog(
      title: Text('Input Sub Item!'),
      content: Container(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Item',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onChanged:(input){
                itemInput = input;
                },
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: (){
                    setState(() {
                      item.subitemlist.removeAt(item.subitemlist.length-1);
                    });
                    Navigator.pop(context,'CANCLE');
                    },
                  child: const Text('CANCLE'),
                ),
                TextButton(
                  onPressed: (){
                    setState(() {
                      int lastsubitem = item.subitemlist.length-1;
                      item.subitemlist[lastsubitem].setSubItemTitle(itemInput);
                      itemInput = "";
                    });
                    Navigator.pop(context,'OK');
                    },
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AlertDialog buildLongPressAlertDialog(BuildContext context, ItemInfo item) {
    return AlertDialog(
                      title: Text('Input New Item!'),
                      content: Container(
                        height: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Item',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              onChanged:(input){
                                itemInput = input;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context,'CANCLE');
                                  },
                                  child: const Text('CANCLE'),
                                ),
                                TextButton(
                                  onPressed: (){
                                    setState(() {
                                      item.setItemTitle(itemInput);
                                      itemInput = "";
                                    });
                                    Navigator.pop(context,'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
  }

  AlertDialog buildInitialItemAlertDialog(BuildContext context,String itemKind) {
    return AlertDialog(
      title: Text(itemKind),
      content: Container(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Item',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onChanged:(input){
                itemInput = input;
                },
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: (){
                    setState(() {
                      items.removeAt(items.length-1);
                    });
                    Navigator.pop(context,'CANCLE');
                    },
                  child: const Text('CANCLE'),
                ),
                TextButton(
                  onPressed: (){
                    setState(() {
                      int lastitembox = items.length - 1;
                      items[lastitembox].setItemTitle(itemInput);
                      itemInput = "";
                    });
                    Navigator.pop(context,'OK');
                    },
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}