import 'package:care_flight/Home.dart';
import 'package:care_flight/screens/Login/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final storage = new FlutterSecureStorage();

  Future<bool> checkLogin() async{
    String? value = await storage.read(key: 'uid');
    if(value == null){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: FutureBuilder(
          future: checkLogin(),
          builder:(BuildContext context, AsyncSnapshot<bool> snapshot ){
            if(snapshot.data==false){
              return MainScreen();
            }
            else if(snapshot.connectionState == ConnectionState.waiting){
              return Container(
                color: Colors.grey,
                child: CircularProgressIndicator(),
              );
            }
            return Home();
          }
      ),
    );
  }
}
