import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'otp_verification.dart';
import 'loginpage.dart';

class SignUp extends StatefulWidget{
  const SignUp({Key ? key}): super(key: key);

  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool confirmVisible = false;

  //confirm password method
  //confirm password
  bool confirmPassword(){
    if(passwordController.text == confirmPasswordController.text){
      return true;
    }else{
      return false;
    }
  }

  Future<void> SignUp( String email, String password) async{
    try {
      if(confirmPassword()){
        //creating user with custom UID
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        );

      }
    }on FirebaseAuthException catch (e){

      print(e.toString());
    }


  }

  //google sign in
  GoogleSignIn() async{
    //begin signin process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //get user auth details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create new user credential
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }


  //disposing of the controllers
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  //textfields
  Widget _buildEmail() => Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15.0),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.8, color: Colors.black),
            ),
            //hintStyle: TextStyle(color: Color(0xFF6BB389)),
            hintText: 'Email Address',
            prefixIcon: IconButton(icon: Icon(Icons.person, size: 28.0,), onPressed:(){} ,),
            suffixIcon:IconButton(icon:Icon(Icons.clear,), onPressed: () => emailController.clear(),)
        ),
      ),
    ),
  );

  Widget _buildPassword() => Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: isPasswordVisible,
        controller: passwordController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 0.8, color: Colors.black,),
          ),
          //hintStyle: TextStyle(color: Color(0xFF6BB389)),
          hintText: 'Password',
          prefixIcon: IconButton(icon: Icon(Icons.lock, size: 28.0,), onPressed:(){} ,),
          suffixIcon: IconButton(
            icon: isPasswordVisible
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
            onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
          ),
        ),
      ),
    ),
  );

  Widget _buildConfirmPassword() => Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: isPasswordVisible,
        controller: confirmPasswordController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all( 15.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 0.8, color: Colors.black),
          ),
          //hintStyle: TextStyle(color: Color(0xFF6BB389)),
          hintText: 'Confirm Password',
          prefixIcon: IconButton(icon: Icon(Icons.lock, size: 28.0,), onPressed:(){} ,),
          suffixIcon: IconButton(
            icon: confirmVisible
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
            onPressed: () => setState(() => confirmVisible = !confirmVisible),
          ),
        ),
      ),
    ),
  );



  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 200,
                    child: Image.asset('icons/logo.png'),
                  ),

                  Center(
                    child: Text(
                      'Create Your Account',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27
                      ),
                    ),
                  ),

                  SizedBox(height: 35,),

                 _buildEmail(),

                  SizedBox(height: 20,),

                  _buildPassword(),

                  SizedBox(height: 20,),

                  _buildConfirmPassword(),

                  SizedBox(height: 30,),

                  ElevatedButton(
                    onPressed: () => SignUp(emailController.text, passwordController.text),
                    child: Text('Signup'),
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                          color: Colors.blue,
                        )
                    ),
                  ),

                  SizedBox(height: 3,),

                  Text('or connect using', style: TextStyle(color: Colors.black)),


                  SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton.icon(
                        label: Text('Gmail', style: TextStyle(color: Colors.black54,),),
                        icon: FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.blue,
                        ),
                        onPressed: () => GoogleSignIn(),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: Size(90,50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),

                        ),
                      ),



                      ElevatedButton.icon(
                        label: Text('Phone', style: TextStyle(color: Colors.black54,),),
                        icon: FaIcon(
                          FontAwesomeIcons.phone,
                          color: Colors.blue,
                        ),
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTP())),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: Size(90,50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),

                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10,),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(width: 100,),

                      Text('already have an account?'),

                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage())),
                        child: Text('login', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),),
                      )
                    ],
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}