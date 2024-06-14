import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sampark/Model/GroupModel.dart';
import 'package:sampark/Model/UserModel.dart';
import 'package:sampark/Pages/HomePage/HomePage.dart';
import 'package:uuid/uuid.dart';

import 'ProfileController.dart';

class GroupController extends GetxController{
 RxList<UserModel> groupMembers = <UserModel>[].obs;
 final db = FirebaseFirestore.instance;
 final auth = FirebaseAuth.instance;
 var uuid = Uuid();
 ProfileController profileController = Get.put(ProfileController());
 RxBool isLoading = false.obs;

 RxList<GroupModel> groupList = <GroupModel>[].obs;

 @override
  void onInit() {
    super.onInit();
    getGroups();
  }


 void selectMember(UserModel user){
   if(groupMembers.contains(user)){
     groupMembers.remove(user);
   }else{
     groupMembers.add(user);
   }
 }

  Future<void> createGroup(String groupName, String imagePath) async{
    isLoading.value = true;
    String groupId = uuid.v6();

      try{
        String imageUrl = await profileController.uploadFileToFirebase(imagePath);

        await db.collection("groups").doc(groupId).set(
         {
           "id": groupId,
           "name": groupName,
           " profileUrl": imageUrl,
           "members": groupMembers.map((e) => e.toJson()).toList(),
           "createdAt": DateTime.now().toString(),
           "createdBy": auth.currentUser!.uid,
           "timestamp": DateTime.now().toString(),
         }
        );
        Get.snackbar("Group Created", "Group Created Successfully");
        Get.offAll(HomePage());
         isLoading.value = false;
      }
      catch (e){
        print(e);
      }
  }

  Future<void> getGroups() async{
   isLoading.value = true;
   List<GroupModel> tempGroup = [];
   await db.collection('groups').get().then(
           (value) {
             tempGroup = value.docs
                 .map(
                     (e) => GroupModel.fromJson(e.data()),
             )
                 .toList();
           },
   );
   groupList.clear();
   groupList.value = tempGroup
      .where(
           (e) => e.members!.any(
                   (element) => element.id == auth.currentUser!.uid,
           ),
   )
       .toList();
   isLoading.value = false;
  }


}