import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:core';
import 'dart:io';

class Updatecelebrity extends StatefulWidget {
  final String name;
  final String biolink;
  final String gallerylink;
  final String movielist;
  final String id;
  final String id2;
  final String imgUrl;
  const Updatecelebrity({
    Key? key,
    required this.name,
    required this.biolink,
    required this.gallerylink,
    required this.movielist,
    required this.id,
    required this.id2,
    required this.imgUrl
  }) : super(key: key);

  @override
  State<Updatecelebrity> createState() => _UpdatecelebrityState();
}

class _UpdatecelebrityState extends State<Updatecelebrity> {
  TextEditingController name = TextEditingController();
  TextEditingController biography = TextEditingController();
  TextEditingController gallery = TextEditingController();
  TextEditingController movie = TextEditingController();
  String imgUrl2 ="assets/images/nopic.png";

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
    name = widget.name == null
        ? TextEditingController()
        : TextEditingController(text: widget.name);
    biography = widget.biolink == null
        ? TextEditingController()
        : TextEditingController(text: widget.biolink);
    gallery = widget.gallerylink == null
        ? TextEditingController()
        : TextEditingController(text: widget.gallerylink);
    movie = widget.movielist == null
        ? TextEditingController()
        : TextEditingController(text: widget.movielist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Celebrity"),
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
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          imgUrl2 =="assets/images/nopic.png"? widget.imgUrl :imgUrl2 ,
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
                  FirebaseFirestore.instance
                      .collection("category")
                      .doc(widget.id)
                      .collection("celebritylist")
                      .doc(widget.id2)
                      .update({
                    "name": name.text,
                    "biography": biography.text,
                    "movie": movie.text,
                    "gallery": gallery.text,
                    "time": DateTime.now(),
                    "imgUrl" :imgUrl2 == "assets/images/nopic.png" ? widget.imgUrl : imgUrl2
                  });
                  Get.back();
                  //Addcelebrity
                },
                child: Text("update"))
          ],
        ),
      )),
    );
  }
}
