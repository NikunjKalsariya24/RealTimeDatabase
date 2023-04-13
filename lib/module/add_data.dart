import 'package:firebase_database/firebase_database.dart';
import 'package:firebasedata/model/user_model.dart';
import 'package:firebasedata/utils/app_string.dart';
import 'package:firebasedata/utils/custom_text.dart';
import 'package:flutter/foundation.dart';

//import 'package:firebasedata/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../routes.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController postEditingController = TextEditingController();
  TextEditingController professionController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref('post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomText(name: AppString.addStudent)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 5.h,
            ),
            TextField(
              maxLines: 4,
              controller: postEditingController,
              decoration: InputDecoration(
                  hintText: AppString.studentNameHint,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                  ),
              ),
            ),
            TextField(
              maxLines: 4,
              controller: professionController,
              decoration: InputDecoration(
                  hintText: AppString.studentProfessionHint,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                  ),
              ),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
                onPressed: () async {
                  await addData();
                },
                child: CustomText(
                  name: AppString.addData,
                  fontSize: 16.sp,
                )),




            ElevatedButton(onPressed: () {
              Get.toNamed(Routes.firebaseStoragedata);
            }, child: Text("firebase Storage"))
          ],
        ),
      ),
    );
  }

  Future<void> addData() async {

    var uuid = const Uuid().v4();
    UserModel userModel = UserModel(
        name: postEditingController.text,
        profession: professionController.text,
        userId: uuid);
    await FirebaseDatabase.instance
        .ref()
        .child('Students')
        .child(uuid)
        .set(userModel.toJson());
    if (kDebugMode) {
      print("userModel=====${userModel.toJson()}");
    }
    Get.toNamed(Routes.homepage);
  }
}
