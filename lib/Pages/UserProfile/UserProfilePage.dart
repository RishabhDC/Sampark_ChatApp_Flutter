import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/Images.dart';
import 'package:sampark/Controller/AuthController.dart';
import 'package:sampark/Controller/ProfileController.dart';
import 'package:sampark/Model/UserModel.dart';
import 'package:sampark/Pages/userProfile/widgets/UserInfo.dart';

class UserProfilePage extends StatelessWidget {
  final UserModel userModel;

  const UserProfilePage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed("/updateProfilePage");
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            LoginUserInfo(
                profileImage:
                    userModel.profileImage ?? AssetsImage.defaultProfileUrl,
                userName: userModel.name ?? "User",
                userEmail: userModel.email ?? ""),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  authController.logoutUser();
                },
                child: Text("LogOut"))
          ],
        ),
      ),
    );
  }
}
