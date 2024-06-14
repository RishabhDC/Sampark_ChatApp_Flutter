import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sampark/Model/AudioCall.dart';
import 'package:sampark/Model/UserModel.dart';
import 'package:uuid/uuid.dart';

class CallController extends GetxController{
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final uuid = Uuid().v4();


  void onInit(){
    super.onInit();

    getCallsNotification().listen((snapshot){
      if(snapshot.docs.isNotEmpty){
        Get.snackbar("Calling", "Calling");
      }
    });

  }


  Future<void> callAction(UserModel receiver, UserModel caller) async{
    String id = uuid;
    var newCall = AudioCallModel(
      id: id,
      callerName: caller.name,
      callerPic: caller.profileImage,
      callerUid: caller.id,
      callerEmail: caller.email,
      receiverName: receiver.name,
      receiverPic: receiver.profileImage,
      receiverUid: receiver.id,
      receiverEmail: receiver.email,
      status: "dialing"
    );

    try{
      await db
          .collection("notification")
          .doc(receiver.id)
          .collection("call")
          .doc(id)
          .set(newCall.toJson());
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());
      await db
          .collection("users")
          .doc(receiver.id)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());
      Future.delayed(Duration(seconds: 20),(){
        endCall(newCall);
      });
    }catch (e){
      print(e);
    }
  }

  Stream<QuerySnapshot> getCallsNotification(){
    return db
        .collection("notification")
        .doc(auth.currentUser!.uid)
        .collection("call")
        .snapshots();
  }

  Future<void> endCall(AudioCallModel call) async{
    try{
      await db
          .collection("notification")
          .doc(call.receiverUid)
          .collection("call")
          .doc(call.id)
          .delete();
    }catch (e){
      print(e);
    }
  }

}