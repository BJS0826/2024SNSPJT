import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  String userName = "";
  String userEmail = "";
  String userPw = "";
  final TextEditingController _emailRegister = TextEditingController();
  final TextEditingController _pwRegister = TextEditingController();
  final TextEditingController _pwRegister2 = TextEditingController();
  final TextEditingController _nameRegister = TextEditingController();
  var emailColor = Colors.red;
  var pwColor = Colors.red;
  var pwColor2 = Colors.red;
  var nameColor = Colors.red;
  bool emailV = false;
  bool emailV2 = false;
  bool pwV = false;
  bool pwV2 = false;
  bool nameV = false;

  Future<void> _signUp(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailRegister.text,
        password: _pwRegister.text,
      );

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;
        Map<String, dynamic> myMoimList = {};
        List<String> interests = [];
        String myChurch = "";
        List<String> myLocation = [];
        String myIntroduction = "자기소개를 채워주세요";
        String imageURL =
            "https://firebasestorage.googleapis.com/v0/b/ndproject-743d6.appspot.com/o/user_images%2Flogo.png?alt=media&token=21da4c39-5b63-4a94-9558-4bd5f002fe8c";

        // 사용자 정보를 Firestore 또는 Realtime Database에 저장 (예: Firestore)
        // 여기에서는 예시로 Firestore를 사용하는 방법을 보여줍니다.
        // Firestore에 사용자 정보 저장
        await _storage.collection('user').doc(uid).set({
          'email': _emailRegister.text,
          'userName': _nameRegister.text,
          // 'picked_image': imageURL,
          // 'myMoimList': myMoimList,
          // 'interests': interests,
          // 'myChurch': myChurch,
          // 'myLocation': myLocation,
          // 'myIntroduction': myIntroduction
        });

        // 회원가입 성공 시 작업 수행
        // 예: 다음 화면으로 이동
        if (context.mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("회원가입 완료"),
            backgroundColor: Colors.blue,
          ));
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => MainFeedPage()));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("$e"),
          backgroundColor: Colors.blue,
        ));
      }
      // 회원가입 실패 시 예외 처리
      // 예: 오류 메시지를 보여주거나 적절한 처리를 진행
    }
  }

  @override
  void dispose() {
    _emailRegister.dispose();
    _pwRegister.dispose();
    _nameRegister.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 17.0),
          child: Row(
            children: [
              SizedBox(width: 8.0), // 아이콘과 텍스트 사이의 간격
              Text('회원가입'),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    '이메일',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  if (emailV)
                    Text(
                      "  V",
                      style: TextStyle(
                          color: emailColor, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
            TextFormField(
              controller: _emailRegister,
              onChanged: (value) {
                setState(() {
                  if (value!.isNotEmpty) {
                    emailV = true;
                    emailColor = Colors.red;
                    if (value.length > 6 &&
                        value.contains("@") &&
                        value.contains(".")) {
                      emailColor = Colors.green;
                    }
                  } else {
                    emailV = false;
                  }
                });
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: Text('이메일을 입력하세요.'),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    '비밀번호',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  if (pwV)
                    Text(
                      "  V",
                      style: TextStyle(
                          color: pwColor, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
            TextFormField(
              controller: _pwRegister,
              onChanged: (value) {
                setState(() {
                  if (value!.isNotEmpty) {
                    pwV = true;
                    pwColor = Colors.red;
                    if (value.length >= 7) {
                      pwColor = Colors.green;
                    }
                  } else {
                    pwV = false;
                  }
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                label: Text('비밀번호를 입력하세요.'),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    '비밀번호 확인',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  if (pwV2)
                    Text(
                      "  V",
                      style: TextStyle(
                          color: pwColor2, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
            TextFormField(
              controller: _pwRegister2,
              onChanged: (value) {
                setState(() {
                  if (value!.isNotEmpty) {
                    pwV2 = true;
                    pwColor2 = Colors.red;
                    if (value == _pwRegister.text) {
                      pwColor2 = Colors.green;
                    }
                  } else {
                    pwV2 = false;
                  }
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                label: Text('비밀번호를 입력하세요.'),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    '이름',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  if (nameV)
                    Text(
                      "  V",
                      style: TextStyle(
                          color: nameColor, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
            TextFormField(
              controller: _nameRegister,
              onChanged: (value) {
                setState(() {
                  setState(() {
                    if (value!.isNotEmpty) {
                      nameV = true;
                      nameColor = Colors.red;
                      if (value.length >= 2) {
                        nameColor = Colors.green;
                      }
                    } else {
                      nameV = false;
                    }
                  });
                });
              },
              decoration: InputDecoration(
                label: Text('이름을 입력하세요.'),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary:
                            const Color(0xFFFF6F61), // 헥사 코드 #FF6F61 (코랄 핑크)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        onPrimary: Colors.white, // 텍스트 색상을 흰색으로 지정
                      ),
                      onPressed: () {
                        if (emailColor == Colors.green &&
                            pwColor == Colors.green &&
                            nameColor == Colors.green) {
                          _signUp(context);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("회원가입 실패"),
                            backgroundColor: Colors.blue,
                          ));
                        }
                      },
                      child: const Text('회원가입'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
