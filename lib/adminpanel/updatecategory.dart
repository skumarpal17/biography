import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Updatecategory extends StatefulWidget {
  final String category;
  final String id;
  const Updatecategory({Key? key, required this.category, required this.id})
      : super(key: key);

  @override
  State<Updatecategory> createState() => _UpdatecategoryState();
}

class _UpdatecategoryState extends State<Updatecategory> {
  var firestore = FirebaseFirestore.instance.collection("category");
  TextEditingController category = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = widget.category == null
        ? TextEditingController()
        : TextEditingController(text: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Category"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    // color: Colors.green,
                  ),
                  Positioned(
                    top: 23,
                    left: 15,
                    child: CircleAvatar(
                      radius: 60,
                      child: ClipOval(
                        child: Image.network(
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          'https://image.shutterstock.com/image-vector/silhouette-people-unknown-male-person-260nw-1372192277.jpg',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 90,
                      right: 9,
                      child: CircleAvatar(
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {},
                        ),
                      )),
                ],
              ),
            ),
            TextField(
              controller: category,
              decoration: InputDecoration(
                  labelText: "category name", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("category")
                      .doc(widget.id)
                      .update(
                          {"category": category.text, "time": DateTime.now()});
                  // firestore
                  //     .add({"category": category.text, "time": DateTime.now()});
                  Get.back();
                  category.clear();
                },
                child: Text("submit"))
          ],
        ),
      )),
    );
  }
}
