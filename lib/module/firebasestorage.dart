import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class FirebaseStorageData extends StatefulWidget {
  const FirebaseStorageData({Key? key}) : super(key: key);

  @override
  State<FirebaseStorageData> createState() => _FirebaseStorageState();
}

class _FirebaseStorageState extends State<FirebaseStorageData> {
  String img = "";
  bool data = true;
  TextEditingController name1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Storage")),
      body: Column(
        children: [
          Center(
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Column(
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              final ImagePicker _picker = ImagePicker();

                              final XFile? abc = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                img = abc!.path;
                              });
                            },
                            child: Icon(Icons.image)),
                        ElevatedButton(
                            onPressed: () async {
                              final ImagePicker _picker = ImagePicker();
                              final XFile? abc = await _picker.pickImage(
                                  source: ImageSource.camera);
                              setState(() {
                                img = abc!.path;
                              });
                            },
                            child: Icon(Icons.camera))
                      ],
                    );
                  },
                );
              },
              child: data
                  ? Container(
                      height: 10.h,
                      child:
                          CircleAvatar(backgroundImage: FileImage(File(img))),    // s how for select images
                    )
                  : CircularProgressIndicator(),
            ),
          ),
          Container(
            child: TextField(
              controller: name1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            height: 20.h,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  final storageRef = FirebaseStorage.instance.ref();
                  String name = "images${Random().nextInt(1000)}.jpg";
                  final spaceRef=storageRef.child("images/$name");
                  spaceRef.putFile(File(img));

                }, child: Center(child: Text("Submit"))),
          )
        ],
      ),
    );
  }

}
