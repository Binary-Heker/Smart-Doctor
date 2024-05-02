import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:cyber_cypher_healthcare/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  TextEditingController _messageController = TextEditingController();
  var gemini = Gemini.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue.withOpacity(0.4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:
                  Provider.of<ChatContextProvider>(context).messages.length <= 4
                      ? Center(
                          child: Text("No messages yet"),
                        )
                      : ListView.builder(
                          itemCount: Provider.of<ChatContextProvider>(context)
                              .messages
                              .length-4,
                          itemBuilder: (context, index) {
                            return BubbleSpecialOne(
                              text: Provider.of<ChatContextProvider>(context)
                                  .messages[index + 4]
                                  .text,
                              isSender:
                                  Provider.of<ChatContextProvider>(context)
                                          .messages[index + 4]
                                          .role ==
                                      "user",
                            );
                          },
                        ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: AppColors.blue,
                          ),
                        ),
                        labelText: 'Message',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _messageController.clear();
                    });
                    debugPrint(Provider.of<ChatContextProvider>(context, listen: false)
                        .messages
                        .toString());
                    Provider.of<ChatContextProvider>(context, listen: false)
                        .getResponse(Provider.of<ChatContextProvider>(context, listen: false).messages.last.text);
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
