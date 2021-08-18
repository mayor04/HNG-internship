import 'package:flutter/material.dart';
import 'package:hng_stage_2/screens/chat.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              logo(),
              const SizedBox(height: 140),
              textChatWithMayowa(),
              const SizedBox(height: 50),
              SizedBox(
                width: 250,
                child: textField(),
              ),
              const SizedBox(height: 20),
              startChatButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          _openLink();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 0, 0),
          child: Image.asset(
            'assets/images/hng_logo.png',
            height: 40,
          ),
        ),
      ),
    );
  }

  _openLink() async {
    String link = 'https://hng.tech/';
    if (await canLaunch(link)) {
      await launch(link);
    } else {}
  }

  Widget textChatWithMayowa() {
    return Text(
      'Chat With \n Mayowa',
      style: TextStyle(
        color: Colors.grey[800],
        fontSize: 30,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget textField() {
    return TextField(
      style: const TextStyle(fontSize: 15, color: Colors.black87),
      autofocus: true,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (text) {
        name = text;
        if (name.length < 3) {
          setState(() {});
        }
      },
      decoration: InputDecoration(
        hintText: 'Input your name to get started',
        border: border(),
        enabledBorder: border(),
        focusedBorder: border(
          color: Colors.blue,
        ),
        hintStyle: const TextStyle(
          fontSize: 15,
          color: Colors.black38,
        ),
        contentPadding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
      ),
    );
  }

  static InputBorder border({double? radius, Color? color, double? width}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 6),
      borderSide: BorderSide(
        color: color ?? Colors.grey,
        width: width ?? 1,
      ),
    );
  }

  Widget startChatButton() {
    return GestureDetector(
      onTap: () {
        if (name.isNotEmpty) {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) {
              return ChatsScreen(name: name);
            },
          ));
        }
      },
      child: Opacity(
        opacity: name.isNotEmpty ? 1 : 0.4,
        child: Container(
          width: 250,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.17),
                blurRadius: 6,
              )
            ],
          ),
          child: const Text(
            'Start Chat',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
