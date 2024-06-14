import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:sampark/Config/Images.dart';
import 'package:sampark/Controller/CallController.dart';
import 'package:sampark/Controller/ProfileController.dart';
import 'package:sampark/Model/ChatModel.dart';
import 'package:sampark/Model/UserModel.dart';
import 'package:sampark/Pages/Chat/Widgets/ChatBubble.dart';
import 'package:sampark/Pages/Chat/Widgets/TypeMessage.dart';
import 'package:sampark/Pages/UserProfile/UserProfilePage.dart';

import '../../Controller/ChatController.dart';

class ChatPage extends StatelessWidget {
  final UserModel userModel;

  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    ProfileController profileController = Get.put(ProfileController());
    CallController callController = Get.put(CallController());

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(UserProfilePage(
              userModel: userModel,
            ));
          },
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                // width: 50,
                // height: 50,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: userModel.profileImage ??
                          AssetsImage.defaultProfileUrl,
                      fit: BoxFit.cover,
                      width: 70,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                ),
              )),
        ),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(UserProfilePage(userModel: userModel));
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userModel.name ?? "User",
                      style: Theme.of(context).textTheme.bodyLarge),

                  StreamBuilder(
                      stream: chatController.getStatus(userModel.id!),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Text(".......");
                        }else{
                          return Text(
                              snapshot.data!.status ?? "",
                            style: TextStyle(
                              fontSize: 12,
                              color: snapshot.data!.status == "Online"
                                 ? Colors.green
                                  : Colors.red
                            ),
                          );
                        }
                      }
                  )

                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                callController.callAction(
                userModel,
                    profileController.currentUser.value

                );
              },
              icon: Icon(Icons.call
              )
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.video_call)
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: TypeMessage(
        userModel: userModel,
      ),
      body: Padding(
          padding:
              const EdgeInsets.only(bottom: 70, top: 10, right: 10, left: 10),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    StreamBuilder(
                        stream: chatController.getMessages(userModel.id!),
                        builder: (context, snapshot) {
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
                                reverse: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  DateTime timestamp = DateTime.parse(
                                      snapshot.data![index].timestamp!);
                                  String formattedTime =
                                      DateFormat('hh:mm a').format(timestamp);
                                  return ChatBubble(
                                      message: snapshot.data![index].message!,
                                      isComing:
                                          snapshot.data![index].receiverId ==
                                              profileController
                                                  .currentUser.value.id,
                                      time: formattedTime,
                                      status: "read",
                                      imageUrl:
                                          snapshot.data![index].imageUrl ?? "");
                                });
                          }
                        }),
                    Obx(
                      () => (chatController.selectedImagePath.value != "")
                          ? Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Stack(
                                  children: [

                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(File(chatController
                                            .selectedImagePath.value)),
                                        fit: BoxFit.contain),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 500,
                                ),
                                    Positioned(
                                      right: 0,
                                        left: 0,
                                        bottom: 0,
                                        child: IconButton(
                                          onPressed: (){
                                            chatController.selectedImagePath.value = "";
                                          },
                                          icon: Icon(Icons.close),
                                        )
                                    )

                              ]
                              ),
                            )
                          : Container(),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
