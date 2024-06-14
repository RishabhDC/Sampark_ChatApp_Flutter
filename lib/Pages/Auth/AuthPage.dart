import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampark/Pages/Auth/Widgets/AuthPagebody.dart';
import 'package:sampark/Pages/WelcomePage/Widgets/WelcomeHeading.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
              WelcomeHeading(),
                SizedBox(height: 40,),
                AuthPageBody()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
