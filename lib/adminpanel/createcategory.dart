import 'package:biography/adminpanel/updatecategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'celebritylist.dart';
import 'createcategory2.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var firestore = FirebaseFirestore.instance.collection("category");
  var id1 = "";

  @override
  Widget build(BuildContext context) {
    double wd = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories list"),
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firestore.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("Loading"),
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
                            leading:  Container(
                              height: 60,
                              width: 90,
                              color: Colors.black12,
                              child: Image(
                                image: NetworkImage(snapshot.data!.docs[index]["imgUrl"]),
                                alignment: Alignment.center,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                            title: Text(snapshot.data!.docs[index]["category"]),
                            trailing: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {});
                                        var id2 = snapshot.data!.docs[index].id;

                                        Get.to(Updatecategory(
                                          category: snapshot.data!.docs[index]
                                              ["category"],
                                          id: id2,
                                          imgUrl: snapshot.data!.docs[index]["imgUrl"],
                                        ));
                                      },
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    "Are you sure want to delete"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          var id = snapshot
                                                              .data!
                                                              .docs[index]
                                                              .id;
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "category")
                                                              .doc(id)
                                                              .delete();
                                                        });
                                                        Get.back();
                                                      },
                                                      child: Text("Yes")),
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text("No")),
                                                ],
                                              );
                                            });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {});
                          id1 = snapshot.data!.docs[index].id;
                          Get.to(() => Celebritylist(indexID: id1),
                              transition: Transition.circularReveal);
                          print("this is category id $id1");
                        },
                      );
                    });
              })),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Createcategories2()));
        },
      ),
    );
  }
}
