import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import '../user/user_data.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({super.key});

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  var user = UserData.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        const SizedBox(
            width: 330,
            child: Text(
              "Upload a photo of yourself:",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            )),
        Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
                width: 330,
                child: GestureDetector(
                  onTap: () {},
                  child: Image.network(user.imageUrl),
                ))),
        Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 330,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

                      if (image == null) return;

                      final location = await getApplicationDocumentsDirectory();
                      final name = basename(image.path);
                      final imageFile = File('${location.path}/$name');
                      final newImage = await File(image.path).copy(imageFile.path);
                      // setState(() => user = user(imagePath: newImage.path));
                    },
                    child: const Text('Update', style: TextStyle(fontSize: 15)),
                  ),
                )))
      ]),
    );
  }
}
