// All right reserved by EasyClass
// Auther Information:- Kamith Yudara Tennakooon(kamithyudarathennakoon@gmail.com)

import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:easyclass/models/model.dart';

class ListProvider extends ChangeNotifier {
  List<timeslot> _list = [];
  List<String> timeSlotlist = [];

  UnmodifiableListView<timeslot> get list => UnmodifiableListView(_list);

  void addItem(timeslot item) {
    _list.add(item);
    notifyListeners();
  }

  void deleteItem(int index) {
    _list.removeAt(index);
    notifyListeners();
  }

  List<String> getAllItems(int index) {
    timeSlotlist = [];
    for (int i = 0; i < index; i++) {
      timeSlotlist.add(_list[i].name); //print(context.read<ListProvider>().list[i].name);
    }
    return timeSlotlist;
  }
}
