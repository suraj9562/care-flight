import 'package:care_flight/screens/Login/OtpManagerScreen.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class MobileNumber extends StatefulWidget {
  const MobileNumber({Key? key}) : super(key: key);

  @override
  State<MobileNumber> createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {
  @override
  final TextEditingController _textEditingController = TextEditingController();
  String contCode = "+91";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: const Text(
                    "Enter Phone Number For Verification",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 26
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                        "The number will be used for all ride-related communication. You shall "
                            "receive an SMS for code verification",
                      style: TextStyle(
                        fontSize: 16
                      ),
                    )
                ),
                CountryCodePicker(
                  onChanged: (country) {
                    setState(() {
                      contCode = country.dialCode!;
                    });
                  },
                  initialSelection: "IN",
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                ),
                TextField(
                  style: const TextStyle(
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    // border: const OutlineInputBorder(),
                    hintText: "Enter Phone Number",
                    hintStyle: const TextStyle(
                      fontSize: 20,
                    ),
                    // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                      child: Text(contCode,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,

                  // inputFormatters: [
                  //   FilteringTextInputFormatter.digitsOnly
                  // ],
                  controller: _textEditingController,
                  maxLength: 10,
                ),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                  print(_textEditingController.value);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpController(phone: _textEditingController.text, contCode: contCode)));
                },
                child: const Text(
                  "Next",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                      fontSize: 18
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
