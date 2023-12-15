import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF553370),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xffc199cd),
                    ),
                    SizedBox(width: 90.0),
                    Text(
                      'Shivam Gupta',
                      style: TextStyle(
                          color: Color(0xffc199cd),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 50.0, bottom: 40.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.15,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 2),
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 234, 236, 240),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      child: Text(
                        'Hello, How was your day?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 3),
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 211, 228, 243),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          )),
                      child: Text(
                        'The Day was really good ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Spacer(),
                    Material(
                      elevation: 5.0,
                       borderRadius: BorderRadius.circular(30),
                      child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      hintStyle:
                                          TextStyle(color: Colors.black45)),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFf3f3f3),
                                      borderRadius: BorderRadius.circular(60)),
                                  child: Center(
                                      child: Icon(
                                    Icons.send,
                                    color: Color.fromARGB(255, 164, 154, 154),
                                  )))
                            ],
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
