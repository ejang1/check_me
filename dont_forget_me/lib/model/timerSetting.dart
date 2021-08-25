class TimerSetting{
  TimerSetting();

  List<bool> weekSelection = [false,false,false,false,false,false,false];

  bool timerSet = false;

  bool onetime = false;
  bool daily = false;
  bool weekly = false;

  int year = 0;
  int month = 0;
  int date = 0;
  int hour = 0;
  int min = 0;
  //time
  //alarm sound

  void oneTimeSetting(int year, int month,int date,int hour,int min){
    this.year = year;
    this.month = month;
    this.date = date;
  }
  void dailySetting(){
    this.year = DateTime.now().year;
    this.month = DateTime.now().month;
    this.date = DateTime.now().day;
  }
  void weeklySetting(int selection){
    this.year = DateTime.now().year;
    this.month = DateTime.now().month;
    this.weekSelection[selection]? weekSelection[selection] = false : weekSelection[selection] = true;
  }

  void timeSetting(int hour, int min){
    this.hour = hour;
    this.min = min;
  }

  void cancled(){
    timerSet = false;
    onetime = false;
    daily = false;
    weekly = false;
    month = 0;
    date = 0;
    hour = 0;
    min = 0;
    for(int i = 0; i < weekSelection.length; i++){
      weekSelection[i] = false;
    }
  }

  DateTime getDateTime(){
    if(this.year == 0 || this.month == 0 || this.date == 0 || this.hour ==0 || this.min ==0) return DateTime.now();
    else return DateTime(this.year,this.month,this.date,this.hour,this.min);
  }

}