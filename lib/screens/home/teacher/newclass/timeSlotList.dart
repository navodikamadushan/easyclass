import 'package:flutter/material.dart';
import 'package:easyclass/services/provider/list_provider.dart';
import 'package:provider/provider.dart';

class TimeSlotList extends StatelessWidget {
  TimeSlotList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Card(
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${index}',
                style: TextStyle(fontSize: 18),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${context.watch<ListProvider>().list[index].name}',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context.read<ListProvider>().deleteItem(index);
                  }),
            ],
          ),
        ),
      ),
      itemCount: context.watch<ListProvider>().list.length,
    );
  }
}
