class Global {
  static late String user;
  static late String profilePicPath;
  static late String email;
  static Updateuser(username, dppath) {
    user = username;
    profilePicPath = dppath;
  }

  static updateemail(eml) {
    email = eml;
  }

  static Updateprofilepic(dppath) {
    profilePicPath = dppath;
  }
}
