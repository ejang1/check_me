class Percentage{
  double getPercentage(List items){
    int complete = 0;
    int total = items.length;
    for(int i = 0; i<items.length;i++) {
      if (items[i].finished) complete ++;
    }
    if(total == 0) return 0;
    else{
      return complete / total.toDouble();
    }
  }
}