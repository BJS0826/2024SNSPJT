import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class FeedDetailPage extends StatefulWidget {
  FeedDetailPage({super.key, required this.backimage});
  File backimage;

  @override
  _FeedDetailPageState createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends State<FeedDetailPage> {
  late String selectedCategory;
  String selectedHashTag = '';
  late String accessRange;
  late String mainText; // 그림에 들어가는 택스트
  late Color currentColor;
  late double fontSize;
  late FontWeight selectedFontWeight;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategory = "자유";
    mainText = "";
    accessRange = "전체공개";
    currentColor = Colors.white;
    fontSize = 20;
    selectedFontWeight = FontWeight.normal;
  }

  Future<void> getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        widget.backimage = File(pickedImage.path);
      });
    }
  }

  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  bool expand = false;
  TextEditingController _hashtagTextEditingController = TextEditingController();

  List<String> hashTags = [];

  void _addHashTag() {
    String newHashTag = _hashtagTextEditingController.text.trim();
    if (newHashTag.isNotEmpty && hashTags.length < 10) {
      setState(() {
        hashTags.add('#' + newHashTag);
        _hashtagTextEditingController.clear();
      });
    }
  }

  void _checkHashTag() async {
    String newHashTag = '#' + _hashtagTextEditingController.text.trim();

    if (newHashTag.isNotEmpty && hashTags.length < 10) {
      // Check if the hashTag already exists in Firestore
      bool isHashTagExists = await _isHashTagExists(newHashTag);

      if (!isHashTagExists) {
        setState(() {
          print('$newHashTag HashTag does not exist!');
        });
      } else {
        // Handle the case when the hashTag already exists
        // You can show an error message or take any other action
        print('$newHashTag HashTag already exists!');
      }
    }
  }

  void _addAllPendingHashTagsToFirestore() async {
    if (hashTags.isNotEmpty) {
      try {
        // Firestore에 연결
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        // hashtag 컬렉션의 문서 ID는 임의로 설정
        String documentId = '1HgsV3jq9l6AE0KmgUFq';

        // hashtag 문서에 일괄 추가
        await firestore.collection('hashtag').doc(documentId).update({
          'tag': FieldValue.arrayUnion(hashTags),
        });

        // 일괄 추가 후 리스트 초기화
        setState(() {
          hashTags.clear();
        });

        // 추가 완료 메시지 또는 다른 로직 수행
        print('일괄 추가 완료');
      } catch (e) {
        // 에러 발생 시 처리 로직
        print('일괄 추가 실패: $e');
      }
    }
  }

  Future<bool> _isHashTagExists(String hashTag) async {
    // Assume 'hashtag' is the collection name in Firestore
    CollectionReference<Map<String, dynamic>> hashTagCollection =
        FirebaseFirestore.instance.collection('hashtag');

    // Check if the document with the given hashTag exists
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await hashTagCollection.where('tag', arrayContains: hashTag).get();

    return querySnapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    img.Image image = img.decodeImage(widget.backimage.readAsBytesSync())!;

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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = '자유';
                      });
                    },
                    child: Text('자유'),
                    style: ElevatedButton.styleFrom(
                      primary:
                          selectedCategory == '자유' ? Colors.pink[100] : null,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = '중보기도';
                      });
                    },
                    child: Text('중보기도'),
                    style: ElevatedButton.styleFrom(
                      primary:
                          selectedCategory == '중보기도' ? Colors.pink[100] : null,
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
                      primary:
                          selectedCategory == '나눔' ? Colors.pink[100] : null,
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
                      primary:
                          selectedCategory == '감사일기' ? Colors.pink[100] : null,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = 'QT';
                      });
                    },
                    child: Text('QT'),
                    style: ElevatedButton.styleFrom(
                      primary:
                          selectedCategory == 'QT' ? Colors.pink[100] : null,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = '주일말씀';
                        selectedHashTag = '주일';
                      });
                    },
                    child: Text('주일말씀'),
                    style: ElevatedButton.styleFrom(
                      primary:
                          selectedCategory == '주일말씀' ? Colors.pink[100] : null,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {},
              ),
              GestureDetector(
                onTap: getImageFromGallery,
                child: AspectRatio(
                  aspectRatio: image.width / image.height,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        image: DecorationImage(
                            image: FileImage(widget.backimage),
                            fit: BoxFit.contain)),
                    child: Center(
                        child: Text(
                      mainText,
                      style: TextStyle(
                          color: currentColor,
                          fontSize: fontSize,
                          fontWeight: selectedFontWeight),
                    )),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                maxLines: null,
                //controller: ,
                onChanged: (value) {
                  setState(() {
                    mainText = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '그림에 들어갈 문구를 입력하세요.',
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      expand = !expand;
                    });
                  },
                  child: Text('글자 설정')),
              if (expand)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.2, 0, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('글씨크기'),
                          Slider(
                              label: '글씨크기',
                              value: fontSize,
                              min: 10.0,
                              max: 50.0,
                              onChanged: (value) {
                                setState(() {
                                  fontSize = value;
                                });
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          Text('글씨두께'),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                            child: DropdownButton<FontWeight>(
                              value: selectedFontWeight,
                              items: FontWeight.values.map((fontWeight) {
                                return DropdownMenuItem<FontWeight>(
                                  value: fontWeight,
                                  child: Text(
                                      fontWeight.toString().split('.w')[1]),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedFontWeight = value!;
                                });
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('색 선택'),
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: currentColor,
                                        onColorChanged: changeColor,
                                        pickerAreaHeightPercent: 0.8,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text('색상'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 10.0),
              TextField(
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '내용을 작성하거나 문구를 작성하세요',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                onSubmitted: (_) => _addHashTag(),
                onChanged: (_) => _checkHashTag(),
                controller: _hashtagTextEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '해쉬태그',
                    prefixText: "#"),
              ),
              SizedBox(height: 16),
              Text('총 해쉬태그 수: ${hashTags.length}/10'),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: HashTagGrid(
                      hashTags: hashTags, onHashTagDelete: _removeHashTag)),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: selectedCategory == '중보기도'
                      ? "중보기도 받는 유저"
                      : (selectedCategory == '나눔')
                          ? "나누고 싶은 유저"
                          : "유저태그",
                ),
              ),
              SizedBox(height: 10.0),
              if (selectedCategory == '감사일기' ||
                  selectedCategory == 'QT' ||
                  selectedCategory == '주일말씀')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedHashTag = '아침';
                        });
                      },
                      child: Text('아침'),
                      style: ElevatedButton.styleFrom(
                        primary:
                            selectedHashTag == '아침' ? Colors.pink[100] : null,
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
                        primary:
                            selectedHashTag == '저녁' ? Colors.pink[100] : null,
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
                        primary:
                            selectedHashTag == '주일' ? Colors.pink[100] : null,
                      ),
                    ),
                  ],
                ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '공개범위',
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                accessRange = '전체공개';
                              });
                            },
                            child: Text('전체공개'),
                            style: ElevatedButton.styleFrom(
                                primary: accessRange == '전체공개'
                                    ? Colors.pink[100]
                                    : null,
                                padding: EdgeInsets.all(10)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                accessRange = '친구만공개';
                              });
                            },
                            child: Text('친구만공개'),
                            style: ElevatedButton.styleFrom(
                              primary: accessRange == '친구만공개'
                                  ? Colors.pink[100]
                                  : null,
                              padding: EdgeInsets.all(10),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                accessRange = '태그된 유저만 공개';
                              });
                            },
                            child: Text('태그된 유저만 공개'),
                            style: ElevatedButton.styleFrom(
                              primary: accessRange == '태그된 유저만 공개'
                                  ? Colors.pink[100]
                                  : null,
                              padding: EdgeInsets.all(10),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                accessRange = '비공개';
                              });
                            },
                            child: Text('비공개'),
                            style: ElevatedButton.styleFrom(
                              primary: accessRange == '비공개'
                                  ? Colors.pink[100]
                                  : null,
                              padding: EdgeInsets.all(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ElevatedButton(
                onPressed: () async {
                  return _addAllPendingHashTagsToFirestore();
                },
                child: Text('작성하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeHashTag(int index) {
    setState(() {
      hashTags.removeAt(index);
    });
  }
}

class HashTagGrid extends StatelessWidget {
  final List<String> hashTags;
  final void Function(int) onHashTagDelete;

  const HashTagGrid({
    required this.hashTags,
    required this.onHashTagDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 4.0,
        runSpacing: 0.0,
        children: List.generate(
          hashTags.length,
          (index) => HashTagItem(
            hashTag: hashTags[index],
            onDelete: () {
              onHashTagDelete(index);
            },
          ),
        ),
      ),
    );
  }
}

class HashTagItem extends StatelessWidget {
  const HashTagItem({super.key, required this.hashTag, required this.onDelete});
  final String hashTag;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.pink[200]),
        child: InkWell(
          onTap: onDelete,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  hashTag,
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
