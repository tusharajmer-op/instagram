import 'dart:typed_data';

class DataModals {
  // tweet database modal
  late String _tweets;
  late String _imagePath;
  late String _username;
  late String _profilePic;

  tweetModal(String tweets, String username, String profilePic,
      {String imagepath = "", bool im = false, }) {
    _tweets = tweets;
    _username = username;
    _profilePic = profilePic;
    _imagePath = imagepath;
    if (!im) {
      
      return <String, dynamic>{
        "username": _username,
        "profilPicture": _profilePic,
        "tweet": _tweets,
      };
    } else {
      return <String, dynamic>{
        "username": username,
        "profilPicture": _profilePic,
        "tweet": _tweets,
        "imagePath": _imagePath,
        
      };
    }
  }
}
