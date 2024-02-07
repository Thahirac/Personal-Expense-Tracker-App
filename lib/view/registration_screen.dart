import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/showtoast_const.dart';
import '../provider/auth_provider.dart';
import 'login_screen.dart';

class Registrationpage extends StatefulWidget {
  const Registrationpage({Key? key}) : super(key: key);

  @override
  _RegistrationpageState createState() => _RegistrationpageState();
}

class _RegistrationpageState extends State<Registrationpage> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final emailRegExp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');



  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthProvider>(context);

    return Scaffold(
        backgroundColor: Colors.deepPurple,
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text("Registration",style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.w600),),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: name,
                decoration: InputDecoration(

                  hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: Colors.white
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Colors.blue
                      )
                  ),
                  isDense: true,                      // Added this
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
                height:  20
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: Colors.white
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Colors.blue
                      )
                  ),
                  isDense: true,                      // Added this
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
                height:   20
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: pass,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: Colors.white
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Colors.blue
                      )
                  ),
                  isDense: true,                      // Added this
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height:20),

            Container(
                height: 50,
                width: 200,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        // Change your radius here
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child:  Text("Sign-Up",style: TextStyle(fontSize: 18),),
                  onPressed: () async{

                    if(name.text.isEmpty){

                      CustomToast.showToast("Please enter the name field");

                    }else if(email.text.isEmpty){

                      CustomToast.showToast("Please enter the email id field");

                    }else if(!emailRegExp.hasMatch(email.text)){

                      CustomToast.showToast("Please enter a valid email");

                    }else if(pass.text.isEmpty){

                      CustomToast.showToast("Please enter the password field");

                    }else{
                      await authService.register(email: email.text, password: pass.text,name: name.text,isLogged: false);

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Page()));

                      CustomToast.showToast("Registration successfully!");
                    }

                  },
                )),

            SizedBox(height:40),



            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Page()));
              },
              child: RichText(
                  text:  TextSpan(
                    text: 'Old User?',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey.shade300),
                    children: <TextSpan>[
                      TextSpan(
                        text: '  Login Now',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ],
                  )),
            )

          ],
        ),
    );
  }



}