import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/utils/database.dart';
import 'package:instagram/utils/roots.dart';
import 'package:instagram/widgets/Buttons.dart';
import 'package:instagram/widgets/MyTextField.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({Key? key}) : super(key: key);

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  late TextEditingController _username = TextEditingController();
  late TextEditingController _password = TextEditingController();
  roots root = roots();

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _username = TextEditingController();
      _password = TextEditingController();
    }

    @override
    void dispose() {
      super.dispose();
      _username.dispose();
      _password.dispose();
    }

    void SignIn(context) {
      DataBase().SignInUser(
          context, {"email": _username.text, "password": _password.text});
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("./assets/images/icons8-twitter.svg"),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Please enter your details here",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            MytextField(controller: _username, label: "Username"),
            const SizedBox(height: 20),
            MytextField(
                controller: _password, label: "Password", obscure: true),
            const SizedBox(height: 20),
            Flexible(flex: 1, child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                    flex: 2,
                    child: Mybuttons(
                      texts: "forgot password?",
                      func: root.signup,
                      bclr: Colors.white,
                      clr: Colors.black,
                    )),
                Flexible(
                  flex: 1,
                  child: Mybuttons(
                    texts: "login",
                    func: SignIn,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
