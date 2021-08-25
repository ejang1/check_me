class AlarmController{
  AlarmController({required this.alarmSet});

  DateTime alarmSet;
  DateTime timenow = DateTime.now();

  void checkTime(){
  }

  void firstAlarm(double percent){
    if(percent < 100){
      //alarm!
    }
  }

  void secondAlarm(double percent){
    if(percent < 100){
      //alarm!
    }
  }

  void thirdAlarm(double percent){
    if(percent < 100){
      //alarm!
    }
  }
}