import 'package:flutter/material.dart';

class Profile extends ChangeNotifier{
  List<CircleAvatar> badges=[];
  List<String> badgesDesc=[];
  late String name='---';
  late String collegename='---';
  late String year='---';
  late String dept='---';

  get getName{
    return name;
  }

  get getCollegeName{
    return collegename;
  }

  get getYear{
    return year;
  }

  get getDept{
    return dept;
  }

  void changeName(String newName){
    name=newName;
  }

  void changeCollegeName(String newCollegeName){
    collegename=newCollegeName;
  }

  void changeYear(String newYear){
    year=newYear;
  }

  void changeDept(String newDept){
    dept=newDept;
  }

  void addBadge(int typeOfBadge,String desc){
    Color colorOfBadge;
    if(typeOfBadge==1){
      colorOfBadge=Colors.green;
    }else if(typeOfBadge==2){
      colorOfBadge=Colors.yellow;
    }else{
      colorOfBadge=Colors.purple;
    }
    badges.add(CircleAvatar(child: Text(desc.substring(0,2)),backgroundColor: colorOfBadge,));
    badgesDesc.add(desc);
    notifyListeners();
  }


}