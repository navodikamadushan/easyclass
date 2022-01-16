// All right reserved by EasyClass
// Auther Information:- Kamith Yudara Tennakooon(kamithyudarathennakoon@gmail.com)

import 'package:flutter/material.dart';
import 'package:easyclass/screens/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:easyclass/services/provider/list_provider.dart';
import 'package:easyclass/models/model.dart';
import 'package:easyclass/screens/home/teacher/newclass/form_screen.dart';

class TimeSlotForm extends StatefulWidget {
  BuildContext pre_context;
  TimeSlotForm(BuildContext pre_context) {
    this.pre_context = pre_context;
  }
  @override
  _TimeSlotFormState createState() => _TimeSlotFormState();
}

class _TimeSlotFormState extends State<TimeSlotForm> {
  TimeOfDay _pickedTime = TimeOfDay.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  List<String> _listDays = [
    'Mon',
    "Tus",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ];
  String _currentDay = 'Mon';
  String timeSlot;

  final _formKey = GlobalKey<FormState>();

  Widget _DropDownState() {
    return DropdownButtonFormField(
      value: _currentDay ?? 'Mon',
      decoration: textInputDecoration,
      items: _listDays.map((listDay) {
        return DropdownMenuItem(
          value: listDay,
          child: Text('$listDay'),
        );
      }).toList(),
      onChanged: (val) => setState(() => _currentDay = val),
    );
  }

  Widget _setTimeSlot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ආරම්භක වේලාව', style: TextStyle(fontSize: 15)),
            IconButton(
                icon: Icon(Icons.alarm),
                iconSize: 40,
                onPressed: () {
                  _selecteStartTime(context);
                }),
            Text('${_startTime.format(context)}', style: TextStyle(fontSize: 15)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('අවසන් වේලාව', style: TextStyle(fontSize: 15)),
            IconButton(
                icon: Icon(Icons.alarm),
                iconSize: 40,
                onPressed: () {
                  _selecteEndTime(context);
                }),
            Text('${_endTime.format(context)}', style: TextStyle(fontSize: 15)),
          ],
        ),
      ],
    );
  }

  Future<Null> _selecteStartTime(BuildContext context) async {
    _pickedTime = await showTimePicker(context: context, initialTime: _startTime);
    if (_pickedTime != null) {
      setState(() {
        _startTime = _pickedTime;
      });
    }
  }

  Future<Null> _selecteEndTime(BuildContext context) async {
    _pickedTime = await showTimePicker(context: context, initialTime: _endTime);
    if (_pickedTime != null) {
      setState(() {
        _endTime = _pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    timeSlot = '${_currentDay} ${_startTime.hour}:${_startTime.minute} - ${_endTime.format(context)}';
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'ඔබගේ කාල පරාසය සකසන්න.',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 25),
          _setTimeSlot(),
          SizedBox(height: 20),
          _DropDownState(),
          SizedBox(height: 20),
          Text('Time Slot : ${timeSlot}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 90,
                height: 40,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  onPressed: () {
                    Navigator.pop(context);
                    if (timeSlot != null) {
                      context.read<ListProvider>().addItem(timeslot(timeSlot));
                    }
                  },
                  color: Colors.purple[400],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Text(
                    "ඇතුල් කරන්න",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 90,
                height: 40,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.purple[400],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Text(
                    "අවලංගු කරන්න",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
