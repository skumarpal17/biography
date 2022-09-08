import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class Updatecategory extends StatefulWidget {
  final String category;
  final String id;
  final String imgUrl;

  const Updatecategory(
      {Key? key,
      required this.category,
      required this.id,
      required this.imgUrl})
      : super(key: key);

  @override
  State<Updatecategory> createState() => _UpdatecategoryState();
}

class _UpdatecategoryState extends State<Updatecategory> {
  var firestore = FirebaseFirestore.instance.collection("category");
  TextEditingController category = TextEditingController();

  String imgUrl2 = "";

  void pickUploadImage() async {
    var id = new DateTime.now().millisecondsSinceEpoch;
    print("this is the id $id");
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75);
    Reference ref = FirebaseStorage.instance.ref().child("${id}profile.jpg");
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        imgUrl2 = value;
      });
    });
  }

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
            SizedBox(height: 10,),
            Stack(
              children: [
                Container(
                  height: 120,
                  width: Get.width * 0.6,
                  child: Image(
                    image: NetworkImage(
                        imgUrl2 == "" ? widget.imgUrl : imgUrl2),
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          pickUploadImage();
                        },
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
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
                      .update({
                    "category": category.text,
                    "time": DateTime.now(),
                   "imgUrl": imgUrl2 == "" ? widget.imgUrl : imgUrl2
                  });
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
