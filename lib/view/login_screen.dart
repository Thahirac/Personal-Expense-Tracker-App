import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:personal_expense_tracker_app/view/home/home_screen.dart';
import 'package:personal_expense_tracker_app/view/registration_screen.dart';
import 'package:provider/provider.dart';
import '../helpers/showtoast_const.dart';
import '../modal/user.dart';
import '../provider/auth_provider.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  _Login_PageState createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.deepPurple,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 40, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: const TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.blue)),
                isDense: true,
                // Added this
                contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              ),
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: const TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.blue)),
                isDense: true,
                // Added this
                contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              ),
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 40),
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
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () async {
                  if (email.text.isEmpty) {
                    CustomToast.showToast("Please enter the email id field");
                  } else if (pass.text.isEmpty) {
                    CustomToast.showToast("Please enter the password field");
                  } else {
                    final user = await Hive.box('users').get("ALL_DATA");
                    print('*******************: ${user}');
                    if (user == null) {
                      CustomToast.showToast("No user found");
                    }else{
                      await authService.login(email: email.text, password: pass.text,name: user?.name??"",isLogged: true)
                          .then((value) {
                        if (value == null) {
                          CustomToast.showToast("Invalid email Id or password");
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));

                          CustomToast.showToast("Login successfully!");
                        }
                      }

                      );
                    }

                  }
                },
              )),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Registrationpage()));
            },
            child: RichText(
                text: TextSpan(
              text: 'New User?',
              style: TextStyle(fontSize: 14.0, color: Colors.grey.shade300),
              children: <TextSpan>[
                TextSpan(
                  text: '  Register Now',
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
