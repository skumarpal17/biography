import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'celebrityname.dart';

class Selectedlist extends StatefulWidget {
  final String id;

  const Selectedlist({Key? key, required this.id}) : super(key: key);

  @override
  State<Selectedlist> createState() => _SelectedlistState();
}

class _SelectedlistState extends State<Selectedlist> {
  var firestore = FirebaseFirestore.instance.collection("category");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Category label"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firestore
                  .doc(widget.id)
                  .collection("celebritylist")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("Loading..."),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Celebritynmae(
                                    id: widget.id,
                                    id2: snapshot.data!.docs[index].id,
                                  )));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Card(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: CircleAvatar(
                                    radius: 40,
                                    child: ClipOval(
                                      child: Image.network(
                                        snapshot.data!.docs[index]["imgUrl"],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  snapshot.data!.docs[index]["name"],
                                  style: TextStyle(fontSize: 25),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
