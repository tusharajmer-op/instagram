import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/utils/roots.dart';

import '../widgets/Buttons.dart';
import '../widgets/MyTextField.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late TextEditingController _username = TextEditingController();
  late TextEditingController _email = TextEditingController();
  late TextEditingController _password = TextEditingController();
  late TextEditingController _confirmpassword = TextEditingController();
  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmpassword = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _confirmpassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    datamaker(context) {
      roots().ProfilePicture(context, [{
        "Username": _username.text,
        "Email": _email.text,
        "Password": _password.text,
        "confirm Password": _confirmpassword.text,
      }]);
    }

    roots root = roots();
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
              "please enter your details here",
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
              controller: _email,
              label: "Email ",
              keybordtype: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            MytextField(
                controller: _password, label: "Password", obscure: true),
            const SizedBox(height: 20),
            MytextField(
              controller: _confirmpassword,
              label: "confirm Password",
              obscure: true,
            ),
            const SizedBox(height: 20),
            Flexible(flex: 5, child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                    flex: 2,
                    child: Mybuttons(
                      texts: "Need help?",
                      func: root.signup,
                      bclr: Colors.white,
                      clr: Colors.black,
                    )),
                MaterialButton(
                  onPressed: () {
                    print(_username.text);
                  },
                  child: Text("show username"),
                ),
                Flexible(
                  flex: 1,
                  child: Mybuttons(
                    texts: "next",
                    func: datamaker,
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
