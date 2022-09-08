import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:core';
import 'dart:io';

class Addcelebrity extends StatefulWidget {
  final String indexID;

  const Addcelebrity({Key? key, required this.indexID}) : super(key: key);

  @override
  State<Addcelebrity> createState() => _AddcelebrityState();
}

class _AddcelebrityState extends State<Addcelebrity> {

  String imgUrl = "";

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
      });
    });
  }

  late String id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.indexID;
  }

  TextEditingController name = TextEditingController();
  TextEditingController biography = TextEditingController();
  TextEditingController gallery = TextEditingController();
  TextEditingController movie = TextEditingController();

  var firestore = FirebaseFirestore.instance.collection("category");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Celebrity"),
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
                        child:imgUrl == "" ? Image.asset("assets/images/nopic.png"):Image.network(
                          width: 122,
                          height: 122,
                          fit: BoxFit.cover,
                          imgUrl,
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
                          onPressed: () {
                            pickUploadImage();
                          },
                        ),
                      )),
                ],
              ),
            ),

            ///name
            TextField(
              controller: name,
              decoration: InputDecoration(
                  labelText: "name", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),

            ///biography link
            TextField(
              controller: biography,
              decoration: InputDecoration(
                  labelText: "biography link", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),

            ///gallery link
            TextField(
              controller: gallery,
              decoration: InputDecoration(
                  labelText: "Gallery link", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),

            ///movie list
            TextField(
              controller: movie,
              decoration: InputDecoration(
                  labelText: "movie list", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  firestore.doc(id).collection("celebritylist").add({
                    "name": name.text,
                    "biography": biography.text,
                    "movie": movie.text,
                    "gallery": gallery.text,
                    "time": DateTime.now(),
                    "imgUrl":imgUrl
                  });
                  Get.back();
                  //Addcelebrity
                },
                child: Text("submit"))
          ],
        ),
      )),
    );
  }
}
