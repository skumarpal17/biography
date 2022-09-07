import 'package:biography/selectedlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map> myProducts =
      List.generate(15, (index) => {"id": index, "name": "Category $index"})
          .toList();
  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wd = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: SafeArea(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // maxCrossAxisExtent: 200,
                // childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Selectedlist()));
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
                          margin: EdgeInsets.all(5),
                          color: Colors.blue,
                          width: Get.width,
                        ),
                      ),
                      Text(
                        "Category Name",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 3,
                      )
                    ],
                  ), //Text(myProducts[index]["name"]
                ),
              );
            }),
      ),
    );
  }
}
