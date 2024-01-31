// models/feed_item.dart

class FeedItem {
  final String id;
  final String category;
  final List<String> favorite;
  final List<String> hashTags;
  final String mainText;
  final DateTime regdate;
  final String right;
  final Map<String, dynamic> userTags;
  final String when;
  final Map<String, dynamic> writer;
  final String feedImage;

  FeedItem({
    required this.feedImage,
    required this.id,
    required this.category,
    required this.favorite,
    required this.hashTags,
    required this.mainText,
    required this.regdate,
    required this.right,
    required this.userTags,
    required this.when,
    required this.writer,
  });

  @override
  String toString() {
    return 'FeedItem{id: $id, category: $category, favorite: $favorite, hashTags: $hashTags, '
        'mainText: $mainText, regdate: $regdate, right: $right, userTags: $userTags, '
        'when: $when, writer: $writer ...}';
  }
}
