import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/data/controller/trade/running_trade_details_controller/running_trade_details_controller.dart';
import 'package:local_coin/data/repo/trade/trade_details_repo/trade_details_repo.dart';
import 'package:local_coin/data/services/api_service.dart';

import 'core/route/route.dart';
import 'data/repo/splash/splash_repo.dart';


class PushNotificationService {
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await _requestPermissions();

     await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

      String tradeId='';
      String remark = message.data['remark'];
      try{
        String clickValue = message.data['click_value'];
        tradeId=clickValue;
        checkAndRedirect(remark, tradeId);
      }catch(e){
        checkAndRedirect(remark, '');
      }

    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {

      String remark = event.data['remark'];

      final repo=Get.put(TradeDetailsRepo(apiClient: Get.find()));
      final controller =Get.put(RunningTradeDetailsController(repo: Get.find()));
      repo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.hasNewNotificationKey,true);

      if(remark.toLowerCase() =="TRADE_CHAT".toLowerCase()){
        if(Get.currentRoute==RouteHelper.tradeDetailsScreen){
          controller.onLoading();
        }
      }else{
        if(isTrade(remark) && Get.currentRoute==RouteHelper.tradeDetailsScreen){
            controller.onLoading();
        }
      }


    });

    await enableIOSNotifications();
    await registerNotificationListeners();
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings =  const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    var initSetttings =
    InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onDidReceiveNotificationResponse: (message) async {
                print('notification received');
        });

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      print('notification received');
      String? remarks=message?.data['remark'];
     if(remarks?.toLowerCase()=='TRADE_CHAT'.toLowerCase()&&Get.currentRoute==RouteHelper.tradeDetailsScreen){

     }else{
       RemoteNotification? notification = message!.notification;
       AndroidNotification? android = message.notification?.android;
       if (notification != null && android != null) {
         flutterLocalNotificationsPlugin.show(
           notification.hashCode,
           notification.title,
           notification.body,
           NotificationDetails(
             android: AndroidNotificationDetails(channel.id, channel.name,
                 channelDescription: channel.description,
                 icon: '@mipmap/ic_launcher',
                 playSound: true,
                 enableVibration: true,
                 enableLights: true,
                 fullScreenIntent: true,
                 priority: Priority.high,
                 styleInformation: const BigTextStyleInformation(''),
                 importance: Importance.high),
           ),
         );
       }
     }
    });
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  androidNotificationChannel() => const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.',
        playSound: true,
        enableVibration: true,
        enableLights: true,
        importance: Importance.high,
      );

  checkAndRedirect(String remark,String tradeId) async{

    Get.put(ApiClient(sharedPreferences: Get.find()));
    SplashRepo splashRepo =  Get.put(SplashRepo( apiClient: Get.find()));
    splashRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.hasNewNotificationKey,true);
    bool rememberMe =  splashRepo.apiClient.sharedPreferences.getBool(SharedPreferenceHelper.rememberMeKey)??false;


    if(rememberMe){

      if(remark.toLowerCase()=='BAL_ADD'.toLowerCase()
          ||remark.toLowerCase()=='BAL_SUB'.toLowerCase()){
        Get.toNamed(RouteHelper.transactionScreen);
      }else if(remark.toLowerCase()=='DEPOSIT_COMPLETE'.toLowerCase()){
        Get.toNamed(RouteHelper.depositHistoryScreen);
      }else if(remark.toLowerCase()=='WITHDRAW_APPROVE'.toLowerCase()
          ||remark.toLowerCase()=='WITHDRAW_REJECT'.toLowerCase()
          ||remark.toLowerCase()=='WITHDRAW_REQUEST'.toLowerCase()){
        Get.toNamed(RouteHelper.withdrawHistoryScreen);
      }else if(isTrade(remark)){
          if(tradeId.isEmpty){Get.toNamed(RouteHelper.loginScreen);}
          else{Get.toNamed(RouteHelper.tradeDetailsScreen,arguments: tradeId);}
      }else if(remark.toLowerCase()=='TRADE_CHAT'.toLowerCase()){
          if(tradeId.isEmpty){Get.toNamed(RouteHelper.loginScreen);}
          else{Get.toNamed(RouteHelper.tradeDetailsScreen,arguments: tradeId);}
      }else{
          Get.toNamed(RouteHelper.loginScreen);
      }

    }else{
      Get.toNamed(RouteHelper.loginScreen);
     }
  }

  Future<void> _requestPermissions() async {

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

       await androidImplementation?.requestPermission();

    }
  }

  bool isTrade(String remark){
    if(remark.toLowerCase()=='NEW_TRADE'.toLowerCase()
        ||remark.toLowerCase()=='TRADE_CANCELED'.toLowerCase()
        ||remark.toLowerCase()=='BUYER_PAID'.toLowerCase()
        ||remark.toLowerCase()=='TRADE_REPORTED'.toLowerCase()
        ||remark.toLowerCase()=='TRADE_COMPLETED'.toLowerCase()
        ||remark.toLowerCase()=='TRADE_SETTLED'.toLowerCase()){
      return true;
    }else{
      return false;
    }
  }



}
