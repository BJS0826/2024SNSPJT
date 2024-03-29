import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:christian_sns/botnav/boardpost.dart';

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class BoardPost {
  String title;
  String author;
  DateTime timestamp;
  int views;
  int comments;
  String category;
  String content; // 추가: 글 내용

  BoardPost({
    required this.title,
    required this.author,
    required this.timestamp,
    required this.views,
    required this.comments,
    required this.category,
    required this.content,
  });
}

class _BoardPageState extends State<BoardPage> {
  int _selectedTabIndex = 0;

  List<String> _tabTitles = ["전체", "중보기도", "자유", "기타"];

  List<List<BoardPost>> _tabPostsList = [
    // 전체 게시물
    [
      BoardPost(
        title: "글 제목 1",
        author: "작성자1",
        timestamp: DateTime.now(),
        views: 100,
        comments: 20,
        category: "카테고리1",
        content: "글 내용 1",
      ),
      // Add more posts as needed
    ],
    // 중보기도 게시물
    [
      BoardPost(
        title: "글 제목 2",
        author: "작성자2",
        timestamp: DateTime.now(),
        views: 150,
        comments: 15,
        category: "카테고리2",
        content: "글 내용 2",
      ),
      // Add more posts as needed
    ],
    // 자유 게시물
    [
      BoardPost(
        title: "글 제목 3",
        author: "작성자3",
        timestamp: DateTime.now(),
        views: 120,
        comments: 25,
        category: "카테고리3",
        content: "글 내용 3",
      ),
      // Add more posts as needed
    ],
    // 기타 게시물
    [
      BoardPost(
        title: "글 제목 4",
        author: "작성자4",
        timestamp: DateTime.now(),
        views: 200,
        comments: 10,
        category: "카테고리4",
        content: "글 내용 4",
      ),
      // Add more posts as needed
    ],
  ];

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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildTabButtons(),
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: _selectedTabIndex,
                children: [
                  _buildPostList('전체'), // 전체
                  _buildPostList('중보기도'), // 중보기도
                  _buildPostList('자유'), // 자유
                  _buildPostList('기타'), // 기타
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BoardPostPage()),
          );
        },
        backgroundColor: Colors.lightBlueAccent, // 옅은 하늘색으로 변경
      ),
    );
  }

  List<Widget> _buildTabButtons() {
    return List.generate(
      _tabTitles.length,
      (index) => GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color:
                _selectedTabIndex == index ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _tabTitles[index],
            style: TextStyle(
              color: _selectedTabIndex == index ? Colors.black : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostList(String category) {
    // String category = '전체';
    // if (_selectedTabIndex == 0) {
    //   category = '전체';
    // } else if (_selectedTabIndex == 1) {
    //   category = '중보기도';
    // } else if (_selectedTabIndex == 2) {
    //   category = '자유';
    // } else {
    //   category = '기타';
    // }
    return FutureBuilder(
      future: category == '전체'
          ? FirebaseFirestore.instance
              .collection('snsboard')
              .orderBy('regdate', descending: true)
              .get()
          : FirebaseFirestore.instance
              .collection('snsboard')
              .where('category', isEqualTo: category)
              .orderBy('regdate', descending: true)
              .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LinearProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: LinearProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Text('No data available'),
          );
        } else
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              String title = document['title'];
              Map<String, dynamic> writer = document['writer'];
              Timestamp regdateTimestamp = document['regdate'];
              DateTime regdate = regdateTimestamp.toDate();

              String categoryeach = document['category'];
              String content = document['content'];
              int views = document['views'];
              int comments = document['comments'];

              BoardPost posts = BoardPost(
                  author: writer.values.first,
                  category: categoryeach,
                  comments: comments,
                  content: content,
                  timestamp: regdate,
                  title: title,
                  views: views);

              return GestureDetector(
                onTap: () {
                  _navigateToDetailPage(posts);
                },
                child: _buildPostCard(posts),
              );
            },
          );
      },
    );
  }

  Widget _buildPostCard(BoardPost post) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${post.author} | ${post.timestamp.toString().substring(2, 16)}",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "조회수: ${post.views} | 댓글 수: ${post.comments}",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                "${post.category}",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetailPage(BoardPost post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BoardDetailPage(post: post)),
    );
  }
}

class BoardDetailPage extends StatelessWidget {
  final BoardPost post;

  BoardDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("글 자세히 보기"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "${post.author} | ${post.timestamp.toString().substring(2, 16)}",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              "조회수: ${post.views} | 댓글 수: ${post.comments}",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                "${post.category}",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            Text(
              post.content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
