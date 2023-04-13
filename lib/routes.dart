import 'package:firebasedata/module/firebasestorage.dart';
import 'package:get/get.dart';

import 'module/homepage.dart';

mixin Routes
{

  static const defaultTransition = Transition.rightToLeft;
  static const String homepage = '/HomePage';
  static const String firebaseStoragedata='/FirebaseStorage';

  static List<GetPage<dynamic>> pages = [
  GetPage<dynamic>(
  name: homepage,

  page: () => const HomePage(),
  transition: defaultTransition,
  ),
    GetPage<dynamic>(
      name: firebaseStoragedata,

      page: () => const FirebaseStorageData(),
      transition: defaultTransition,
    ),
];
}