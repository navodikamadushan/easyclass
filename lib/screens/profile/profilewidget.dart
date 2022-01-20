// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

  const ProfileWidget({
    this.isEdit = false,
    this.imagePath,
    this.onClicked,
  });
  @override
  Widget build(BuildContext context) {
    //final color = Theme.of(context).colorScheme.primary;
    final color = Colors.purple[600];
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 1,
          child: IconButton(
            icon: Icon(
              isEdit ? Icons.add_a_photo : Icons.edit,
              color: Colors.white,
              size: 20,
            ),
            highlightColor: Colors.pink,
            onPressed: () {
              !isEdit ? onClicked : print("Edit pro");
              //onClicked;
            },
          ),
          onClicked: onClicked,
        ),
      );
  Widget buildCircle({
    Widget child,
    double all,
    Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
