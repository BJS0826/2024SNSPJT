import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateFeedPage extends StatefulWidget {
  @override
  _CreateFeedPageState createState() => _CreateFeedPageState();
}

class _CreateFeedPageState extends State<CreateFeedPage> {
  String feedContent = '';
  File? selectedImage;

  Future<void> getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
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
            GestureDetector(
              onTap: () {
                // 선택된 이미지 확대/축소 동작
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: selectedImage == null
                    ? Center(
                        child: Text('갤러리에서 사진을 선택해주세요.'),
                      )
                    : Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 피드 작성 버튼 동작
                // 피드 내용과 함께 작성된 피드를 서버에 전송하거나 다른 동작을 수행할 수 있습니다.
              },
              child: Text('작성하기'),
            ),
          ],
        ),
      ),
    );
  }
}
