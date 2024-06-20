import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indus_valley_info_genai/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Indus Valley Civilization',
          home: const HomePage(),
          theme: ThemeData(
            fontFamily: 'Cinzel',
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.grey.shade900,
            primaryColor: const Color.fromARGB(255, 240, 131, 72),
          ),
        );
      },
      child: const HomePage(),
    );
  }
}
