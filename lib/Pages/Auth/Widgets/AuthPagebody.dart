import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Pages/Auth/Widgets/LoginForm.dart';
import 'package:sampark/Pages/Auth/Widgets/SignupForm.dart';

class AuthPageBody extends StatelessWidget {
  const AuthPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLogin = true.obs;

    return Container(
      padding: EdgeInsets.all(20),
     // height: 400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
                children: [
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                          isLogin.value = true;
                        },
                        child: Column(
                          children: [
                            Text(
                                "Login",
                                style: isLogin.value
                                    ? Theme.of(context).textTheme.bodyLarge
                                    : Theme.of(context).textTheme.labelLarge
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              width: isLogin.value ? 100 : 0,
                              height: 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(context).colorScheme.primary
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          isLogin.value = false;
                        },
                        child: Column(
                          children: [
                            Text(
                                "SignUp",
                                style:isLogin.value
                                    ? Theme.of(context).textTheme.labelLarge
                                    : Theme.of(context).textTheme.bodyLarge
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              width: isLogin.value ? 0 : 100,
                              height: 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.orange
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                  ),
                 Obx(() =>
                     isLogin.value ?  LoginForm() : SignupForm()
                 )
                ],
              )
          )
        ],
      ),
    );
  }
}
