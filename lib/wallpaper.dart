import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app_api/full_screen.dart';

class wallpaperApp extends StatefulWidget {
  const wallpaperApp({super.key});

  @override
  State<wallpaperApp> createState() => _wallpaperAppState();
}

class _wallpaperAppState extends State<wallpaperApp> {
  var page_cnt = 1;
  var images = [];
  @override
  void initState() {
    super.initState();
    fetch_api();
  }

  fetch_api() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              'KBWF1da3UHOtIrzt0Rx3FFdTQMtI25F7OXiPEup3AJrrxwdxwrh9NAbv'
        }).then(
      (value) {
        final response = jsonDecode(value.body);
        setState(() {
          images = response['photos'];
        });
      },
    );
  }

  loadMore() async {
    setState(() {
      page_cnt += 1;
      // print('________________${page_cnt}____________________'+'____________________________________');
    });
    String uri = 'https://api.pexels.com/v1/curated?per_page=80&page=' +
        page_cnt.toString();
    await http.get(Uri.parse(uri), headers: {
      'Authorization':
          'KBWF1da3UHOtIrzt0Rx3FFdTQMtI25F7OXiPEup3AJrrxwdxwrh9NAbv'
    }).then((value) {
      final response = jsonDecode(value.body);
      print(
          '--------------------------------${response['photos']}----------------------');
      setState(() {
        images.addAll(response['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Material(
      child: Column(
        children: [
          Expanded(
              child: Container(
            child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 5 / 4,
                  mainAxisSpacing: 3,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Full_screen(imgurl: images[index]['src']['large2x'],)));
                    },
                    child: Container(
                      color: Colors.white,
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
          )),
          InkWell(
            onTap: () {
              loadMore();
            },
            child: Container(
              width: width,
              height: height * 0.1,
              color: Colors.black,
              child: Center(
                  child: Text('Load More..',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Schyler',
                          color: Colors.white,
                          decoration: TextDecoration.none))),
            ),
          ),
        ],
      ),
    );
  }
}
