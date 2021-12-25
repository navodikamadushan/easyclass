import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
              ),
              ListTile(
                leading: Icon(Icons.copy),
                title: Text('Copy Link'),
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
              ),
            ],
          );
        },
      );
}
