import 'package:flutter/material.dart';

class MainFeedPage extends StatefulWidget {
  @override
  _MainFeedPageState createState() => _MainFeedPageState();
}

class _MainFeedPageState extends State<MainFeedPage> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20), // 상단 여백
            Container(
              height: 100, // 스토리 영역의 높이
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // 프로필 사진 개수
                itemBuilder: (context, index) {
                  return Container(
                    width: 80, // 프로필 사진 크기
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30, // 프로필 사진 원형 모양 크기
                          backgroundImage: AssetImage(
                            'assets/logo.png', // assets 폴더 경로와 파일 이름으로 수정해주세요
                          ),
                        ),
                        Text('사람 이름'),
                      ],
                    ),
                  );
                },
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5, // 피드 개수
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0), // 좌우 여백 추가
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 20, // 프로필 사진 원형 모양 크기
                            backgroundImage: AssetImage(
                              'assets/logo.png', // assets 폴더 경로와 파일 이름으로 수정해주세요
                            ),
                          ),
                          title: Text('강현규'),
                          subtitle: Text('3시간 전'),
                        ),
                        Image.asset(
                          'assets/logo.png', // assets 폴더 경로와 파일 이름으로 수정해주세요
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue, // 카테고리 배경색
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4.0,
                                      horizontal: 8.0,
                                    ),
                                    child: Text(
                                      '카테고리',
                                      style: TextStyle(
                                        color: Colors.white, // 카테고리 텍스트색
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green, // 해시태그 배경색
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4.0,
                                      horizontal: 8.0,
                                    ),
                                    child: Text(
                                      '해시태그',
                                      style: TextStyle(
                                        color: Colors.white, // 해시태그 텍스트색
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                '글 내용',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.favorite),
                              onPressed: () {
                                // 좋아요 버튼 동작
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.comment),
                              onPressed: () {
                                // 댓글 버튼 동작
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20), // 추천 친구 목록 위 여백
            Container(
              height: 200, // 추천 친구 목록의 높이
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // 추천 친구 수
                itemBuilder: (context, index) {
                  return Container(
                    width: 100, // 친구 카드의 너비
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30, // 프로필 사진 원형 모양 크기
                          backgroundImage: AssetImage(
                            'assets/logo.png', // assets 폴더 경로와 파일 이름으로 수정해주세요
                          ),
                        ),
                        Text('추천 친구'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
