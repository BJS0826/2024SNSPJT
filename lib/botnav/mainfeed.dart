import 'dart:async';

import 'package:christian_sns/config/feed_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 이 부분은 날짜 형식을 변환하기 위한 패키지입니다.
import 'dart:ui' as ui;

class MainFeedPage extends StatefulWidget {
  @override
  _MainFeedPageState createState() => _MainFeedPageState();
}

class _MainFeedPageState extends State<MainFeedPage> {
  ScrollController _scrollController = ScrollController();

  double _scrollPosition = 0.0;
  List<FeedItem> _feedItems = []; // FeedItem을 사용하도록 변경
  late final userdata;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    _loadMoreItems(); // 초기 데이터 로딩
    userdata = FirebaseAuth.instance;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    // Replace 'your-collection-name' with the actual name of your collection in Firestore
    String collectionName = 'snsFeed';

    // Get the last item in the current list
    FeedItem? lastItem = _feedItems.isNotEmpty ? _feedItems.last : null;

    // Query Firestore for the next batch of items
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .orderBy('regdate') // Assuming 'regdate' is the timestamp field
        .startAfter([
          lastItem != null ? lastItem.regdate : null
        ]) // Pass the field value instead of DocumentSnapshot
        .limit(10) // Adjust the limit based on your requirements
        .get();

    print("querySnapshot : $querySnapshot");

    // Process the documents and convert them to FeedItem objects
    List<FeedItem> newItems = querySnapshot.docs.map((doc) {
      return FeedItem(
          id: doc.id,
          category: doc['category'],
          favorite: List<String>.from(doc['favorite']),
          hashTags: List<String>.from(doc['hashTags']),
          mainText: doc['mainText'],
          regdate: (doc['regdate'] as Timestamp).toDate(),
          right: doc['right'],
          userTags: Map<String, dynamic>.from(doc['userTags']),
          when: doc['when'],
          writer: Map<String, dynamic>.from(doc['writer']),
          feedImage: doc['feedImage']);
    }).toList();

    // Update the state to include the new items
    setState(() {
      _feedItems.addAll(newItems);
    });
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
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
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
        body: ListView.builder(
          itemCount: _feedItems.length,
          itemBuilder: (context, index) {
            FeedItem feedItem = _feedItems[index];
            return FeedItemTile(
              feedItem: feedItem,
              currentUserUid: userdata.currentUser!.uid,
            );
          },
        )

