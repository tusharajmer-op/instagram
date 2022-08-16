import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Tweets extends StatelessWidget {
  Tweets(this.tweet, this.profilePic, this.Username,
      {this.image = false, this.imagedata = ""});
  late String tweet;
  late String profilePic;
  late String imagedata;
  late String Username;
  bool image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Flexible(
            flex: 1,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(profilePic),
                  radius: 30.0,
                )),
          ),
          Flexible(
              flex: 5,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              Username,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey,
                                  fontSize: 18.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(tweet),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          image
                              ? Card(
                                  child: Image(
                                    image: NetworkImage(imagedata),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const SizedBox(
                                  height: 0.0,
                                ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    // bool click = false;
                                    
                                  },
                                  icon: const Icon(
                                    Icons.comment_bank_outlined,
                                    size: 20.0,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.share_outlined,
                                    size: 20.0,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite_border,
                                      size: 20.0))
                            ],
                          )
                        ]),
                  ),
                ),
              )),
        ]),
        const SizedBox(
          height: 20.0,
        ),
        const Divider()
      ],
    );
  }
}
