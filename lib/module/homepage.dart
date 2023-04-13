// ignore_for_file: non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';
import 'package:firebasedata/model/user_model.dart';
import 'package:firebasedata/utils/app_string.dart';
import 'package:firebasedata/utils/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../routes.dart';
import 'add_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController professionUpdateController = TextEditingController();

  // UserModel userModel=UserModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<UserModel> allData = <UserModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const AddPost();
              },
            ));
          },
          child: const Icon(Icons.add)),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
          itemCount: allData.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              child: ListTile(
                title:
                    CustomText(name: "${allData[index].name}", fontSize: 20.sp),
                subtitle: CustomText(
                    name: "${allData[index].profession}", fontSize: 20.sp),
                trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Widget_showModelBottomSheet(index);
                        },
                        child:
                            CustomText(name: AppString.update, fontSize: 16.sp),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {});
                          await deleteData(index);
                        },
                        child:
                            CustomText(name: AppString.delete, fontSize: 16.sp),
                      ),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> getData() async {
    await FirebaseDatabase.instance
        .ref()
        .child('Students')
        .once()
        .then((value) {
      allData.clear();

      for (var element in value.snapshot.children) {
        UserModel userModel = UserModel.fromJson(element.value);

        if (kDebugMode) {
          print('userModel ${userModel.toJson()}');
        }
        setState(() {
          allData.add(userModel);
        });

        if (kDebugMode) {
          print('userModelName=========${userModel.name}');
        }

        if (kDebugMode) {
          print("allData=====${allData.length}");
        }
      }
    });
  }

  Widget_showModelBottomSheet(int index) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 60.h,
          child: Column(
            children: [
              TextField(
                controller: nameUpdateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              TextField(
                controller: professionUpdateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await updateData(index);
                },
                child: CustomText(name: AppString.submit, fontSize: 16.sp),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> updateData(int index) async {
    if (kDebugMode) {
      print("index==========$index");
    }
    if (kDebugMode) {
      print("userid=========${allData[index].userId}");
    }
    await FirebaseDatabase.instance
        .ref()
        .child('Students')
        .child('${allData[index].userId}')
        .update({
      'name': nameUpdateController.text,
      'profession': professionUpdateController.text,
    });
    Get.toNamed(Routes.homepage);
  }

  Future<void> deleteData(int index) async {
    await FirebaseDatabase.instance
        .ref()
        .child('Students')
        .child('${allData[index].userId}')
        .remove();

    getData();
  }
}
