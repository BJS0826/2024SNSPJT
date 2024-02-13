import 'package:christian_sns/botnav/editprofile.dart';
import 'package:christian_sns/appbar/search.dart';
import 'package:christian_sns/appbar/notification.dart';
import 'package:christian_sns/appbar/message.dart';
import 'package:christian_sns/config/feed_item.dart';
import 'package:christian_sns/config/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FollowerListPage extends StatelessWidget {
  const FollowerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/logo.png'), // 프로필 이미지 경로로 변경
            ),
            title: Text('bjs_1998'),
            subtitle: Text(''),
            trailing: ElevatedButton(
              onPressed: () {
                // 팔로우 요청 수락 로직 추가
              },
              child: Text('수락'),
            ),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/logo.png'), // 프로필 이미지 경로로 변경
            ),
            title: Text('bjs_1998'),
            subtitle: Text('배준식'),
            trailing: ElevatedButton(
              onPressed: () {
                // 언팔로우 로직 추가
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text('언팔로우'),
            ),
          ),
          // 추가적인 팔로워를 위해 필요한 만큼 ListTile 위젯 추가
        ],
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userdata = FirebaseAuth.instance;
  userDataClass? currentUserData;
  String userId = "";

  @override
  void initState() {
    super.initState();
    userId = userdata.currentUser!.uid;
  }

  Future<void> getUserData() async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final DocumentSnapshot userDataSnapshot =
          await firebaseFirestore.collection('user').doc(userId).get();

      if (userDataSnapshot.exists) {
        Map<String, dynamic> userDataMap =
            userDataSnapshot.data() as Map<String, dynamic>;

        // Extracting data from the map
        String email = userDataMap['email'];
        List<String> interests = List<String>.from(userDataMap['interests']);
        String myChurch = userDataMap['myChurch'];
        String myIntroduction = userDataMap['myIntroduction'];
        List<String> myLocation = List<String>.from(userDataMap['myLocation']);
        Map myMoimList = userDataMap['myMoimList'];
        String pickedImage = userDataMap['picked_image'];
        String userName = userDataMap['userName'];

        // Creating an instance of userData
        userDataClass currentUserDataInstance = userDataClass(
            email: email,
            interests: interests,
            myChurch: myChurch,
            myIntroduction: myIntroduction,
            myLocation: myLocation,
            myMoimList: myMoimList,
            picked_image: pickedImage,
            userName: userName);

        // Update the state with the fetched user data

        currentUserData = currentUserDataInstance;

        // Now you can use currentUserData as needed
        print(currentUserData);
      } else {
        print("User data not found for userId: $userId");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          } else if (snapshot.hasError) {
            return LinearProgressIndicator();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('헤브넷'),
                leading: Padding(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage()),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DirectMessagePage()),
                      );
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfileDetailPage(currentUserData!),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(currentUserData!.picked_image),
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Text(
                          currentUserData!.userName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      currentUserData!.myIntroduction,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '예수님의 성품을 닮아가기를 원합니다.(user doc 아직 지정x)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('snsFeed')
                          .where('writer.$userId', isNull: false)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LinearProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return LinearProgressIndicator();
                        }
                        if (snapshot.hasData) {
                          final List<DocumentSnapshot> documents =
                              snapshot.data!.docs;

                          print('$documents');

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child:
                                        buildBox('게시물', '${documents.length}'),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FollowerPage()),
                                        );
                                      },
                                      child: buildBox('팔로워', '작업중'),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FollowingPage()),
                                        );
                                      },
                                      child: buildBox('팔로잉', '작업중'),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: documents.length, // 이미지 개수에 맞게 수정
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemBuilder: (context, index) {
                                  final document = documents[index];
                                  final data =
                                      document.data() as Map<String, dynamic>;
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PostPage(index,
                                              data), // index를 이용하여 해당 게시물 페이지를 표시
                                        ),
                                      );
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      data['feedImage']),
                                                  fit: BoxFit.cover)),
                                        )),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return Text('No data available');
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget buildBox(String title, String count) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(
            count,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class FollowerPage extends StatelessWidget {
  const FollowerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FollowerListPage();
  }
}

class FollowingPage extends StatelessWidget {
  const FollowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Following'),
      ),
      // FollowingPage의 바디 설정...
    );
  }
}

class ProfileDetailPage extends StatefulWidget {
  final userDataClass currentUserData;
  ProfileDetailPage(this.currentUserData);

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  late userDataClass currentUserData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUserData = widget.currentUserData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 상세'),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              currentUserData = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                    currentUserData: currentUserData,
                  ),
                ),
              );
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlueAccent,
            ),
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            label: Text(
              '편집',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(currentUserData.picked_image)),
            ),
            SizedBox(height: 16),
            buildProfileItem('이름', currentUserData.userName),
            buildProfileItem('자기 소개', currentUserData.myIntroduction),
            buildProfileItem('기도제목', '예수님의 성품을 닮아가기를 원합니다.'),
            buildProfileItem('프로필 뮤직', '어노인팅 - 우리의 기도'),
            buildProfileItem('성경 인물 MBTI', '바나바(INFP)'),
            buildProfileItem('소속 교회', currentUserData.myChurch),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class PostPage extends StatefulWidget {
  final int postIndex;
  final Map<String, dynamic> data;

  PostPage(this.postIndex, this.data);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool isLiked = false;
  List<String> comments = ['댓글 1', '댓글 2', '댓글 3']; // 댓글 목록
  late FeedItem postData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    postData = FeedItem(
        category: widget.data['category'],
        favorite: List<String>.from(widget.data['favorite']),
        hashTags: List<String>.from(widget.data['hashTags']),
        mainText: widget.data['mainText'],
        regdate: (widget.data['regdate'] as Timestamp).toDate(),
        right: widget.data['right'],
        userTags: Map<String, dynamic>.from(widget.data['userTags']),
        when: widget.data['when'],
        writer: Map<String, dynamic>.from(widget.data['writer']),
        id: '',
        feedImage: widget.data['feedImage']);

    print('print - $postData');
  }

  @override
  Widget build(BuildContext context) {
    for (String f in widget.data.keys) {
      print(f);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('게시물'),
      ),
      body: postData == null
          ? LinearProgressIndicator()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(postData.feedImage),
                              fit: BoxFit.fitWidth)),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            postData.category,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '건강(중보기도에서 서브 카테고리 있을 시에만 보이도록)',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postData.mainText,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '댓글',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Column(
                          children:
                              comments.map((comment) => Text(comment)).toList(),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: '댓글을 입력하세요',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                setState(() {
                                  comments.add('새로운 댓글');
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                        ),
                        SizedBox(width: 8),
                        Text(
                          '좋아요',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
