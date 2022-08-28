import 'package:flutter/material.dart';

class Celebritynmae extends StatefulWidget {
  const Celebritynmae({Key? key}) : super(key: key);

  @override
  State<Celebritynmae> createState() => _CelebritynmaeState();
}

class _CelebritynmaeState extends State<Celebritynmae> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Label Name"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              CircleAvatar(
                radius: 40,
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    height: 55,
                    child: Card(
                      child: Text(
                        "BIOGRAPHY",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    child: Card(
                      child: Text(
                        "MOVIE LIST",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    child: Card(
                      child: Text(
                        "GALLERY",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
