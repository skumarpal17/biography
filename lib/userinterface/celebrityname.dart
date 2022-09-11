import 'package:biography/userinterface/biography.dart';
import 'package:biography/userinterface/gallery.dart';
import 'package:biography/userinterface/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Celebritynmae extends StatefulWidget {
  final String id;
  final String id2;

  const Celebritynmae({
    Key? key,
    required this.id,
    required this.id2,
  }) : super(key: key);

  @override
  State<Celebritynmae> createState() => _CelebritynmaeState();
}

class _CelebritynmaeState extends State<Celebritynmae> {
  var firestore = FirebaseFirestore.instance.collection("category");
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: firestore
            .doc(widget.id)
            .collection("celebritylist")
            .doc(widget.id2)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: Text("Loading..."),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data!["name"]),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: Image.network(
                          snapshot.data!["imgUrl"],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        InkWell(
                          child: Container(
                            height: 55,
                            child: Card(
                              child: Text(
                                "Biography",
                                // snapshot.data!["biography"],
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.to(() => Biography(
                                  biography: snapshot.data!["biography"],
                                ));
                          },
                        ),
                        InkWell(
                          child: Container(
                            height: 55,
                            child: Card(
                              child: Text(
                                "Movie",
                                //snapshot.data!["movie"],
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.to(() => Movie(
                                  movie: snapshot.data!["movie"],
                                ));
                          },
                        ),
                        InkWell(
                          child: Container(
                            height: 55,
                            child: Card(
                              child: Text(
                                "Gallery",
                                //snapshot.data!["gallery"],
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.to(() => Gallery(
                                  gallery: snapshot.data!["gallery"],
                                ));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
