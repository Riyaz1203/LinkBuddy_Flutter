import 'package:flutter/material.dart';
import 'package:link_buddy/helper/my_date_util.dart';
import 'package:link_buddy/main.dart';
import 'package:link_buddy/models/chat_user.dart';

class ViewProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.user.name),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Joined On  ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                myDateUtil.getLastMessageTime(
                    context: context,
                    time: widget.user.createdAt,
                    showYear: true),
                style: const TextStyle(color: Color.fromARGB(255, 31, 31, 31)),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: mq.width,
                    height: mq.height * .05,
                  ),
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        widget.user.image,
                        height: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * .02,
                  ),
                  Text(
                    widget.user.email,
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(
                    height: mq.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'About : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.user.about,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 31, 31, 31)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
