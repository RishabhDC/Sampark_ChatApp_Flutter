import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:sampark/Model/UserModel.dart';

class ProfileController extends GetxController{
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final store = FirebaseStorage.instance;
  final isLoading = false.obs;

  Rx<UserModel> currentUser = UserModel().obs;

  void onInit() async{
    super.onInit();
    await getUserDetails();
  }

  Future<void> getUserDetails() async {
    await db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) =>
    {
      currentUser.value = UserModel.fromJson(
        value.data()!,
      ),
    }
    );
  }

    Future<void> updateProfile(
        String imageurl,
        String name,
        String about,
        String number
        ) async{
      isLoading.value = true;

      try{
        final imageLink = await uploadFileToFirebase(imageurl);

        final updatedUser = UserModel(
            id: auth.currentUser!.uid ,
            email: auth.currentUser!.email,
            name: name,
            about: about,
            profileImage:
                 imageurl == "" ? currentUser.value.profileImage : imageLink,
            phoneNumber: number
        );
        await db
            .collection("users")
            .doc(auth.currentUser!.uid)
            .set(updatedUser.toJson());

        await getUserDetails();
      }catch (ex){
        print(ex);
      }

      isLoading.value = false;
    }

    Future<String> uploadFileToFirebase(String imagePath) async{
      final path = "files/${imagePath}";
      final file = File(imagePath!);
       if(imagePath != ""){
         try{
           final ref = store.ref().child(path).putFile(file);
           final uploadTask = await ref.whenComplete(() {});
           final downloadImageUrl = await uploadTask.ref.getDownloadURL();
           print(downloadImageUrl);
           return downloadImageUrl;
         }catch (ex){
           print(ex);
           return "";
         }
       }
       return "";
    }

  }