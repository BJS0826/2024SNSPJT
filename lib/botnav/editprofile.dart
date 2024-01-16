import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _shortBioController = TextEditingController();
  TextEditingController _prayerTitleController = TextEditingController();
  TextEditingController _favoriteHymnController = TextEditingController();
  TextEditingController _biblicalCharacterMBTIController =
      TextEditingController();
  TextEditingController _churchMembershipController = TextEditingController();
  TextEditingController _denominationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _shortBioController.dispose();
    _prayerTitleController.dispose();
    _favoriteHymnController.dispose();
    _biblicalCharacterMBTIController.dispose();
    _churchMembershipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 편집'),
      ),
      body: SingleChildScrollView(
        // 오버플로우 문제를 해결하기 위해 SingleChildScrollView로 감싸주었습니다.
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이름',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: '이름을 입력하세요',
                ),
              ),
              SizedBox(height: 16),
              Text(
                '짧은 소개',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _shortBioController,
                decoration: InputDecoration(
                  hintText: '짧은 소개를 입력하세요',
                ),
              ),
              SizedBox(height: 16),
              Text(
                '기도제목',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _prayerTitleController,
                decoration: InputDecoration(
                  hintText: '기도제목을 입력하세요',
                ),
              ),
              SizedBox(height: 16),
              Text(
                '좋아하는 찬양',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _favoriteHymnController,
                decoration: InputDecoration(
                  hintText: '좋아하는 찬양을 입력하세요',
                ),
              ),
              SizedBox(height: 16),
              Text(
                '성경 인물 MBTI',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _biblicalCharacterMBTIController,
                decoration: InputDecoration(
                  hintText: '성경 인물 MBTI를 입력하세요',
                ),
              ),
              SizedBox(height: 16),
              Text(
                '소속 교회',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _churchMembershipController,
                decoration: InputDecoration(
                  hintText: '소속 교회를 입력하세요',
                ),
              ),
              SizedBox(height: 16),
              SizedBox(height: 8),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  String name = _nameController.text;
                  String shortBio = _shortBioController.text;
                  String prayerTitle = _prayerTitleController.text;
                  String favoriteHymn = _favoriteHymnController.text;
                  String biblicalCharacterMBTI =
                      _biblicalCharacterMBTIController.text;
                  String churchMembership = _churchMembershipController.text;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('저장 완료'),
                      content: Text('프로필이 저장되었습니다.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text('확인'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('저장'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
