import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileImageWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  const ProfileImageWidget({
    this.imagePath,
    this.onClicked,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onClicked,
            // _showUserPannel();
            child: CachedNetworkImage(
              width: 45,
              height: 50,
              fit: BoxFit.cover,
              imageUrl: imagePath,
            ),
          ),
        ),
      ),
    );
  }
}
