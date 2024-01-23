import 'package:flutter/material.dart';

class WalkWithPage extends StatefulWidget {
  @override
  _WalkWithPageState createState() => _WalkWithPageState();
}

class _WalkWithPageState extends State<WalkWithPage> {
  List<int> checkCounts = [0, 0, 0]; // 체크 횟수를 저장하는 리스트

  @override
  Widget build(BuildContext context) {
    int checkCount = checkCounts.where((count) => count == 1).length; // 체크 횟수
    int xCount = checkCounts.where((count) => count == -1).length; // 엑스 횟수
    int totalCount = checkCounts.length; // 전체 질문 수

    double checkPercentage = (checkCount / totalCount) * 100; // 체크 퍼센테이지
    double xPercentage = (xCount / totalCount) * 100; // 엑스 퍼센테이지

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120.0,
                    height: 120.0,
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '사랑',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '성경 구절',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '요한일서 4:8\n사랑하지 아니하는 자는 하나님을 알지 못하나니 이는 하나님은 사랑이심이라',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12.0,
                              backgroundImage: AssetImage('assets/logo.png'),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '사용자 이름',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '오늘의 나눔',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // 나눔하기 버튼 동작
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text('나눔하기'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 300.0, // 카드 크기 수정을 위해 높이를 고정합니다.
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 180.0, // 카드의 너비를 조정합니다.
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/logo.png'),
                            ListTile(
                              title: Text('나눔 제목'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '글 내용',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12.0,
                                  backgroundImage:
                                      AssetImage('assets/logo.png'),
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  '사용자 이름',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '오늘의 질문',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // 상세 보기 버튼 동작
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text('전체보기'),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('질문 내용'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check_circle),
                          color: checkCounts[index] == 1
                              ? Colors.green
                              : Colors.grey,
                          onPressed: () {
                            setState(() {
                              if (checkCounts[index] == 1) {
                                checkCounts[index] = 0;
                              } else {
                                checkCounts[index] = 1;
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          color: checkCounts[index] == -1
                              ? Colors.red
                              : Colors.grey,
                          onPressed: () {
                            setState(() {
                              if (checkCounts[index] == -1) {
                                checkCounts[index] = 0;
                              } else {
                                checkCounts[index] = -1;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              Text('O : ${checkPercentage.toStringAsFixed(2)}%'),
              Text('X : ${xPercentage.toStringAsFixed(2)}%'),
            ],
          ),
        ),
      ),
    );
  }
}
