class userDataClass {
  final String email;
  final List<String> interests;
  final String myChurch;
  final String myIntroduction;
  final List<String> myLocation;
  final Map myMoimList;
  final String picked_image;
  final String userName;

  userDataClass(
      {this.myChurch = '',
      this.myIntroduction = '',
      this.myLocation = const [],
      this.myMoimList = const {},
      this.picked_image = '',
      this.userName = '',
      this.email = '',
      this.interests = const []});

  @override
  String toString() {
    return "UserData(email: $email, interests : $interests, myChurch : $myChurch, myIntroduction : $myIntroduction, myLocation : $myLocation, myMoimList : $myMoimList, picked_image : $picked_image, userName 이름! : $userName)";
  }
}
