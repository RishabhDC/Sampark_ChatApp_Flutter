import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusController extends GetxController with WidgetsBindingObserver{

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    await db.collection("users").doc(auth.currentUser!.uid).update({
      "Status":"Online",
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    // print('AppLifecycleState: $state');
    if(state == AppLifecycleState.inactive){
      print("offline");
      await db.collection("users").doc(auth.currentUser!.uid).update({
        "Status":"Offline",
      });
    }else if(state == AppLifecycleState.resumed){
      print("online");
      await db.collection("users").doc(auth.currentUser!.uid).update({
        "Status":"Online",
      });
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

}