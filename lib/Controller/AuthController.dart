import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sampark/Model/UserModel.dart';

class AuthController extends GetxController{
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;



  // For Login
 Future<void> login(String email, String password) async{
   isLoading.value = true;
   try{
     await auth.signInWithEmailAndPassword(
         email: email,
         password: password
     );
     Get.offAllNamed("homePage");
   }on FirebaseAuthException catch (e){
    if(e.code == 'user-not-found'){
      print('No user found for that email');
    }else if (e.code == 'wrong-password'){
      print('Wrong password provided for that user');
    }
   }catch (e){
     print(e);
   }
   isLoading.value = false;
 }

  Future<void> createUser(String email, String password,String name) async{
    isLoading.value = true;
  try{
    await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
    );
    await initUser(email,name);
    print("Account Created 🔥🔥🔥");
    Get.offAllNamed("homePage");
  }on FirebaseAuthException catch (e){
    if(e.code == 'weak-password'){
     print('The password is too weak');
    }else if(e.code == 'email-already-in-use'){
      print("The account already exixts");
    }
  } catch (e){
    print(e);
  }
    isLoading.value = false;
  }

  Future<void> logoutUser() async{
   await auth.signOut();
   Get.offAllNamed("/authPage");
  }

  Future<void> initUser(String email,String name) async{

   var newUser = UserModel(
     email: email,
     name: name,
     id: auth.currentUser!.uid,
   );

  try{
    await db.collection("users")
        .doc(auth.currentUser!
        .uid
    ).set(newUser.toJson()
    );
  }catch(ex){
    print(ex);
  }

  }

}