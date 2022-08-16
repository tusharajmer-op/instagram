// ignore_for_file: file_names, avoid_print
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/widgets/MyTextField.dart';
import '../utils/database.dart';
import '../utils/roots.dart';
import '../widgets/Buttons.dart';
import '../widgets/MyAlertBox.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  late TextEditingController _bio = TextEditingController();
  // ignore: non_constant_identifier_names
  late TextEditingController _Birthdate = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String nimage = "https://i.stack.imgur.com/l60Hf.png";
  Uint8List? _im = Uint8List(0);
  roots root = roots();

  @override
  void initState() {
    super.initState();
    _bio = TextEditingController();
    _Birthdate = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _bio.dispose();
    _Birthdate.dispose();
  }

  static bool loader = false;

  @override
  addDialoge(context, String res) {
    if (res == "User Created") {
      roots.HomePage(context);
    } else {
      MyAlertBox().MyalertBox(context, "Error ", "er");
      roots.HomePage(context);
    }
  }

  startloader() {
    setState(() {
      loader = true;
    });
  }

  stoploader() async {
    setState(() {
      loader = false;
    });
    addDialoge(context, "hello");
  }

  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as List;

    datamaker(context) async {
      // MyAlertBox().MyalertBox(context, "Error ", "er");
      startloader();

      String res = await DataBase().SignUpUsers([
        {
          "data": data,
          "bio": _bio.text,
          "dob": _Birthdate.text,
          "Profile_Picture": (_im!.isNotEmpty) ? _im : nimage,
        }
      ]);
      // MyAlertBox().MyalertBox(context, "Errorss ", "er");
      stoploader();
      // MyAlertBox().MyalertBox(context, "Error ", "er");
      // addDialoge(context, res);
    }

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SvgPicture.asset("./assets/images/icons8-twitter.svg"),
          Flexible(
            flex: 1,
            child: Container(),
          ),
          SizedBox(
            child: Stack(children: [
              (_im!.isNotEmpty)
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: MemoryImage(_im!),
                    )
                  : CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(nimage),
                    ),
              Positioned(
                top: 80,
                right: -5,
                child: IconButton(
                    onPressed: () async {
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      _im = await image!.readAsBytes();
                      setState(() {});
                    },
                    icon: const Icon(Icons.add_a_photo)),
              )
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          MytextField(controller: _bio, label: "bio"),
          const SizedBox(
            height: 20,
          ),
          MytextField(
            controller: _Birthdate,
            label: "Birth Date",
            keybordtype: TextInputType.datetime,
          ),
          Flexible(flex: 2, child: Container()),
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
              Flexible(
                flex: 1,
                child: loader
                    ? const Center(
                        child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                        color: Colors.white,
                      ))
                    : Mybuttons(
                        texts: "sign up",
                        func: datamaker,
                      ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
