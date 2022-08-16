import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/CreateTweetScreen.dart';
import 'package:instagram/utils/database.dart';
import 'package:instagram/widgets/tweet.dart';

class TweetScreen extends StatefulWidget {
  const TweetScreen({Key? key}) : super(key: key);

  @override
  State<TweetScreen> createState() => _TweetScreenState();
}

class _TweetScreenState extends State<TweetScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController Controler =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));
  late final Animation<double> _animation =
      CurvedAnimation(curve: Curves.easeInOutBack, parent: Controler);

  @override
  void dispose() {
    // TODO: implement dispose
    Controler.dispose();
    super.dispose();
  }

  List<Widget> tw = [];
  bool loader = true;

  tweet() {
    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    tweet();
    super.initState();
  }

  int size = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        loader
            ? const SizedBox(
                height: 0.0,
              )
            : StreamBuilder<QuerySnapshot>(
                stream: DataBase.gettweets(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      List<DocumentChange> items = snapshot.data!.docChanges;
                      if (size < items.length) {
                        for (var e in items) {
                          if (e.doc.data().toString().contains("imagePath")) {
                            // print(e.doc.get("tweet"));
                            tw.add(Tweets(
                              e.doc.get("tweet"),
                              e.doc.get("profilPicture"),
                              e.doc.get("username"),
                              image: true,
                              imagedata: e.doc.get("imagePath"),
                            ));

                            print("hidfladf");
                          } else {
                            tw.add(Tweets(
                              e.doc.get("tweet"),
                              e.doc.get("profilPicture"),
                              e.doc.get("username"),
                            ));
                          }
                        }
                        // print(tw);
                      }
                      size = items.length;
                    }
                  }
                  
                  
                  return ListView.builder(
                      itemCount: tw.length,
                      itemBuilder: ((context, index) {
                        return tw[index];
                       
                      }));
                }),
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 20.0),
          child: FloatingActionButton(
            onPressed: () {
              Controler.forward();
              Controler.addListener(() {
                setState(() {
                  if (Controler.isCompleted) {
                    Navigator.pushNamed(context, CreateTweet.id);
                    Controler.value = 0;
                  }
                });
              });
            },
            backgroundColor: Colors.blue,
            child: RotationTransition(
              turns: _animation,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
