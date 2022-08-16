// ignore_for_file: await_only_futures

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/utils/Global.dart';
import 'package:instagram/utils/modal.dart';
import 'package:instagram/widgets/Buttons.dart';
import 'package:instagram/widgets/MyAlertBox.dart';
import 'package:uuid/uuid.dart';

import '../utils/database.dart';

class CreateTweet extends StatefulWidget {
  const CreateTweet({Key? key}) : super(key: key);
  static const String id = "/CreateTweets";

  @override
  State<CreateTweet> createState() => _CreateTweetState();
}

class _CreateTweetState extends State<CreateTweet> {
  final ImagePicker _imagePicker = ImagePicker();
  Uint8List _im = Uint8List(0);
  late DocumentSnapshot _userData;
  bool loader = false;

  getuser() async {
    _userData = await DataBase.getdata();
    print(_userData.get('profile_picture'));
    if (_userData.get('profile_picture') !=
        "https://i.stack.imgur.com/l60Hf.png") {
      print(_userData.get('profile_picture'));
      setState(() {
        loader = true;
      });
    }
  }

  late TextEditingController _tweet;
  @override
  void initState() {
    getuser();
    super.initState();
    _tweet = TextEditingController();
  }

  @override
  void dispose() {
    _tweet.dispose();
    super.dispose();
  }

  bool isuploading = false;
  _Tweet(context) async {
    if (_tweet.text == "" && _im.isEmpty) {
      MyAlertBox().MyalertBox(
          context, "Please enter Something before posting", "Incomplete Tweet");
    } else {
      Map tweetData = await DataModals().tweetModal(
          _tweet.text, Global.user, Global.profilePicPath,
          im: _im.isNotEmpty, imagepath: const Uuid().v4());
      setState(() {
        isuploading = true;
      });
      isuploading =
          await DataBase().Createtweets(tweetData, _im.isNotEmpty, _im);
      setState(() {});
      if (!isuploading) {
        MyAlertBox().MyalertBox(context, "Tweeted", "successful");
      } else {
        MyAlertBox().MyalertBox(
            context, "Cant Tweet \n try after sometime...", "Error");
      }
      Navigator.pushNamed(context, "/homepage");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            isuploading
                ? const LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Colors.blue,
                  )
                : const SizedBox(
                    height: 0.0,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    flex: 2,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close))),
                Flexible(
                    flex: 1,
                    child: Mybuttons(
                        texts: "Tweet", bclr: Colors.blue, func: _Tweet))
              ],
            ),
            Expanded(
              child: ListView(shrinkWrap: true, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 20.0),
                      child: Hero(
                        tag: "avtar",
                        child: CircleAvatar(
                          backgroundImage: loader
                              ? NetworkImage(_userData.get('profile_picture'))
                              : const NetworkImage(
                                  "https://i.stack.imgur.com/l60Hf.png"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _tweet,
                        decoration: const InputDecoration(
                            labelText: "What's happening? ",
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never),
                        maxLines: null,
                        minLines: null,
                      ),
                    ),
                  ],
                ),
                _im.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  55.0, 0.0, 15.0, 0.0),
                              child: Image(
                                height: 400.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: MemoryImage(_im),
                              ),
                            )
                          ])
                    : const SizedBox(
                        height: 0.0,
                      )
              ]),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    final XFile? image = await _imagePicker.pickImage(
                        source: ImageSource.gallery);
                    print("hello ${await image!} ");
                    if (image != null) {
                      _im = await image.readAsBytes();
                    }
                    setState(() {});
                  },
                  icon: const Icon(Icons.image_outlined),
                ),
                IconButton(
                  onPressed: () async {
                    final XFile? image = await _imagePicker.pickImage(
                        source: ImageSource.camera);

                    if (image != null) {
                      _im = await image.readAsBytes();
                    }
                    setState(() {});
                  },
                  icon: const Icon(Icons.camera_alt_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
