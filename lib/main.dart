// @dart=2.9
import 'package:chat_app/bindings/initial_binding.dart';
import 'package:chat_app/common/Helper.dart';
import 'package:chat_app/common/themes/custom_theme.dart';
import 'package:chat_app/constants/config.dart';
import 'package:chat_app/screens/auth/auth_screen.dart';
import 'package:chat_app/screens/auth/widgets/firebase.dart';
import 'package:chat_app/screens/chat/chat_screen.dart';
import 'package:chat_app/screens/counter_screen/counter_screen.dart';
import 'package:chat_app/screens/global_search/global_search_screen.dart';
import 'package:chat_app/screens/home/binding/home_binding.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:chat_app/screens/new_message/new_message.screen.dart';
import 'package:chat_app/screens/setting/setting_screen.dart';
import 'package:chat_app/screens/user_option_screen/user_option_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/app_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialize.then((value){
    print('firebase connected');
  }).catchError((err){
    print(err.toString());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppController appController = Get.put(AppController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: InititleBinding(),
          title: APP_NAME,
          themeMode: appController.themeMode.value,
          theme: lightTheme(context),
          darkTheme: dartTheme(context),
          initialRoute: AuthScreen.routeNamed,
          getPages: [
            GetPage(
              name: HomeScreen.routeNamed,
              page: () => HomeScreen(),
              binding: HomeBinding(),
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
            GetPage(
              name: CounterScreen.routeNamed,
              page: () => CounterScreen(),
            ),
            GetPage(
              name: AuthScreen.routeNamed,
              page: () => AuthScreen(),
            ),
          ],
        ));
  }
}
