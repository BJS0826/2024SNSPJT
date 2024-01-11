import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String userName = "";
  String userEmail = "";
  String userPw = "";

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
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                '이메일',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  // 이메일 유효성 체크 로직
                });
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: '이메일을 입력하세요.',
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
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                '비밀번호',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  // 비밀번호 유효성 체크 로직
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: '비밀번호를 입력하세요.',
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
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                '비밀번호 확인',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  // 비밀번호 유효성 체크 로직
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: '비밀번호를 입력하세요.',
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Text(
                '이름',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  // 이름 유효성 체크 로직
                });
              },
              decoration: InputDecoration(
                hintText: '이름을 입력하세요.',
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
                        // 회원가입 로직
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
