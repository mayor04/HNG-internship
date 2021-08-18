import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  final String name;
  const ChatsScreen({Key? key, required this.name}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<Map> chatList = [];
  String message = '';
  TextEditingController messageControl = TextEditingController();

  @override
  void initState() {
    super.initState();

    Map map = {'me': false, 'chat': 'Hi ${widget.name.trim()}, this is Mayowa'};
    chatList.add(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                header(),
                line(),
                Expanded(
                  child: Container(
                    color: Colors.grey[50],
                    child: chatListWidget(),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: chat(),
            )
          ],
        ),
      ),
    );
  }

  Widget line() {
    return Container(height: 0.7, color: Colors.grey[300]);
  }

  Widget header() {
    return Container(
      height: 57,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(16, 17, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.grey,
          ),
          Text(
            'Mayowa',
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Icon(
            Icons.menu,
            size: 20,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget chatListWidget() {
    return ListView.builder(
      itemCount: chatList.length,
      itemBuilder: (_, pos) {
        Map chatMap = chatList[pos];
        bool isMe = chatMap['me'];
        return Container(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(
            isMe ? 79 : 16,
            19,
            isMe ? 16 : 79,
            2,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: isMe ? Colors.white : Colors.blueGrey,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                )
              ],
            ),
            child: Text(
              chatMap['chat'] ?? '',
              style: TextStyle(
                color: isMe ? Colors.grey[600] : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget chat() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        line(),
        GestureDetector(
          onTap: () {
            if (message.isNotEmpty) {
              chatList.add({'me': true, 'chat': message});
              message = '';
              messageControl.text = '';

              setState(() {});
            }
          },
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(child: chatBox()),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Icon(
                    Icons.send,
                    size: 17,
                    color: message.isEmpty ? Colors.grey : Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget chatBox() {
    return TextField(
      style: const TextStyle(fontSize: 14, color: Colors.black87),
      autofocus: true,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (text) {
        message = text;
        if (message.length < 3) {
          setState(() {});
        }
      },
      controller: messageControl,
      decoration: const InputDecoration(
        hintText: 'Message mayowa',
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.black45,
        ),
        contentPadding: EdgeInsets.fromLTRB(16, 5, 16, 5),
      ),
    );
  }
}