        //  SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       SizedBox(height: 20), // 상단 여백
        //       Container(
        //         height: 100, // 스토리 영역의 높이
        //         child: ListView.builder(
        //           scrollDirection: Axis.horizontal,
        //           itemCount: 10, // 프로필 사진 개수
        //           itemBuilder: (context, index) {
        //             return Container(
        //               width: 80, // 프로필 사진 크기
        //               child: Column(
        //                 children: [
        //                   CircleAvatar(
        //                     radius: 30, // 프로필 사진 원형 모양 크기
        //                     backgroundImage: AssetImage(
        //                       'assets/logo.png', // assets 폴더 경로와 파일 이름으로 수정해주세요
        //                     ),
        //                   ),
        //                   Text('사람 이름'),
        //                 ],
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //       ListView.builder(
        //         shrinkWrap: true,
        //         physics: NeverScrollableScrollPhysics(),
        //         itemCount: 5, // 피드 개수
        //         itemBuilder: (context, index) {
        //           return Padding(
        //             padding: EdgeInsets.symmetric(horizontal: 10.0), // 좌우 여백 추가
        //             child: Card(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   ListTile(
        //                     leading: CircleAvatar(
        //                       radius: 20, // 프로필 사진 원형 모양 크기
        //                       backgroundImage: AssetImage(
        //                         'assets/logo.png', // assets 폴더 경로와 파일 이름으로 수정해주세요
        //                       ),
        //                     ),
        //                     title: Text('강현규'),
        //                     subtitle: Text('3시간 전'),
        //                   ),
        //                   Image.asset(
        //                     'assets/logo.png', // assets 폴더 경로와 파일 이름으로 수정해주세요
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Row(
        //                           children: [
        //                             Container(
        //                               decoration: BoxDecoration(
        //                                 color: Colors.blue, // 카테고리 배경색
        //                                 borderRadius: BorderRadius.circular(4.0),
        //                               ),
        //                               padding: EdgeInsets.symmetric(
        //                                 vertical: 4.0,
        //                                 horizontal: 8.0,
        //                               ),
        //                               child: Text(
        //                                 '카테고리',
        //                                 style: TextStyle(
        //                                   color: Colors.white, // 카테고리 텍스트색
        //                                 ),
        //                               ),
        //                             ),
        //                             SizedBox(width: 4.0),
        //                             Container(
        //                               decoration: BoxDecoration(
        //                                 color: Colors.green, // 해시태그 배경색
        //                                 borderRadius: BorderRadius.circular(4.0),
        //                               ),
        //                               padding: EdgeInsets.symmetric(
        //                                 vertical: 4.0,
        //                                 horizontal: 8.0,
        //                               ),
        //                               child: Text(
        //                                 '해시태그',
        //                                 style: TextStyle(
        //                                   color: Colors.white, // 해시태그 텍스트색
        //                                 ),
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                         SizedBox(height: 8.0),
        //                         Text(
        //                           '글 내용',
        //                           style: TextStyle(
        //                             fontWeight: FontWeight.bold,
        //                             fontSize: 16.0,
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                   Row(
        //                     children: [
        //                       IconButton(
        //                         icon: Icon(Icons.favorite),
        //                         onPressed: () {
        //                           // 좋아요 버튼 동작
        //                         },
        //                       ),
        //                       IconButton(
        //                         icon: Icon(Icons.comment),
        //                         onPressed: () {
        //                           // 댓글 버튼 동작
        //                         },
        //                       ),
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           );
        //         },
        //       ),
        //       SizedBox(height: 20), // 추천 친구 목록 위 여백
        //       Container(
        //         height: 200, // 추천 친구 목록의 높이
        //         child: ListView.builder(
        //           scrollDirection: Axis.horizontal,
        //           itemCount: 10, // 추천 친구 수
        //           itemBuilder: (context, index) {
        //             return Container(
        //               width: 100, // 친구 카드의 너비
        //               child: Column(
        //                 children: [
        //                   CircleAvatar(
        //                     radius: 30, // 프로필 사진 원형 모양 크기
        //                     backgroundImage: AssetImage(
        //                       'assets/logo.png', // assets 폴더 경로와 파일 이름으로 수정해주세요
        //                     ),
        //                   ),
        //                   Text('추천 친구'),
        //                 ],
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}

class FeedItemTile extends StatefulWidget {
  final FeedItem feedItem;
  final String currentUserUid;

  FeedItemTile({required this.feedItem, required this.currentUserUid});

  @override
  State<FeedItemTile> createState() => _FeedItemTileState();
}

class _FeedItemTileState extends State<FeedItemTile> {
  Future<double> getImageRatio(String imageUrl) async {
    final image = NetworkImage(imageUrl);
    final ImageStream stream = image.resolve(ImageConfiguration.empty);
    final Completer<double> completer = Completer<double>();

    stream.addListener(
        ImageStreamListener((ImageInfo info, bool synchronousCall) {
      final ui.Image img = info.image;
      final double ratio = img.width.toDouble() / img.height.toDouble();
      completer.complete(ratio);
    }, onError: (dynamic exception, StackTrace? stackTrace) {
      completer.completeError(exception);
    }));

    return completer.future;
  }

  Future<String> getUserProfileImage(String userId) async {
    // userId를 이용하여 Firestore에서 이미지 URL을 가져옴
    // 예시: Firestore에서 'users' 컬렉션에서 userId 문서를 찾고 'profileImage' 필드를 가져옴
    // 가져오는 방식은 실제 데이터 구조에 따라 다를 수 있음
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('user').doc(userId).get();
    String profileImage = userDoc['picked_image'] ?? ''; // 이미지가 없을 경우 빈 문자열 반환
    print(profileImage);
    return profileImage;
  }

  @override
  void initState() {
    super.initState();
    checkIfUserLikedFeed();
  }

  void checkIfUserLikedFeed() async {
    try {
      // Firestore에서 실시간으로 Feed 문서 가져오기
      DocumentSnapshot feedDoc = await FirebaseFirestore.instance
          .collection('snsFeed')
          .doc(widget.feedItem.id)
          .get();

      if (feedDoc.exists) {
        List<String> favoriteList =
            List<String>.from(feedDoc['favorite'] ?? []);

        // Feed의 favorite 리스트에 사용자 uid가 포함되어 있는지 확인
        setState(() {
          isFavorite = favoriteList.contains(widget.currentUserUid);
        });
      } else {
        // 문서가 존재하지 않는 경우
        setState(() {
          isFavorite = false;
        });
      }
    } catch (e) {
      print('Error checking favorite status: $e');
    }
  }

  bool isFavorite = false;

