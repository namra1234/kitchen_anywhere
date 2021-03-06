import 'dart:convert';
import 'dart:io';
// import 'dart:js';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_bloc.dart';

class NotificationService {
  /// We want singelton object of ``NotificationService`` so create private constructor
  /// Use NotificationService as ``NotificationService.instance``

  NotificationService._internal();

  static final NotificationService instance = NotificationService._internal();

  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  /// For local_notification id

  int _count = 0;

  /// ``NotificationService`` started or not.
  /// to start ``NotificationService`` call start method

  bool _started = false;

  /// Call this method on startup
  /// This method will initialise notification settings

  void start() {
    if (!_started) {
      _integrateNotification();
      _refreshToken();
      _started = true;
    }
  }

  // Call this method to initialize notification

  void _integrateNotification() {
    _registerNotification();
    _initializeLocalNotification();
  }

  /// initialize firebase_messaging plugin

  void _registerNotification() {
    _firebaseMessaging.requestPermission();

    /// App in foreground -> [onMessage] callback will be called
    /// App terminated -> Notification is delivered to system tray. When the user clicks on it to open app [onLaunch] fires
    /// App in background -> Notification is delivered to system tray. When the user clicks on it to open app [onResume] fires

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

        _showNotification(

            {
              "title": message.notification!.title,
              "body": message.notification!.body,
              "data": message.messageId,
            }

            );

    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
      //  SignupScreen()));

      print("hello");
    });


    _firebaseMessaging.onTokenRefresh
        .listen(_tokenRefresh, onError: _tokenRefreshFailure);
  }

  /// Token is unique identity of the device.
  /// Token is required when you want to send notification to perticular user.

  void _refreshToken() {
    _firebaseMessaging.getToken().then((token) async {
      print('token: $token');
    }, onError: _tokenRefreshFailure);
  }

  /// This method will be called device token get refreshed

  void _tokenRefresh(String newToken) async {
    print('New Token : $newToken');
  }

  void _tokenRefreshFailure(error) {
    print("FCM token refresh failed with error $error");
  }

  /// This method will be called on tap of the notification which came when app was in foreground
  ///
  /// Firebase messaging does not push notification in notification panel when app is in foreground.
  /// To send the notification when app is in foreground we will use flutter_local_notification
  /// to send notification which will behave similar to firebase notification

  Future<void> _onMessage(Map<String, dynamic> message) async {
    print('onMessage: $message');

    _showNotification(
      {
        "title": message['notification']['title'],
        "body": message['notification']['body'],
        "data": message['data'],
      },
    );
  }

  /// This method will be called on tap of the notification which came when app was closed

  Future<void> _onLaunch(Map<String, dynamic> message) async {
    print('onLaunch: $message');

    _performActionOnNotification(message);
  }

  /// This method will be called on tap of the notification which came when app was in background

  Future<void> _onResume(Map<String, dynamic> message) async {
    print('onResume: $message');

    _performActionOnNotification(message);
  }

  // /// This method will modify the message format of iOS Notification Data
  // Map _modifyNotificationJson(Map<String, dynamic> message) {
  //   message['data'] = Map.from(message ?? {});
  //   message['notification'] = message['aps']['alert'];
  //   return message;
  // }

  

  /// We want to perform same action of the click of the notification. So this common method will be called on
  /// tap of any notification (onLaunch / onMessage / onResume)

  void _performActionOnNotification(Map<String, dynamic> message) {
    NotificationsBloc.instance.newNotification(message);
  }

  /// used for sending push notification when app is in foreground

  void _showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'Notification Test',
      'Notification Test',

    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      ++_count,
      message['title'],
      message['body'],
      platformChannelSpecifics,
      payload: json.encode(
        message['data'],
      ),
    );
  }

  /// initialize flutter_local_notification plugin

  void _initializeLocalNotification() {
    // Settings for Android
    var androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // Settings for iOS
    var iosInitializationSettings = new IOSInitializationSettings();
    _flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings,
      ),
      onSelectNotification: (payLoad){
        Map data = json.decode(payLoad!);
        Map<String, dynamic> message = {
          "data": data,
        };
        /// This method will be called on tap of notification pushed by flutter_local_notification plugin when app is in foreground

        _performActionOnNotification(message);
      },
    );
  }



}
