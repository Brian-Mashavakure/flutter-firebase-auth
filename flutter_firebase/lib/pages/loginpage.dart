import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_verification.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'homepage.dart';
import 'loginpage.dart';
class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key : key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  User? user;
  String verificationID = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? _email;
  String? _phoneNumber;
  String? _password;
  bool isPasswordVisible = false;

  Future Login() async{

    try{
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }on FirebaseAuthException catch (e){
      print(e);
      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
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
    super.dispose();
  }






  Widget _buildEmail() => TextFormField(
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    controller: emailController,
    decoration: InputDecoration(
      labelText: 'Email Address',
      hintText: 'Email Address',
      suffixIcon: emailController.text.isEmpty
          ? Container(width:0)
          : IconButton(
        icon:Icon(Icons.close),
        onPressed: () => emailController.clear(),
      ),
      border: OutlineInputBorder(),
    ),
    onSaved: (value) => setState(() => _email = value),
    validator: (value){
      if(value!.isEmpty){
        return 'email is required';
      }else{
        return null;
      }
    },
  );

  Widget _buildPassword() => TextFormField(
    keyboardType: TextInputType.visiblePassword,
    controller: passwordController,
    decoration: InputDecoration(
      labelText: 'Password',
      hintText: 'Password',
      suffixIcon: IconButton(
        icon: isPasswordVisible
            ? Icon(Icons.visibility_off)
            : Icon(Icons.visibility),
        onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
      ),
      border: OutlineInputBorder(),
    ),
    onSaved: (value) => setState(() => _password = value),
    validator: (value){
      if(value!.isEmpty){
        return 'password is required';
      }else{
        return null;
      }
    },
  );



  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:   [
                    Icon(Icons.android_sharp,
                      size: 80,
                    ),
                    Text(
                      'Hello User',
                      style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 34 ),),
                    SizedBox(height:20,),
                    Text('Welcome Back To Our App',
                      style: TextStyle(fontSize: 20 ),),

                    SizedBox(height: 50,),

                    _buildEmail(),

                    SizedBox(height: 10,),

                    _buildPassword(),

                    SizedBox(height:25 ,),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      onPressed: (){

                        Login().whenComplete(() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage())));
                      },
                      child: Text('LOGIN'),
                    )

                  ]
              ),
            ),
          ),
        )

    );
  }
}