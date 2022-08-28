import 'package:flutter/material.dart';

import 'celebrityname.dart';

class Selectedlist extends StatefulWidget {
  const Selectedlist({Key? key}) : super(key: key);

  @override
  State<Selectedlist> createState() => _SelectedlistState();
}

class _SelectedlistState extends State<Selectedlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Category label"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Celebritynmae()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Card(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            child: CircleAvatar(
                              radius: 35,
                            ),
                          ),
                          Text(
                            "Actor Name",
                            style: TextStyle(fontSize: 25),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
