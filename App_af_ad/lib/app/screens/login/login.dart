import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/components/base_gradient_button.dart';
import 'package:syngentaaudit/app/components/base_textfield.dart';
import 'package:syngentaaudit/app/screens/login/login_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return Scaffold(
      appBar: null,
      body: Container(
          color: Colors.white,
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  width: size.width,
                  child: Image.asset(
                    'assets/images/login_image.png',
                    fit: BoxFit.contain,
                    width: 200,
                    height: 200,
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
                //   alignment: Alignment.centerLeft,
                //   width: size.width,
                //   child: Text(
                //     'Đăng nhập\ntài khoản của bạn!',
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 30),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: size.width,
                        child: Text(
                          'UserName',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: BaseTextField(
                          backgroundColor: const Color(0xFFF3F6FF),
                          controller: controller.userController,
                          leftIcon: 'assets/icons/ic_user.png',
                          radius: 50,
                          height: 40,
                          placeHolder: 'Username',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        alignment: Alignment.centerLeft,
                        width: size.width,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: BaseTextField(
                          backgroundColor: const Color(0xFFF3F6FF),
                          controller: controller.passController,
                          leftIcon: 'assets/icons/ic_password.png',
                          isPassword: true,
                          radius: 50,
                          height: 40,
                          placeHolder: 'Password',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(30, 100, 30, 0),
                    child: BaseGradientButton(
                      onPressed: () {
                        controller.handleLogin(context);
                      },
                      text: 'Login',
                    ),
                  ),
                SizedBox(height: 40,),
                new InkWell(
                    child: new Text('Register a new account',style: TextStyle(color: Colors.blue),),
                    onTap: () => launch('https://syngenta.e-technology.vn:4071/WebMobile/Register.aspx')
                ),
              ],
            ),
          )),
    );
  }
}
