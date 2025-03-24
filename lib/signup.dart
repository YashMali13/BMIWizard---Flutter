
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bmi/reusable_widgets/reusable_widget.dart';
import 'package:bmi/utils/color_utils.dart';
import 'bmi_calc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'home_screen.dart';  // Assuming you have a HomeScreen



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance; // Initialize FirebaseFirestore


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                reusableTextField(
                  "Enter UserName",
                  Icons.person_outline,
                  false,
                  _userNameTextController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Enter Email Id",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outlined,
                  true,
                  _passwordTextController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final registeruserName = _userNameTextController.text.trim();
                    final registeruseremail = _emailTextController.text.trim();
                    final registeruserpass = _passwordTextController.text.trim();

                    if (registeruserName.isEmpty || registeruseremail.isEmpty || registeruserpass.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill all the fields."),),
                      );
                      return;
                    }

                    try {
                      UserCredential registeruserCredential = await _auth.createUserWithEmailAndPassword(
                        email: registeruseremail,
                        password: registeruserpass,
                      );

                      if (registeruserCredential.user != null) {
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.deepPurple,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        );

                        // Save user all data to Firestore
                        final firestore = FirebaseFirestore.instance;
                        final user = FirebaseAuth.instance.currentUser;

                        await firestore
                            .collection('USER')
                            .doc(user!.uid).set({
                          'Name': registeruserName,
                          'Email': registeruseremail,
                          'Password': registeruserpass,
                        });

                        Navigator.of(context).pop();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => BMICalculationScreen()), // Replace with your home screen
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      Navigator.of(context).pop();
                      if (e.code == 'weak-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Password is too weak.'),),
                        );
                      } else if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('The account already exists for that email.'),),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('Register'),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}