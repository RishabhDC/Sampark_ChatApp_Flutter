import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:sampark/Config/Images.dart';
import 'package:sampark/Controller/GroupController.dart';
import 'package:sampark/Pages/Groups/NewGroup/GroupTitle.dart';
import 'package:sampark/Pages/Groups/NewGroup/SelectedMemberList.dart';
import 'package:sampark/Pages/HomePage/Widgets/ChatTile.dart';

import '../../../Controller/ContactController.dart';
import '../../Chat/Widgets/ChatBubble.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    GroupController groupController = Get.put(GroupController());

    return Scaffold(
      appBar: AppBar(
        title: Text('New Group'),
      ),

      floatingActionButton: Obx(() => FloatingActionButton(
        backgroundColor: groupController.groupMembers.isEmpty
            ? Colors.black
            : Colors.green,
        onPressed: (){
          if(groupController.groupMembers.isEmpty){
            Get.snackbar("Error", "please Select atleast one member");
          }else{
            Get.to(GroupTitle());
          }
        },
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          SelectedMemberLis(),
            SizedBox(height: 10,),
            Row(
              children: [
                Text(
                    "Contacts on Sampark",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            SizedBox(height: 10,),

            Expanded(
              child: StreamBuilder(
                stream: contactController.getContacts(),
                builder: (context, snapshot)
                  {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    }
                    if (snapshot.data == null) {
                      return Center(
                        child: Text("No Messages"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: (){
                                groupController.selectMember(snapshot.data![index]);
                              },
                              child: ChatTile(
                                  imageUrl: snapshot.data![index].profileImage ??
                                           AssetsImage.defaultProfileUrl,
                                  name: snapshot.data![index].name!,
                                  lastChat: snapshot.data![index].about ?? "",
                                  lastTime: ""
                              ),
                            );
                          });
                    }
                  }
              ),
            ),
          ],
        ),
      )
    );
  }
}
