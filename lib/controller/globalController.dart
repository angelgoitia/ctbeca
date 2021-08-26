import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/controller/playerController.dart';
import 'package:ctbeca/dataBase/database.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/views/loginPage.dart';

import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GlobalController extends GetxController { 
  final indexSelect = 0.obs, indexController = 0.obs, priceSLP=0.00.obs, todayPriceSLP=''.obs;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  DateTime? currentBackPressTime; 
  DBctbeca dbctbeca = DBctbeca();

  AdminController adminController = Get.put(AdminController());
  PlayerController playerController = Get.put(PlayerController());

  @override
  void onInit(){
    super.onInit();
    indexController.value = 0;
  }

  changeSelectIndex(int index)
  {
    indexSelect.value = index;
  }

  changeIndexController(int index)
  {
    indexController.value = index;
  }

  Future<bool> onBackPressed()
  {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Presiona dos veces para salir de la aplicación',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: colorPrimary,
        textColor: Colors.white,
        fontSize: 16.0
      );
      return Future.value(false);
    }
    return exit(0);
  }

  getPriceSLP() async {
    var result, response, jsonResponse;
    List<String> listUrl = ['https://api.binance.com', 'https://api1.binance.com', 'https://api2.binance.com', 'https://api3.binance.com'];
    try {
      for (var item in listUrl) {
        result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

          var parameters = jsonToUrl(jsonEncode({
            'symbol': 'SLPUSDT',
          }));

          response = await http.get(
            Uri.parse(item+"/api/v3/ticker/price$parameters"),
            headers:{
              'Content-Type': 'application/json',
              'X-Requested-With': 'XMLHttpRequest',
            },
          ); 

          jsonResponse = jsonDecode(response.body);

          if (jsonResponse['symbol'] == 'SLPUSDT') {
            priceSLP.value = double.parse(jsonResponse['price']);
            break;
          }  
        }
      }
    } on SocketException catch (_) {
      priceSLP.value = 0;
    } 
  }

  String jsonToUrl(value){
    String parametersUrl="?";
    final json = jsonDecode(value) as Map;
    for (final name in json.keys) {
      final value = json[name];
      parametersUrl = parametersUrl + "$name=$value&";
    }
    
    return parametersUrl.substring(0, parametersUrl.length-1);
  }

  removeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result, response, jsonResponse;

    loading();
    
    try {
      result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var route = prefs.getInt('type') == 0? "logout" : "logoutPlayer";
        print("entro: ${playerController.player.value.accessToken}");
        response = await http.post(
          Uri.parse(urlApi+route),
          headers:{
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
            'authorization': 'Bearer ${prefs.getInt('type') == 0? adminController.admin.value.accessToken : playerController.player.value.accessToken}',
          },
        ); 

        print(response.body);
        jsonResponse = jsonDecode(response.body);

        if (jsonResponse['statusCode'] == 201) {
          
          Get.back();
          removeVariable();

        } else{

          Get.back();
          showMessage("intentalo de nuevo mas tardes!", false);
          await Future.delayed(Duration(seconds: 1));
          Get.back();
          
        }  
      }
    } on SocketException catch (_) {

      Get.back();
      showMessage("intentalo de nuevo mas tardes!", false);   
      await Future.delayed(Duration(seconds: 1));
      Get.back();  

    }  

  }

  removeVariable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dbctbeca.deleteAll();
    prefs.remove("access_token");
    prefs.remove("type");
    Get.off(() => LoginPage(), transition: Transition.zoom);
  }

  loading(){
    Get.defaultDialog(
      title: "",
      titlePadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      barrierDismissible: false,
      content: WillPopScope(
        onWillPop: () async => false,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Cargando ",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'MontserratSemiBold',
                        )
                      ),
                      TextSpan(
                        text: "...",
                        style: TextStyle(
                          color: colorPrimary,
                          fontFamily: 'MontserratSemiBold',
                        )
                      ),
                    ]
                  ),
                ),
              ),
            ],
        ),
      ),
    );
  }

  showMessage(_titleMessage, _statusCorrectly) async {

    return Get.defaultDialog(
      title: '',
      titlePadding: EdgeInsets.zero,
      barrierDismissible: true,
      backgroundColor: Colors.white,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _statusCorrectly? Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 30,
            )
          )
          : Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.error,
              color: Colors.red,
              size: 30,
            )
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              _titleMessage,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'MontserratSemiBold',
                fontSize:14
              ),
            ),
          ),
        ],
      ),
    );
  }

  void registerNotification(type) async {

    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(messageHandler);
 
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: $message');
      showNotification(message.notification!.title, message.notification!.body);
      return;
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessage: $message');
      showNotification(message.notification!.title, message.notification!.body);
      return;
    });
    

    _firebaseMessaging.getToken().then((token) {
      print("token: $token");

      if(type == 0 && adminController.admin.value.tokenFCM != token){
        adminController.admin.value.tokenFCM = token;
        updateTokenFCM(type, token);
      }
      else if(type == 1 && playerController.player.value.tokenFCM != token){
        playerController.player.value.tokenFCM = token;
        updateTokenFCM(type, token);
      }

    }).catchError((err) {
      print("print error ${err.message}");
    });
  } 

  void updateTokenFCM(int? type, String? token) async{
    var result, response, jsonResponse;
       try {
        result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

          response = await http.post(

            Uri.parse(urlApi + "updateToken"),
            headers:{
              'Content-Type': 'application/json',
              'X-Requested-With': 'XMLHttpRequest',
              'authorization': 'Bearer ${type == 0 ? adminController.admin.value.accessToken : playerController.player.value.accessToken}',
            },
            body: jsonEncode({
              'type': type,
              'tokenFCM': token,
            }),
          ); 

          jsonResponse = jsonDecode(response.body); 

          print(jsonResponse);

          if (jsonResponse['statusCode'] == 201) {
            if(type == 0)
              adminController.getAdmin(true);
            else
              playerController.getPlayer(true);
          } 
        }
      } on SocketException catch (_) {
        print("Sin conexión a internet");
      }
  }

  Future<void> messageHandler(RemoteMessage message) async {
    print('onMessage: $message');
    showNotification(message.notification!.title, message.notification!.body);
    return;
  }

  void initialNotification() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    
    var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, 
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
  }

  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    print('onDidReceiveLocalNotification');
  }

  Future selectNotification(String? payload) async {
    
  }

  void showNotification(title, message) async {

    var androidNotificationDetails = AndroidNotificationDetails(
         '1',
        'channelName',
        'channel Description',
        priority: Priority.max,
        importance: Importance.max,
        playSound: true,
    );


    var iOSNotificationDetails = IOSNotificationDetails(presentSound: false);

    var platformChannelSpecifics = NotificationDetails(
      android: androidNotificationDetails,
      iOS:iOSNotificationDetails
    );

    await flutterLocalNotificationsPlugin.show(
        0, title, message, platformChannelSpecifics, payload: "true"
      );

    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
    ); 

  }

}