  void toggleFavoriteStatus() async {
    final CollectionReference feedCollection =
        FirebaseFirestore.instance.collection('snsFeed');

    try {
      // 해당 Feed 문서 가져오기
      DocumentSnapshot feedDoc =
          await feedCollection.doc(widget.feedItem.id).get();

      if (feedDoc.exists) {
        List<String> favoriteList =
            List<String>.from(feedDoc['favorite'] ?? []);

        // 이미 좋아요한 경우, favorite 리스트에서 제거
        if (favoriteList.contains(widget.currentUserUid)) {
          favoriteList.remove(widget.currentUserUid);
        }
        // 좋아요하지 않은 경우, favorite 리스트에 추가
        else {
          favoriteList.add(widget.currentUserUid);
        }

        // Firestore에 변경된 favorite 정보 업데이트
        await feedCollection.doc(widget.feedItem.id).update({
          'favorite': favoriteList,
        });

        print('Favorite status updated successfully!');
        checkIfUserLikedFeed();
      } else {
        print('Feed document not found.');
      }
    } catch (e) {
      print('Error updating favorite status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0), // 좌우 여백 추가
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: FutureBuilder<String>(
                future: getUserProfileImage(widget.feedItem.writer.keys.first),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    try {
                      String userProfileImage = snapshot.data!;
                      return CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(userProfileImage),
                      );
                    } catch (e) {
                      return CircleAvatar(
                        radius: 20, // 프로필 사진 원형 모양 크기
                        backgroundImage: AssetImage(
                          'assets/logo.png', // assets 폴더 경로와 파일 이름으로 수정해주세요
                        ),
                      );
                    }
                  } else {
                    return CircleAvatar(
                      radius: 20, // 프로필 사진 원형 모양 크기
                      backgroundImage: AssetImage(
                        'assets/logo.png', // assets 폴더 경로와 파일 이름으로 수정해주세요
                      ),
                    );
                  }
                },
              ),
              title: Text('${widget.feedItem.writer.values.first}'),
              subtitle: Text(
                  '${DateFormat('yyyy-MM-dd HH:mm').format(widget.feedItem.regdate)}'),
            ),
            if (widget.feedItem.feedImage.isNotEmpty)
              FutureBuilder(
                future: getImageRatio(widget.feedItem.feedImage),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    double imageRatio = snapshot.data ?? 16 / 9;
                    return AspectRatio(
                      aspectRatio: imageRatio,
                      child: Image.network(widget.feedItem.feedImage,
                          fit: BoxFit.cover),
                    );
                  }
                },
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
                          widget.feedItem.category,
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
                          'User Tags: ${widget.feedItem.userTags.values.join(', ')}',
                          style: TextStyle(
                            color: Colors.white, // 해시태그 텍스트색
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
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
                          'Hash Tags: ${widget.feedItem.hashTags.join(', ')}}',
                          style: TextStyle(
                            color: Colors.white, // 해시태그 텍스트색
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.feedItem.mainText,
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
                  icon: isFavorite
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border_outlined),
                  onPressed: () async {
                    toggleFavoriteStatus();
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
    //ListTile(
    // contentPadding: EdgeInsets.all(16.0),
    // title: Text(feedItem.mainText),
    // subtitle: Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text('Category: ${feedItem.category}'),
    //     Text('When: ${feedItem.when}'),
    //     Text('Right: ${feedItem.right}'),
    //     Text(
    //         'Regdate: ${DateFormat('yyyy-MM-dd HH:mm').format(feedItem.regdate)}'),
    //     Text(
    //         'Writer: ${feedItem.writer.values.first}'), // 여기서는 writer의 첫 번째 값을 사용했습니다.
    //     Text(
    //         'User Tags: ${feedItem.userTags.keys.join(', ')}'), // 여러 개의 User Tags가 있다면 쉼표로 구분하여 출력
    //     Text(
    //         'Hash Tags: ${feedItem.hashTags.join(', ')}'), // 여러 개의 Hash Tags가 있다면 쉼표로 구분하여 출력
    //     Text('Favorite Count: ${feedItem.favorite.length}'),
    //     //Text('Feed Image URL: ${feedItem.feedImage}'),
    //     if (feedItem.feedImage.isNotEmpty)
    //       FutureBuilder(
    //         future: getImageRatio(feedItem.feedImage),
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return CircularProgressIndicator();
    //           } else {
    //             double imageRatio = snapshot.data ?? 16 / 9;
    //             return AspectRatio(
    //               aspectRatio: imageRatio,
    //               child: Image.network(feedItem.feedImage, fit: BoxFit.cover),
    //             );
    //           }
    //         },
    //       )
    //   ],
    // ),
    // );
  }
}
