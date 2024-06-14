import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampark/Controller/ImagePicker.dart';

import '../../../Config/Images.dart';
import '../../../Controller/ChatController.dart';
import '../../../Model/UserModel.dart';
import '../../../Widget/ImagePickerBottomSheet.dart';

class TypeMessage extends StatelessWidget {
  final UserModel userModel;

  const TypeMessage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            child: SvgPicture.asset(
              AssetsImage.chatEmoji,
              color: Colors.yellow,
              width: 25,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: TextField(
            onChanged: (value) {
              message.value = value;
            },
            controller: messageController,
            decoration:
                InputDecoration(filled: false, hintText: "Type message..."),
          )),
          SizedBox(
            width: 10,
          ),
          Obx(() => chatController.selectedImagePath.value == ""
              ? InkWell(
                  onTap: () {
                    ImagePickerBottomSheet(
                        context, chatController, imagePickerController);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      AssetsImage.gallerySVG,
                      width: 25,
                    ),
                  ),
                )
              : SizedBox()),
          SizedBox(
            width: 10,
          ),
          Obx(() => message.value != "" ||
                  chatController.selectedImagePath.value != ""
              ? InkWell(
                  onTap: () {
                    if (messageController.text.isNotEmpty ||
                        chatController.selectedImagePath.value.isNotEmpty) {
                      chatController.sendMessage(
                          userModel.id!, messageController.text, userModel);
                      messageController.clear();
                      message.value = "";
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    child: chatController.isLoading.value
                        ? CircularProgressIndicator()
                        : SvgPicture.asset(
                            AssetsImage.sendSVG,
                            width: 25,
                          ),
                  ),
                )
              : Container(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    AssetsImage.micSVG,
                    width: 25,
                  ),
                )),
        ],
      ),
    );
  }


}
