import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:christian_sns/botnav/feeddetail.dart';
import 'package:image/image.dart' as img;

class CreateFeedPage extends StatefulWidget {
  @override
  _CreateFeedPageState createState() => _CreateFeedPageState();
}

class _CreateFeedPageState extends State<CreateFeedPage> {
  String feedContent = '';
  File? selectedImage;
  File? selectedBackgroundImage;
  img.Image? image;

  Future<void> getImageFromGallery() async {
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
        selectedImage = File(pickedImage.path);
      });
    }
  }

  void navigateToFeedDetailPage() {
    // FeedDetailPage로 이동하는 코드 작성
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FeedDetailPage(
                backimage: selectedImage!,
              )),
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
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // "갤러리에서 선택" 버튼 동작
                  getImageFromGallery();
                },
                child: Text('갤러리에서 선택'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 제공하는 배경화면 이미지 나열하기 나중에
                  getBackgroundImageFromGallery();
                },
                child: Text('배경화면 선택'),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // 선택된 이미지 확대/축소 동작
                },
                child: AspectRatio(
                  aspectRatio: image != null ? image!.width / image!.height : 2,
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
                            child: Text('갤러리에서 사진을 선택해주세요.'),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (selectedImage != null)
                ElevatedButton(
                  onPressed: () {
                    // 피드 작성 버튼 동작
                    // 피드 내용과 함께 작성된 피드를 서버에 전송하거나 다른 동작을 수행할 수 있습니다.
                    navigateToFeedDetailPage();
                  },
                  child: Text('작성하기'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
