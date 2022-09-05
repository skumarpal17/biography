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
  String imgUrl2 = "";

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75);
    Reference ref = FirebaseStorage.instance.ref().child("profile.jpg");
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
                    width: 150,
                    // color: Colors.green,
                  ),
                  Positioned(
                    top: 23,
                    left: 15,
                    child: CircleAvatar(
                      radius: 60,
                      child: ClipOval(
                        child: Image.network(imgUrl2,fit: BoxFit.cover, width: 100,height: 100,)
                      ),
                    ),
                  ),
                  Positioned(
                      top: 90,
                      right: 9,
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
                  firestore
                      .add({"category": category.text, "time": DateTime.now()});
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
