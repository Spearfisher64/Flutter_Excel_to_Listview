import 'package:flutter/material.dart';
import 'package:flutter_excel_to_listview/screens/homepage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future _loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            _loginWithFacebook();
          },
          icon: const Icon(Icons.list_alt),
          label: const Text("Facebook ile giriş yap"),
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(const Size(280, 50)),
            padding:
                MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
            elevation: MaterialStateProperty.all<double>(5.0),
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xffD52941),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
      ],
    )));
  }
}
