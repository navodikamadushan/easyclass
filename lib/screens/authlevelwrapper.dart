// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import "package:easyclass/services/database.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:easyclass/models/user.dart";
import 'package:provider/provider.dart';
import "package:easyclass/shared/loading.dart";

class AuthLevelWrapper extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    final userforid = Provider.of<MyUser>(context);
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(userforid.uid).snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData ? Loading() : _buildWrapper(snapshot.data);
        });
  }

  Widget _buildWrapper(DocumentSnapshot data) {
    return Scaffold(
      body: Text(data['auth_level'].toString()),
    );
  }
}
