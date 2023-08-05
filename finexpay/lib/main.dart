import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/messages.dart';
import 'package:local_coin/data/controller/localization/localization_controller.dart';
import 'package:local_coin/push_notification_service.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/my_strings.dart';
import 'core/di_service/di_service.dart' as di_service;
import 'core/route/route.dart';
import 'core/theme/light.dart';
import 'data/controller/common/theme_controller.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final sharedPreferences=await SharedPreferences.getInstance();
  Get.lazyPut(()=>sharedPreferences);
  sharedPreferences.setBool(SharedPreferenceHelper.hasNewNotificationKey, true);
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Map<String, Map<String, String>> languages = await di_service.init();

  FirebaseMessaging.onBackgroundMessage(
      _messageHandler
  );
  await PushNotificationService().setupInteractedMessage();

  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(languages: languages));

}


class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({Key? key,required this.languages}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {// Clean up observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  LockScreenManager(child: GetBuilder<ThemeController>(builder: (theme){
      return GetBuilder<LocalizationController>(builder: (localizeController){
      return GetMaterialApp(
        title:MyStrings.appName,
        initialRoute: RouteHelper.splashScreen,
        defaultTransition: Transition.topLevel,
        transitionDuration: const Duration(milliseconds: 10),
        getPages: RouteHelper.routes,
        navigatorKey: Get.key,
        theme:light,
        debugShowCheckedModeBanner: false,
        locale: localizeController.locale,
        translations: Messages(languages: widget.languages),
        fallbackLocale: Locale(localizeController.locale.languageCode, localizeController.locale.countryCode),
      );
      });
    }));
  }

}





class LockScreenManager extends StatefulWidget {

  final Widget child;

  const LockScreenManager({Key? key, required this.child}) : super(key: key);

  static _LockScreenManagerState of(BuildContext context) {
    final state =
    context.findAncestorStateOfType<_LockScreenManagerState>();
    if (state == null) {
      throw FlutterError('LockScreenManager not found in context');
    }
    return state;
  }

  @override
  State<LockScreenManager> createState() => _LockScreenManagerState();
}

class _LockScreenManagerState extends State<LockScreenManager>
    with WidgetsBindingObserver, TickerProviderStateMixin {

  Timer? _lockTimer;
  late Ticker _ticker;
  bool _isInteracting = true;
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resetTimer();
    _ticker = createTicker(_onTick,);
    _ticker.start();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cancelTimer();
    _ticker.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resetTimer();
    } else if (state == AppLifecycleState.paused) {
      _cancelTimer();
    }
  }

  void _onTick(Duration elapsed) {}


  void _resetTimer() {
    _cancelTimer();
    _isLoading = false;
    _isInteracting = false;
    _lockTimer = Timer(const Duration(seconds: MyStrings.lockTime), () {
      if(!_isInteracting && !_isLoading){
        _showLockScreen();
      }
      _isLoading = true;
      _isInteracting = true;
      _cancelTimer();
      return;
    });
  }

  void _cancelTimer() {
    if (_lockTimer != null) {
      _lockTimer?.cancel();
      _lockTimer = null;
    }
  }


  void _showLockScreen() {
    _cancelTimer();
    if (Get.context != null) {
      List<String> route = [
        RouteHelper.verifyPassCodeScreen,
        RouteHelper.registrationScreen,
        RouteHelper.emailVerificationScreen,
        RouteHelper.smsVerificationScreen,
        RouteHelper.twoFactorScreen,
        RouteHelper.profileComplete,
        RouteHelper.resetPasswordScreen,
        RouteHelper.splashScreen,
        RouteHelper.loginScreen,
        RouteHelper.forgetPasswordScreen,
        RouteHelper.createPinScreen,
        RouteHelper.verifyPinScreen,
      ];
      if (!route.contains(Get.currentRoute)) {
        Get.toNamed(RouteHelper.verifyPinScreen);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerPanZoomUpdate: (_){},
      onPointerDown: (_){
        setState(() {
          _isInteracting = true;
          _resetTimer();
        });
      },
      onPointerUp: (_){
        setState(() {
          _isInteracting = true;
          _resetTimer();
        });
      },
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollMetricsNotification) {
            setState(() {
              _isLoading = true;
              _resetTimer();
            });
          }
          return false;
        },
        child: widget.child,
      ),
    );
  }
}




