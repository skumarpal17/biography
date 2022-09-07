import 'package:biography/myhomepage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text("World Famous Peoples"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              CarouselSlider(
                options: CarouselOptions(
                    autoPlay: true,
                    height: MediaQuery.of(context).size.height * 0.26,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                        print(_current);
                      });
                    }),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(17)),
                          child: Text(
                            'text $i',
                            style: TextStyle(fontSize: 16.0),
                          ));
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Spacer(),
                  buildIndicator(0),
                  SizedBox(
                    width: 3,
                  ),
                  buildIndicator(1),
                  SizedBox(
                    width: 3,
                  ),
                  buildIndicator(2),
                  SizedBox(
                    width: 3,
                  ),
                  buildIndicator(3),
                  SizedBox(
                    width: 3,
                  ),
                  buildIndicator(4),
                  Spacer(),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Categoryies",
                        style: TextStyle(fontSize: 21),
                      ),
                      InkWell(
                        child: const Text(
                          "View All ➤",
                          style: TextStyle(fontSize: 21),
                        ),
                        onTap: () {
                          Get.to(MyHomePage());
                        },
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i <= 5; i++)
                          Container(
                            margin:
                                EdgeInsets.only(right: 6, top: 6, bottom: 10),
                            color: Colors.amber,
                            width: Get.width * 0.49,
                            height: Get.height * 0.26,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    color: Colors.blue,
                                    width: Get.width,
                                  ),
                                ),
                                Text(
                                  "Category Name",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Sportsman",
                        style: TextStyle(fontSize: 21),
                      ),
                      InkWell(
                        child: Text(
                          "View All ➤",
                          style: TextStyle(fontSize: 21),
                        ),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i <= 5; i++)
                          Container(
                            margin: EdgeInsets.only(right: 6, top: 6),
                            color: Colors.amber,
                            width: Get.width * 0.49,
                            height: Get.height * 0.26,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    color: Colors.blue,
                                    width: Get.width,
                                  ),
                                ),
                                Text(
                                  "Category Name",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildIndicator(index) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: _current == index ? Colors.amber : Colors.grey,
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
