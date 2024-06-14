import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sampark/Controller/ChatController.dart';
import 'package:sampark/Controller/ContactController.dart';
import 'package:sampark/Controller/ProfileController.dart';
import 'package:sampark/Pages/Chat/ChatPage.dart';
import 'package:sampark/Pages/ContactPage/Widgets/ContactSearch.dart';
import 'package:sampark/Pages/ContactPage/Widgets/NewContactTile.dart';
import 'package:sampark/Pages/Groups/NewGroup/NewGroup.dart';

import '../../Config/Images.dart';
import '../HomePage/Widgets/ChatTile.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    ContactController contactController = Get.put(ContactController());
    ChatController chatController = Get.put(ChatController());
    ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text(" Select Contacts"),
        actions: [
          Obx(() => IconButton(
              onPressed: (){
                isSearchEnable.value = !isSearchEnable.value;
              },
              icon: isSearchEnable.value
                  ? Icon(Icons.close)
                  : Icon(Icons.search)
          )
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
        Obx(() =>  isSearchEnable.value
            ? ContactSearch()
            : SizedBox(),
        ),
            SizedBox(height: 10,),
              NewContactTile(
                  btnName: "New Contact",
                  icon: Icons.person_add_alt_1_rounded,
                  onTap: (){}
              ),
            SizedBox(height: 10,),
            NewContactTile(
                btnName: "New Group",
                icon: Icons.groups_rounded,
                onTap: (){
                  Get.to(NewGroup());
                }
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Contacts on Sampark")
              ],
            ),
            SizedBox(height: 10,),
            Obx(() => Column(
                children: contactController.userList
                    .map((e) => InkWell(
                  onTap: (){
                    // Get.toNamed("/chatPage", arguments: e);
                    Get.to(ChatPage(userModel: e));
                  },
                  child: ChatTile(
                      imageUrl: e.profileImage ?? AssetsImage.defaultProfileUrl,
                      name: e.name ?? "User",
                      lastChat: e.about ?? "Hey there",
                      lastTime: e.email == profileController.currentUser.value.email
                           ? "You"
                           : ""
                  ),

                )
                ).toList()
            )
            )
          ],

        ),
      ),
    );
  }
}
