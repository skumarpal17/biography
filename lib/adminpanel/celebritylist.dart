import 'package:biography/adminpanel/updatecelebrity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'addcelebrity.dart';

class Celebritylist extends StatefulWidget {
  final String indexID;

  const Celebritylist({Key? key, required this.indexID}) : super(key: key);

  @override
  State<Celebritylist> createState() => _CelebritylistState();
}

class _CelebritylistState extends State<Celebritylist> {
  late String id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.indexID;
  }

  var firestore = FirebaseFirestore.instance.collection("category");

  @override
  Widget build(BuildContext context) {
    double wd = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Celebrity list"),
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firestore.doc(id).collection("celebritylist").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("loading.."),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (Context, index) {
                      return InkWell(
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              child: ClipOval(
                                child: Image.network(
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  snapshot.data!.docs[index]["imgUrl"]
                                      .toString(),
                                ),
                              ),
                            ),
                            title: Text(
                                snapshot.data!.docs[index]["name"].toString()),
                            trailing: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        var id2 = snapshot.data!.docs[index].id;
                                        Get.to(
                                          Updatecelebrity(
                                            name: snapshot.data!.docs[index]
                                                ["name"],
                                            biolink: snapshot.data!.docs[index]
                                                ["biography"],
                                            gallerylink: snapshot
                                                .data!.docs[index]["movie"],
                                            movielist: snapshot
                                                .data!.docs[index]["gallery"],
                                            id2: id2,
                                            id: id,
                                            imgUrl: snapshot.data!.docs[index]
                                                ["imgUrl"],
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    "are you sure want to delete"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text("No")),
                                                  TextButton(
                                                      onPressed: () {
                                                        var id2 = snapshot.data!
                                                            .docs[index].id;
                                                        firestore
                                                            .doc(id)
                                                            .collection(
                                                                "celebritylist")
                                                            .doc(id2)
                                                            .delete();
                                                        Get.back();
                                                      },
                                                      child: Text("Yes"))
                                                ],
                                              );
                                            });
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {},
                      );
                    });
              })),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Addcelebrity(
                    indexID: id,
                  )));
        },
      ),
    );
  }
}
