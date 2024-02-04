import 'package:flutter/material.dart';

class BoardPostPage extends StatefulWidget {
  @override
  _BoardPostPageState createState() => _BoardPostPageState();
}

class _BoardPostPageState extends State<BoardPostPage> {
  String _selectedCategory = "전체";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("글쓰기"),
        actions: [
          // 글 작성 버튼 추가
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              // 작성한 글을 전송하는 로직 추가
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 카테고리 선택
            Text(
              "카테고리 선택",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              value: _selectedCategory,
              items: [
                DropdownMenuItem<String>(
                  child: Text("전체"),
                  value: "전체",
                ),
                DropdownMenuItem<String>(
                  child: Text("중보기도"),
                  value: "중보기도",
                ),
                DropdownMenuItem<String>(
                  child: Text("자유"),
                  value: "자유",
                ),
                DropdownMenuItem<String>(
                  child: Text("기타"),
                  value: "기타",
                ),
                // 다른 카테고리 아이템 추가
              ],
              onChanged: (String? value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),

            SizedBox(height: 16),

            // 제목 TextField
            TextField(
              decoration: InputDecoration(
                labelText: "제목",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            // 내용 TextField
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: InputDecoration(
                labelText: "내용",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            // 이미지 첨부 버튼
            ElevatedButton.icon(
              icon: Icon(Icons.image),
              label: Text("이미지 첨부"),
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent, // 옅은 하늘색
              ),
              onPressed: () {
                // 이미지 첨부 로직 추가
              },
            ),

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
