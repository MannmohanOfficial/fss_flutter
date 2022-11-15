// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<dynamic> users = [];
  bool typing = true;
  TextEditingController? _textEditingController = TextEditingController();
  Future getAllUser() async {
    String url =
        "http://ec2-3-143-158-60.us-east-2.compute.amazonaws.com/api/get_all_user_details";
    var body = {
      "user_id": "73",
      "accessToken": "8898f188824443e10787fff1cdd954ff"
    };

    var response = await http.post(
      Uri.parse(url),
      body: body,
    );

    if (response.statusCode == 200) {
      var resp = jsonDecode(response.body)['data'];
      setState(() {
        users = resp;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 185, 179, 179),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: _textEditingController,
            // onChanged: (value) {
            //   setState(() {
            //     users = users
            //         .where((element) => element.contains(value))
            //         .toList();
            //   });
            // },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search...',
              prefixIcon: Icon(
                Icons.search,
              ),
            ),
          ),
        ),
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.green,
        ),
        actions: [
          InkWell(
            onTap: () => setState(() {
              _textEditingController!.clear();
            }),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  'X',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Card(
                  child: CircleAvatar(
                    maxRadius: 30,
                    backgroundImage: users[index]['profile_pic'] != null
                        ? users[index]['profile_pic'] ==
                                "http://ec2-3-143-158-60.us-east-2.compute.amazonaws.com/api/uploads/profile/cropped3452602049061846613.jpg"
                            ? NetworkImage(
                                "https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_1280.png")
                            : NetworkImage(users[index]['profile_pic'])
                        : NetworkImage(
                            "https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_1280.png"),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      users[index]['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      users[index]['about'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
