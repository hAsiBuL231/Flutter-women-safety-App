import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/LiveSafeCard.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});

  static Future<void> openMap(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/$location';

    if (Platform.isAndroid) {
      if (await canLaunchUrl(Uri.parse(googleUrl))) {
        await launchUrl(Uri.parse(googleUrl));
      } else {
        throw 'Could not launch $googleUrl';
      }
    }
    // final Uri _url = Uri.parse(googleUrl);
    // try {
    //   await launchUrl(_url);
    // } catch (e) {
    //   Fluttertoast.showToast(
    //       msg: 'something went wrong! call emergency number');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: const [
          LiveSafeCard(onMapFunction: openMap, title: 'Police Stations', iconPath: 'Assets/images/icons/police-badge.png', queryText: 'Police stations near me'),
          LiveSafeCard(onMapFunction: openMap, title: 'Hospitals', iconPath: 'Assets/images/icons/hospital.png', queryText: 'Hospitals near me'),
          LiveSafeCard(onMapFunction: openMap, title: 'Pharmacy', iconPath: 'Assets/images/icons/pharmacy.png', queryText: 'pharmacies near me'),
          LiveSafeCard(onMapFunction: openMap, title: 'Bus Stations', iconPath: 'Assets/images/icons/bus-stop.png', queryText: 'bus stops near me'),
        ],
      ),
    );
  }
}
