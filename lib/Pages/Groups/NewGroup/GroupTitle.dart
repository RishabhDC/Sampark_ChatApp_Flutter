
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampark/Config/Images.dart';
import 'package:sampark/Pages/HomePage/Widgets/ChatTile.dart';
import 'package:uuid/uuid.dart';

import '../../../Controller/GroupController.dart';
import '../../../Controller/ImagePicker.dart';
import '../../../Controller/ProfileController.dart';

class GroupTitle extends StatelessWidget {
  const GroupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    ImagePickerController imagePickerController = Get.put(ImagePickerController());
    // ProfileController profileController = Get.put(ProfileController());
    TextEditingController groupName = TextEditingController();

    RxBool isEdit = false.obs;
    RxString imagePath = "".obs;
    var uuid = Uuid();



    return Scaffold(
      appBar: AppBar(
        title: Text("New Group)",
      ),
      ),
         floatingActionButton: Obx(() => FloatingActionButton(
           backgroundColor: Colors.green,
           foregroundColor: Colors.black,
           onPressed: (){
             groupController.createGroup(
                 groupName.text,
                 imagePath.value
             );
           },
           child: groupController.isLoading.value
               ? CircularProgressIndicator(
             color: Colors.black,
           )
               : Icon(Icons.done),
         ),
         ),
         body: Column(
           children: [
             SizedBox(height: 10,),
             Container(
               padding: EdgeInsets.all(10),
               decoration: BoxDecoration(
                 color: Theme.of(context).colorScheme.primaryContainer,
                 borderRadius: BorderRadius.circular(10)
               ),
               child: Row(
                 children: [
                   Expanded(
                     child: Column(
                       children: [
                        Obx(() =>  InkWell(
                          onTap:() async{
                            imagePath.value = await imagePickerController
                                .pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: imagePath.value == ""
                                ? Icon(
                              Icons.group,
                              size: 40,
                            )
                                : ClipRRect(
                                   borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    fit: BoxFit.cover,
                                  File(imagePath.value)
                                  ),
                                ),
                          ),
                        ),

                        ),
                         SizedBox(height: 20,),
                         TextFormField(
                           controller: groupName,
                           decoration: InputDecoration(
                             hintText: "Group Name",
                             prefixIcon: Icon(Icons.group)
                           ),
                         ),
                         SizedBox(height: 10,),
                       ],
                     ),
                   )
                 ],
               ),
             ),
             SizedBox(height: 10,),
             Expanded(
                 child: SingleChildScrollView(
                   child: Column(
                     children: groupController.groupMembers.map((e) =>
                     ChatTile(
                         imageUrl: e.profileImage ?? AssetsImage.defaultProfileUrl,
                         name: e.name!,
                         lastChat: e.about ?? '',
                         lastTime: ""
                     )
                     ).toList()
                   ),
                 )
             )
           ],
         ),
    );
  }
}
