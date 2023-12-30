import 'package:flutter/material.dart';
import 'package:link_buddy/api/apis.dart';
import 'package:link_buddy/models/message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromid
        ? _greenMessage()
        : _blueMessage();
  }

  Widget _blueMessage() {
    return Container(
      child: Text(widget.message.msg),
    );
  }

  Widget _greenMessage() {
    return Container();
  }
}
