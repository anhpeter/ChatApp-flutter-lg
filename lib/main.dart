// @dart=2.9
import 'package:chat_app/bindings/initial_binding.dart';
import 'package:chat_app/constants/config.dart';
import 'package:chat_app/screens/chat/chat_screen.dart';
import 'package:chat_app/screens/global_search/global_search_screen.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:chat_app/screens/new_message/new_message.screen.dart';
import 'package:chat_app/screens/setting/setting_screen.dart';
import 'package:chat_app/screens/user_option_screen/user_option_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/app_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AppController appController = Get.put(AppController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          initialBinding: InititleBinding(),
          title: APP_NAME,
          themeMode: appController.themeMode.value,
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          darkTheme: ThemeData.dark(),
          initialRoute: UserOptionScreen.routeNamed,
          getPages: [
            GetPage(
              name: HomeScreen.routeNamed,
              page: () => HomeScreen(),
            ),
            GetPage(
                name: SettingScreen.routeNamed, page: () => SettingScreen()),
            GetPage(name: ChatScreen.routeNamed, page: () => ChatScreen()),
            GetPage(
                name: GlobalSearchScreen.routeNamed,
                page: () => GlobalSearchScreen()),
            GetPage(
                name: NewMessageScreen.routeNamed,
                page: () => NewMessageScreen()),
            GetPage(
              name: UserOptionScreen.routeNamed,
              page: () => UserOptionScreen(),
            ),
          ],
        ));
  }
}
