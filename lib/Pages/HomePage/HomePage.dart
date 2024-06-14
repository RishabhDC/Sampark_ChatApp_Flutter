import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/Images.dart';
import 'package:sampark/Config/Strings.dart';
import 'package:sampark/Controller/ContactController.dart';
import 'package:sampark/Controller/ImagePicker.dart';
import 'package:sampark/Controller/StatusController.dart';
import 'package:sampark/Pages/Groups/GroupPage.dart';
import 'package:sampark/Pages/HomePage/Widgets/ChatList.dart';
import 'package:sampark/Pages/HomePage/Widgets/TabBar.dart';
import 'package:sampark/Pages/ProfilePage/ProfilePage.dart';

import '../../Controller/CallController.dart';
import '../../Controller/ProfileController.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    ProfileController profileController = Get.put(ProfileController());
    ContactController contactController = Get.put(ContactController());
    CallController callController = Get.put(CallController());

    ImagePickerController imagePickerController = Get.put(ImagePickerController());
    StatusController statusController = Get.put(StatusController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          AppString.appName
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(AssetsImage.appIconSVG),
        ),
        actions: [
          IconButton(
              onPressed: (){
               contactController.getChatRoomList();
              },
              icon: Icon(Icons.search)
          ),
          IconButton(
              onPressed: (){
               //Get.toNamed("/profilePage");
                Get.to(ProfilePage());
              },
              icon: Icon(Icons.more_vert)
          )
        ],
        bottom: myTabBar(tabController, context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed("/contactPage");
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
            Icons.add,
          color:Theme.of(context).colorScheme.onBackground,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: TabBarView(
          controller: tabController,
          children: [
           ChatList(),
            GroupPage(),
            ListView(
              children: [
                ListTile(
                  title: Text("Call Page"),
                )
              ],
            ),

          ],
        ),
      )
    );
  }
}
