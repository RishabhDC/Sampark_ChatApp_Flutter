import 'package:get/get.dart';
import 'package:sampark/Pages/Auth/AuthPage.dart';
import 'package:sampark/Pages/Chat/ChatPage.dart';
import 'package:sampark/Pages/ContactPage/ContactPage.dart';
import 'package:sampark/Pages/HomePage/HomePage.dart';

import '../Pages/ProfilePage/ProfilePage.dart';
import '../Pages/userProfile/UserProfilePage.dart';
import '../Pages/userProfile/UserUpdateProfile.dart';

var pagePath = [
  GetPage(
      name: "/authPage",
      page: () => AuthPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/homePage",
    page: () => HomePage(),
    transition: Transition.rightToLeft,
  ),
  // GetPage(
  //   name: "/chatPage",
  //   page: () => ChatPage(),
  //   transition: Transition.rightToLeft,
  // ),
  // GetPage(
  //   name: "/profilePage",
  //   page: () => UserProfilePage(),
  //   transition: Transition.rightToLeft,
  // ),
  // GetPage(
  //   name: "/updateProfilePage",
  //   page: () => UserUpdateProfile(),
  //   transition: Transition.rightToLeft,
  // ),
  GetPage(
   name: "/profilePage",
   page: () => ProfilePage(),
   transition: Transition.rightToLeft,
 ),
  GetPage(
    name: "/contactPage",
    page: () => ContactPage(),
    transition: Transition.rightToLeft,
  ),

];