import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class Createcategories2 extends StatefulWidget {
  const Createcategories2({Key? key}) : super(key: key);

  @override
  State<Createcategories2> createState() => _Createcategories2State();
}

class _Createcategories2State extends State<Createcategories2> {
  var firestore = FirebaseFirestore.instance.collection("category");
  TextEditingController category = TextEditingController();

  String imgUrl = "";
  String imgUrl2 = " ";

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
        imgUrl = value;
        imgUrl2 = value;
      });
    });
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
                    width: 210,
                    // color: Colors.green,
                  ),
                  Positioned(
                    top: 23,
                    left: 15,
                    child: Container(
                      height: 150,
                      width: Get.width,
                      color: Colors.black12,
                      child: Image(
                        image: NetworkImage(imgUrl2),
                        alignment: Alignment.center,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
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
            ),
            SizedBox(height: 10,),
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
                  firestore.add({
                    "category": category.text,
                    "time": DateTime.now(),
                    "photoUrl": imgUrl2
                  });
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
