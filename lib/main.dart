import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:poemer/network/controllers/books_controller.dart';
import 'package:poemer/presentation/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'network/bindings/directories_binding.dart';
import 'network/controllers/directories_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() async => DirectoriesController());
  await Get.putAsync(() async => BooksController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      builder:(context,_)=>  GetMaterialApp(
        initialBinding: DirectoriesBinding(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(

            bodyLarge: TextStyle(
              fontSize: 65.sp
            ),
            bodyMedium: TextStyle(
              fontSize: 45.sp,
              fontWeight: FontWeight.bold
            ),
            bodySmall: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        home:  HomePage(),
      ),
    );
  }
}