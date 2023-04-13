import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'routes.dart';

class SchoolData extends StatelessWidget {
  const SchoolData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        initialBinding: AppBinding(),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.homepage,
        getPages: Routes.pages,


      );

    },);
  }
}

class AppBinding extends Bindings {
  @override
  void dependencies() {

  }
}