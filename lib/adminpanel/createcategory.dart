import 'package:flutter/material.dart';

import 'celebritylist.dart';
import 'createcategory2.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    double wd = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories list"),
      ),
      body: SafeArea(
          child: Expanded(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (Context, index) {
              return InkWell(
                child: Card(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: ClipOval(
                          child: Image.network(
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            'https://image.shutterstock.com/image-vector/silhouette-people-unknown-male-person-260nw-1372192277.jpg',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: wd * 0.3,
                      ),
                      Text("Categories label")
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Celebritylist()));
                },
              );
            }),
      )),
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
