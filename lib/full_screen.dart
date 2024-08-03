import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class Full_screen extends StatefulWidget {
  final imgurl;
  const Full_screen({super.key, this.imgurl});

  @override
  State<Full_screen> createState() => _Full_screenState();
}

class _Full_screenState extends State<Full_screen> {
  Future<void> set_to_wallpaer() async {
    var location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgurl);
    var resutl =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    print('__________________=================+++++++++++++++++++');
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Material(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: Container(
              color: Colors.white,
              child: Image.network(
                widget.imgurl,
                fit: BoxFit.cover,
              ),
            )),
            InkWell(
              onTap: () {
                set_to_wallpaer();
                final snackBar = SnackBar(
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                  elevation: height,
                content: Center(child: Text('Wallpaer Changed',style: TextStyle(fontFamily: 'Schyler'),)),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
              },
              child: Container(
                width: width,
                height: height * 0.1,
                color: Colors.black,
                child: Center(
                    child: Text('Set Wallpaper',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Schyler',
                            color: Colors.white,
                            decoration: TextDecoration.none))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
