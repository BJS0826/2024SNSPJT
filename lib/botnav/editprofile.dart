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
    _denominationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 편집'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                _saveProfile();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent,
              ),
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              label: Text(
                '저장',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 16),
              // 프로필 이미지 선택 부분 (가운데 정렬)
              Center(
                child: GestureDetector(
                  onTap: () {
                    // 프로필 이미지 선택 로직 추가
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/logo.png'),
                    // 현재 프로필 이미지를 보여주는 로직 추가
                  ),
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이름',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      '자기 소개',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _shortBioController,
                      decoration: InputDecoration(
                        hintText: '자기 소개를 입력하세요',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '기도제목',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      '프로필 뮤직',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _favoriteHymnController,
                      decoration: InputDecoration(
                        hintText: '프로필 뮤직을 입력하세요',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '성경 인물 MBTI',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _churchMembershipController,
                      decoration: InputDecoration(
                        hintText: '소속 교회를 입력하세요',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfile() {
    // 저장 로직 추가
  }
}
