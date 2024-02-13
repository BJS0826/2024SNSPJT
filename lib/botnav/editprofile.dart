import 'dart:io';

import 'package:christian_sns/config/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final userDataClass currentUserData;
  const EditProfilePage({super.key, required this.currentUserData});

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
  User? userData;
  userDataClass currentUserData = userDataClass();
  File? _image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData = FirebaseAuth.instance.currentUser;
    currentUserData = widget.currentUserData;
  }

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

  // Future<void> _getImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     var croppedFile = await ImageCropper().cropImage(
  //       sourcePath: pickedFile.path,
  //       maxWidth: 700,
  //       maxHeight: 700,
  //       aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
  //       aspectRatioPresets: const [
  //         CropAspectRatioPreset.original,
  //         CropAspectRatioPreset.square,
  //         CropAspectRatioPreset.ratio3x2,
  //         CropAspectRatioPreset.ratio4x3,
  //         CropAspectRatioPreset.ratio16x9
  //       ],
  //       cropStyle: CropStyle.rectangle,
  //       compressFormat: ImageCompressFormat.jpg,
  //       compressQuality: 70,
  //       uiSettings: [
  //         AndroidUiSettings(
  //           toolbarTitle: 'Crop Image',
  //           toolbarColor: Colors.deepOrange,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false,
  //         ),
  //       ],
  //     );

  //     if (croppedFile != null) {
  //       _image = await convertCroppedFileToFile(croppedFile);

  //       setState(() {
  //         _image = _image;
  //       });
  //     }
  //   }
  // }

  // Future<File> convertCroppedFileToFile(CroppedFile croppedFile) async {
  //   final tempDir = await getTemporaryDirectory();
  //   final uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   final File tempFile = File('${tempDir.path}/$uniqueFileName.jpg');

  //   // Get the cropped image file as bytes
  //   final croppedBytes = await croppedFile.readAsBytes();

  //   // Write the cropped image bytes to the new file
  //   await tempFile.writeAsBytes(croppedBytes);

  //   return tempFile;
  // }

  @override
  Widget build(BuildContext context) {
    Future<void> _saveProfile() async {
      String name = _nameController.text;
      String introduction = _shortBioController.text;
      String church = _churchMembershipController.text;

      if (name == currentUserData.userName &&
          introduction == currentUserData.myIntroduction &&
          church == currentUserData.myChurch) {
        return Navigator.pop(context, currentUserData);
      }

      Map<String, dynamic> userDataUpdate = {};
      if (name != null && name.isNotEmpty) {
        userDataUpdate['userName'] = name;
      }
      if (introduction != null && introduction.isNotEmpty) {
        userDataUpdate['myIntroduction'] = introduction;
      }
      if (church != null && church.isNotEmpty) {
        userDataUpdate['myChurch'] = church;
      }

      // 업데이트할 필드가 없으면 업데이트를 건너뜁니다.
      if (userDataUpdate.isEmpty) {
        return Navigator.pop(context, currentUserData);
      }

      await FirebaseFirestore.instance
          .collection('user')
          .doc(userData!.uid)
          .update(userDataUpdate);

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(userData!.uid)
          .get();

      currentUserData = userDataClass(
        picked_image: snapshot['picked_image'],
        userName: snapshot['userName'],
        myIntroduction: snapshot['myIntroduction'],
        myChurch: snapshot['myChurch'],
      );
      Navigator.pop(context, currentUserData);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 편집'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () async {
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
                  onTap: () async {
                    // _getImage();
                  },
                  child: _image != null
                      ? CircleAvatar(
                          radius: 50, backgroundImage: FileImage(_image!)

                          // 현재 프로필 이미지를 보여주는 로직 추가
                          )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(currentUserData.picked_image),
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
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: currentUserData.userName,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '자기 소개',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _shortBioController,
                      decoration: InputDecoration(
                        labelText: currentUserData.myIntroduction,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '기도제목',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _prayerTitleController,
                      decoration: InputDecoration(
                        labelText: '기도제목을 입력하세요',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '프로필 뮤직',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _favoriteHymnController,
                      decoration: InputDecoration(
                        labelText: '프로필 뮤직을 입력하세요',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '성경 인물 MBTI',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _biblicalCharacterMBTIController,
                      decoration: InputDecoration(
                        labelText: '성경 인물 MBTI를 입력하세요',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '소속 교회',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _churchMembershipController,
                      decoration: InputDecoration(
                        labelText: currentUserData.myChurch,
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
}
