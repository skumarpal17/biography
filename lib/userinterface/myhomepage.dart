import 'package:biography/userinterface/selectedlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var firestore = FirebaseFirestore.instance.collection("category");

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wd = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firestore.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("Loading..."),
                );
              }
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // maxCrossAxisExtent: 200,
                      // childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Selectedlist(
                                  id: snapshot.data!.docs[index].id,
                                )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(0)),
                        child: Column(
                          children: [
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.all(8),
                              width: Get.width,
                              child: Image(
                                image: NetworkImage(
                                    snapshot.data!.docs[index]["imgUrl"]),
                                alignment: Alignment.center,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            )),
                            Text(
                              snapshot.data!.docs[index]["category"],
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 3,
                            )
                          ],
                        ), //Text(myProducts[index]["name"]
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
