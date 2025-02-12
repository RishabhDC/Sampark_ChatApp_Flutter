import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Config/Images.dart';
import '../../../Controller/ProfileController.dart';

class LoginUserInfo extends StatelessWidget {
  final String profileImage;
  final String userName;
  final String userEmail;


  const LoginUserInfo({
    super.key,
   required this.profileImage,
    required this.userName,
    required this.userEmail
  });

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());

    return  Container(
      padding: EdgeInsets.all(20),
      //height: 100,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width:150,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child:
                          CachedNetworkImage(
                            imageUrl:  profileImage,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                    userEmail,
                    style: Theme.of(context).textTheme.labelLarge,
                  )

                  ],
                ),
                SizedBox(height: 20,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height:50,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.background
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AssetsImage.profileAudioCall,
                              width: 25,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Call",
                              style: TextStyle(
                                  color: Colors.green
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height:50,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.background
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AssetsImage.profileVideoCall,
                              width: 25,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Video",
                              style: TextStyle(
                                  color: Colors.orange
                              ),
                            )
                          ],
                        ),

                      ),
                      SizedBox(width: 10,),
                      Container(
                        height:50,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.background
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AssetsImage.appIconSVG,
                              width: 25,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Chat",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme.primary
                              ),
                            )
                          ],
                        ),

                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
