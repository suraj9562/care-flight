import 'package:care_flight/Home.dart';
import 'package:care_flight/db/usermanagement.dart';
import 'package:care_flight/screens/Login/MobileNumberScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final storage = new FlutterSecureStorage();

  final googleSignIn = GoogleSignIn();

  late GoogleSignInAccount _user;
  GoogleSignInAccount get user => _user;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      User? p = FirebaseAuth.instance.currentUser;
      await storage.write(key: 'uid', value: p!.uid);
      await setUserByEmail(p.email.toString(), p.displayName.toString());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // height: 300,
            decoration: BoxDecoration(
                color: Colors.yellow[100],
                border: Border.all(
                  color: Colors.red,
                  width: 5,
                )),
            child: SvgPicture.asset("assets/images/ambulance.svg",matchTextDirection: false,),
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration:  BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const[
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0, // soften the shadow
                      spreadRadius: 2.0, //extend the shadow
                      offset: Offset(
                        5.0, // Move to right 10  horizontally
                        5.0, // Move to bottom 10 Vertically
                      ),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MobileNumber()));
                  },
                  child: const Text(
                      "Continue with Phone Number",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                      fontSize: 18
                    ),
                  ),
                )
              ),
              Container(
                  width: double.infinity,
                  height: 60,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const[
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0, // soften the shadow
                        spreadRadius: 2.0, //extend the shadow
                        offset: Offset(
                          5.0, // Move to right 10  horizontally
                          5.0, // Move to bottom 10 Vertically
                        ),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () async{
                      await googleLogin();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
                    },
                    child: const Text(
                      "Continue With G-mail",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18
                      ),
                    ),
                  )
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: const Text(
                      "By continuing, you agree that you have read and accept our T&C and Privacy Policy"
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}
