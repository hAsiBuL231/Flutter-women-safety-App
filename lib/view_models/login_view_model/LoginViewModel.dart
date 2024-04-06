import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_women_safety_app/.data/network/base_api_services.dart';
import 'package:get/get.dart';
import '../../.data/network/network_api_services.dart';
import '../../.utils/Functions.dart';
import '../../repository/login_repository/LoginRepository.dart';
import 'package:http/http.dart' as http;

import '../../view/bottom_screens/BottomPage.dart';

class LoginViewModel extends GetxController {
  final _api = LoginRepository();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool passwordVisibility = false.obs;

  RxBool loading = false.obs;

  Future<void> loginApi(context) async {
    // loading.value = true;
    Map data = {
      "username": emailController.value.text,
      "password": passwordController.value.text,
    };
    /*{
      "username": "Hasibul",
      "password": "123456"
    }*/
    try {
      LoginRepository repo = LoginRepository();
      var response = await repo.loginApi(data, context);
      snackBar('Login successful', context);

      Get.delete<LoginViewModel>();
      nextPage(const BottomPage(), context);
      // showToast(response, error: false);
    } catch (e) {
      showToast("sf: ${e.toString()}", error: true);
    }

    loading.value = false;
  }

  // googleLoginApi(context) async {
  //   try {
  //     final googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) return;
  //     final googleAuth = await googleUser.authentication;
  //     final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (e) {
  //     showToast(e.toString());
  //   }
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     print('User is Signed in!');
  //     //Get.to(const HomePageWidget());
  //     nextPage(const SplashScreen(), context);
  //   }
  // }
}
