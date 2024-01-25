import 'package:flutter/material.dart';

class DirectMessagePage extends StatelessWidget {
  final List<ChatItem> chatList = [
    ChatItem(
      profileImage: 'assets/logo.png',
      name: '사용자1',
      message: '안녕하세요!',
      isRead: true,
    ),
    ChatItem(
      profileImage: 'assets/logo.png',
      name: '사용자2',
      message: '안녕하세요! 반갑습니다.',
      isRead: false,
    ),
    ChatItem(
      profileImage: 'assets/logo.png',
      name: '사용자3',
      message: 'Flutter로 채팅 앱 만들기',
      isRead: false,
    ),
    // Add more chat items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Direct Messages'),
      ),
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(chatList[index].profileImage),
            ),
            title: Text(chatList[index].name),
            subtitle: Text(chatList[index].message),
            trailing: chatList[index].isRead
                ? Icon(Icons.done_all)
                : Icon(Icons.done),
            onTap: () {
              _openChatRoom(context, chatList[index]);
            },
          );
        },
      ),
    );
  }

  void _openChatRoom(BuildContext context, ChatItem chatItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoomPage(chatItem: chatItem),
      ),
    );
  }
}

class ChatItem {
  final String profileImage;
  final String name;
  final String message;
  final bool isRead;

  ChatItem({
    required this.profileImage,
    required this.name,
    required this.message,
    required this.isRead,
  });
}

class ChatRoomPage extends StatelessWidget {
  final ChatItem chatItem;

  ChatRoomPage({required this.chatItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(chatItem.profileImage),
            ),
            SizedBox(width: 10),
            Text(chatItem.name),
          ],
        ),
      ),
      body: Column(
        children: [
          // Chat room UI goes here
          Expanded(
            child: Container(
              color: Colors.grey.shade200,
              // Chat messages will be displayed here
            ),
          ),
          // Input area for typing messages
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Send the message
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
