import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_verification.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key : key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String verificationID = "";

  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String? _email;
  String? _phoneNumber;
  bool isPasswordVisible = false;

  //method to verify phone number before code is sent 
  void loginWithPhone() async {
    _auth.verifyPhoneNumber(
      phoneNumber: "+27" + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
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

  // Widget _buildPassword() => TextFormField(
  //   keyboardType: TextInputType.visiblePassword,
  //   controller: phoneController,
  //   decoration: InputDecoration(
  //     labelText: 'Password',
  //     hintText: 'Password',
  //     suffixIcon: IconButton(
  //       icon: isPasswordVisible
  //           ? Icon(Icons.visibility_off)
  //           : Icon(Icons.visibility),
  //       onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
  //     ),
  //     border: OutlineInputBorder(),
  //   ),
  //   onSaved: (value) => setState(() => _password = value),
  //   validator: (value){
  //     if(value!.isEmpty){
  //       return 'password is required';
  //     }else{
  //       return null;
  //     }
  //   },
  // );

  Widget _buildPhone() => TextFormField(
    keyboardType: TextInputType.number,
    controller: phoneController,
    decoration: InputDecoration(
      labelText: 'Phone Number',
      hintText: 'Phone NUmber',
      suffixIcon: phoneController.text.isEmpty
          ? Container(width:0)
          : IconButton(
        icon:Icon(Icons.close),
        onPressed: () => phoneController.clear(),
      ),
      border: OutlineInputBorder(),
    ),
    onSaved: (value) => setState(() => _phoneNumber = value),
    validator: (value){
      if(value!.isEmpty){
        return 'phone number is required';
      }else{
        return null;
      }
    },
  );


  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
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

                  // SizedBox(height: 50,),
                  //
                  // _buildEmail(),

                  SizedBox(height: 10,),

                  _buildPhone(),

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
                      loginWithPhone();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTP()));
                    },
                    child: Text('LOGIN'),
                  )

                ]
            ),
          ),
        )

    );
  }
}