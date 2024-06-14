import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/Images.dart';
import 'package:sampark/Controller/GroupController.dart';
import 'package:sampark/Pages/HomePage/Widgets/ChatTile.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());

    return Obx(() =>
        ListView(
          children: groupController.groupList
              .map(
                  (group) => InkWell(
                    onTap: () {},
                    child: ChatTile(
                        imageUrl: group.profileUrl == ""
                               ? AssetsImage.defaultProfileUrl
                               : group.profileUrl!,
                        name: group.name!,
                        lastChat: " Group Created",
                        lastTime:'Just Now'
                    ),
                  )
          ).toList()
        )
    );
  }
}
