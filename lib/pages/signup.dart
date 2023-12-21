import 'package:chat_app/pages/home.dart';
import 'package:chat_app/service/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../service/database.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name = "", email = "", password = "", confirmpassword = "";

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController confirmpasswordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && password == confirmpassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String Id = randomAlphaNumeric(10);
        String user=mailcontroller.text.replaceAll('@gmail.com', "");
        String updateusername= user.replaceFirst(user[0], user[0].toUpperCase());
        String firstletter= user.substring(0,1).toUpperCase();

        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "E-mail": mailcontroller.text,
          "username": updateusername.toLowerCase(),
          "search": firstletter,
          "photo":'https://firebasestorage.googleapis.com/v0/b/chatapp-6bf81.appspot.com/o/profilepix.jpeg?alt=media&token=45bc808a-eb03-4bec-87e4-1620d9c5e871',
          "Id": Id,
        };
        await DatabaseMethods().addUserDetails(userInfoMap, Id);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserDisplayName(namecontroller.text);
        await SharedPreferenceHelper().saveUserEmail(mailcontroller.text);
        await SharedPreferenceHelper().saveUserPic(
          "data:image/png;base64,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",
        );
        await SharedPreferenceHelper()
            .saveUserName(mailcontroller.text.replaceAll("@gmail.com", ""));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Registered Successfully',
          style: TextStyle(
            fontSize: 20.0,
          ),
        )));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          (ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Passwoed Provided is too weak',
                style: TextStyle(fontSize: 18.0),
              ))));
        } else if (e.code == 'email-already-in-use')
          (ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Account Already exists',
                style: TextStyle(fontSize: 18.0),
              ))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff730fe), Color(0xff6380fb)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 105.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                    child: Text(
                  'Create a new Account',
                  style: TextStyle(
                      color: Color(0xffbbb0ff),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                )),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 20.0),
                      height: MediaQuery.of(context).size.height / 1.6,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              // padding: EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0, color: Colors.black38),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                controller: namecontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: Color(0xff7f30fe),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              // padding: EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0, color: Colors.black38),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                controller: mailcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter E-mail';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.mail_outline,
                                      color: Color(0xff7f30fe),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              // padding: EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0, color: Colors.black38),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                controller: passwordcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: Color(0xff7f30fe),
                                    )),
                                obscureText: true,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Confirm Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              // padding: EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0, color: Colors.black38),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                controller: confirmpasswordcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Confirm Password';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: Color(0xff7f30fe),
                                    )),
                                obscureText: true,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  "Sign Up Now!",
                                  style: TextStyle(
                                      color: Color(0xff7f30fe),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        name = namecontroller.text;
                        email = mailcontroller.text;
                        password = passwordcontroller.text;
                        confirmpassword = confirmpasswordcontroller.text;
                      });
                    }
                    registration();
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xff6380fb),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'SING UP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    ));
  }
}
