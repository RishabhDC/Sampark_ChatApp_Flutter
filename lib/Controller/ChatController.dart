import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:sampark/Controller/ContactController.dart';
import 'package:sampark/Controller/ProfileController.dart';
import 'package:sampark/Model/ChatModel.dart';
import 'package:sampark/Model/ChatRoomModel.dart';
import 'package:sampark/Model/UserModel.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController{

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  var uuid = Uuid();
  RxString selectedImagePath = "".obs;

  ProfileController profileController = Get.put(ProfileController());
  ContactController contactController = Get.put(ContactController());


  String getRoomId(String targetUserId){
    String currentUserId = auth.currentUser!.uid;
    if(currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)){
      return currentUserId + targetUserId;
    }else{
      return targetUserId + currentUserId;
    }
  }

  UserModel getSender(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUser;
    } else {
      return targetUser;
    }
  }

  UserModel getReciver(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return targetUser;
    } else {
      return currentUser;
    }
  }

  Future<void> sendMessage(String targetUserId,String message,UserModel targetUser) async{
    isLoading.value = true;
    String chatId = uuid.v6();
    String roomId = getRoomId(targetUserId);
    DateTime timestamp = DateTime.now();
    String nowTime = DateFormat('hh:mm a').format(timestamp);

    UserModel sender = getSender(profileController.currentUser.value, targetUser);
    UserModel receiver = getReciver(profileController.currentUser.value, targetUser);

    RxString imageUrl = "".obs;
    if(selectedImagePath.value.isNotEmpty){
      imageUrl.value =
           await profileController.uploadFileToFirebase(selectedImagePath.value);
    }

    var newChat = ChatModel(
      id: chatId,
      message: message,
      imageUrl: imageUrl.value,
      senderId: auth.currentUser!.uid,
      receiverId: targetUserId,
      senderName: profileController.currentUser.value.name,
      timestamp: DateTime.now().toString(),
    );

    var roomDetails = ChatRoomModel(
      id: roomId,
      lastMessage: message,
      lastMessagesTimestamp: nowTime,
      sender: sender,
      receiver: receiver,
      timestamp: DateTime.now().toString(),
      unReadMessNo: 0,
    );
    try {
      await db
          .collection("chats")
          .doc(roomId)
          .collection("messages")
          .doc(chatId)
          .set(
        newChat.toJson(),
      );
      selectedImagePath.value = "";
      await db.collection("chats").doc(roomId).set(
        roomDetails.toJson(),
      );
      await contactController.saveContact(targetUser);
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getMessages(String targetUserId){
    String roomId = getRoomId(targetUserId);
    return db
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
          .map(
            (doc) => ChatModel.fromJson(doc.data()),
    )
        .toList());
  }

  Stream<UserModel> getStatus(String uid){
    return db.collection('users').doc(uid).snapshots().map(
            (event) {
              return UserModel.fromJson(event.data()!);
            },
    );
  }

}