import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../.data/network/network_api_services.dart';
import '../../.data/user_data_SharedPreferences/app_user_data.dart';
import '../../.resources/app_url/AppUrl.dart';
import '../../.utils/utils.dart';
import '../../models/user_models.dart';
import 'location_model/Location_model.dart';
import 'location_model/listen_location.dart';
import 'sms_model/Sms_Model.dart';

class LiveMapPageModel extends GetxController {
  RxBool switchListTileValue = false.obs;
  Prefs prefs = Prefs();

  requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      Utils.snackBar('Location', 'Location Permission Granted');
      //showToast('Location Permission Granted');
      //print(" \n \n Location Permission is Granted \n \n ");
    } else if (status.isDenied) {
      Utils.snackBar('Location', 'Location Permission is Denied');
      //showToast('Location Permission is Denied');
      //print(" \n \n Location Permission is Denied \n \n ");
      // requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> loadData(context) async {
    NetworkApiServices().getApi(AppUrl.usersUrl).then((value) {
      final provider = Provider.of<UserDataProvider>(context, listen: false);
      var userEmail = prefs.get(prefs.email) ?? '';

      var response = value;
      var users = response.map((doc) => Users.fromJson(doc));
      var matchedUsers = users.where((users) => users.email == userEmail).toList();
      Users user = matchedUsers[0];
      print(" \n \n HomePageModel loadData Print: ${user.securityCode} \n \n ");

      //Provider.of<UserDataProvider>(context, listen: false).saveUserData(user);
      provider.saveUserData(user);
    });
  }

  /// LocationModel
  final locationVM = Get.put(LocationModel());
  getCurrentLocation(context) {
    locationVM.getCurrentLocation(context);
  }

  getAddressFromLatLon() {
    locationVM.getAddressFromLatLon();
  }

  handleLocationPermission(context) {
    locationVM.handleLocationPermission(context);
  }

  /// ListenLocationProvider
  final listenLocationVM = Get.put(ListenLocationProvider());

  listenLocation(BuildContext context) {
    listenLocationVM.listenLocation(context);
  }

  stopListening() {
    listenLocationVM.stopListening();
  }

  /// SmsModel
  final smsVM = Get.put(SmsModel());

  shakeInitialization() {
    smsVM.shakeInitialization();
  }

  sendSms(String phoneNumber, String message, {int? simSlot}) {
    smsVM.sendSms(phoneNumber, message);
  }

  getAndSendSMS() {
    smsVM.getAndSendSMS();
  }
}
