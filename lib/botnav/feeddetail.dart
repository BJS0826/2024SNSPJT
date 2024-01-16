import 'package:flutter/material.dart';

class FeedDetailPage extends StatefulWidget {
  @override
  _FeedDetailPageState createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends State<FeedDetailPage> {
  String selectedCategory = '';
  String selectedHashTag = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('피드 작성'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = '중보기도';
                      });
                    },
                    child: Text('중보기도'),
                    style: ElevatedButton.styleFrom(
                      primary: selectedCategory == '중보기도' ? Colors.blue : null,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = '감사일기';
                      });
                    },
                    child: Text('감사일기'),
                    style: ElevatedButton.styleFrom(
                      primary: selectedCategory == '감사일기' ? Colors.blue : null,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = '나눔';
                      });
                    },
                    child: Text('나눔'),
                    style: ElevatedButton.styleFrom(
                      primary: selectedCategory == '나눔' ? Colors.blue : null,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {},
              ),
              Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(child: Text('사진을 추가하세요.')),
              ),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewTextPage()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text('문구를 입력하세요.'),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '그림에 들어갈 문구를 입력하세요.',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '사람을 태그하세요.',
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedHashTag = '아침';
                      });
                    },
                    child: Text('아침'),
                    style: ElevatedButton.styleFrom(
                      primary: selectedHashTag == '아침' ? Colors.blue : null,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedHashTag = '저녁';
                      });
                    },
                    child: Text('저녁'),
                    style: ElevatedButton.styleFrom(
                      primary: selectedHashTag == '저녁' ? Colors.blue : null,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedHashTag = '주일';
                      });
                    },
                    child: Text('주일'),
                    style: ElevatedButton.styleFrom(
                      primary: selectedHashTag == '주일' ? Colors.blue : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('작성하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewTextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('피드 내용 작성'),
      ),
      body: Center(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: '문구를 입력하세요.',
          ),
        ),
      ),
    );
  }
}
