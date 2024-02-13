import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:christian_sns/botnav/feeddetail.dart';
import 'package:image/image.dart' as img;
import 'dart:async';

class CreateFeedPage extends StatefulWidget {
  @override
  _CreateFeedPageState createState() => _CreateFeedPageState();
}

class _CreateFeedPageState extends State<CreateFeedPage> {
  String feedContent = '';
  File? selectedImage;
  File? selectedBackgroundImage;
  img.Image? image;
  bool _isImagePickerActive = false;

  Future<void> getImageFromGallery() async {
    if (_isImagePickerActive) {
      setState(() {
        _isImagePickerActive = false;
      });
      return;
    }

    setState(() {
      _isImagePickerActive = true;
    });

    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> getBackgroundImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedBackgroundImage = File(pickedImage.path);
      });
    }
  }

  void navigateToFeedDetailPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedDetailPage(
          backimage: selectedImage!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (selectedImage != null) {
      image = img.decodeImage(selectedImage!.readAsBytesSync())!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 17.0),
          child: const Text('헤브넷'),
        ),
        leading: Container(
          padding: EdgeInsets.only(left: 20.0, top: 20.0),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 검색 버튼 동작
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // 하트 버튼 동작
            },
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              // 메시지 버튼 동작
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(16.0),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      getImageFromGallery();
                    },
                    icon: Icon(Icons.photo_library),
                    label: Text('갤러리에서 선택'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      onPrimary: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      getBackgroundImageFromGallery();
                    },
                    icon: Icon(Icons.image),
                    label: Text('배경화면 선택'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      onPrimary: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // 선택된 이미지 확대/축소 동작
                },
                child: Container(
                  height: 300,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: selectedImage != null
                          ? Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '갤러리에서 사진을 선택해주세요.',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (selectedImage != null)
                ElevatedButton(
                  onPressed: () {
                    navigateToFeedDetailPage();
                  },
                  child: Text('작성하기'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent,
                    onPrimary: Colors.white,
                  ),
                ),
              if (selectedImage == null)
                // Tip 메시지 추가
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '게시하기 원하는 사진을 갤러리에서 선택하거나 제공하는 배경화면에서 선택 후 작성하기 버튼을 눌러주세요.',
                        style: TextStyle(
                          color: Colors.white,
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
