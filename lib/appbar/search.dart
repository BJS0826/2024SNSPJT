import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String selectedCategory = '전체';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '카테고리 선택:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showCategoryDialog();
                  },
                  child: Text(selectedCategory),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('카테고리 선택'),
          content: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  _selectCategory('전체');
                  Navigator.pop(context);
                },
                child: Text('전체'),
              ),
              ElevatedButton(
                onPressed: () {
                  _selectCategory('카테고리1');
                  Navigator.pop(context);
                },
                child: Text('카테고리1'),
              ),
              ElevatedButton(
                onPressed: () {
                  _selectCategory('카테고리2');
                  Navigator.pop(context);
                },
                child: Text('카테고리2'),
              ),
              ElevatedButton(
                onPressed: () {
                  _selectCategory('카테고리3');
                  Navigator.pop(context);
                },
                child: Text('카테고리3'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }
}
