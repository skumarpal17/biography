import 'package:biography/userinterface/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'adminpanel/createcategory.dart';

class Select extends StatefulWidget {
  const Select({Key? key}) : super(key: key);

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(() => Categories());
                },
                child: Text("Admin Panel")),
            SizedBox(
              height: 26,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => HomePage());
                },
                child: Text("Login as a user"))
          ],
        ),
      ),
    );
  }
}
