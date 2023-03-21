import 'dart:io';
import 'package:cameraflutter/screen/filesave.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'gallery.dart';

class homescreen extends StatelessWidget {
  homescreen({super.key});

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    getimages();
    return Scaffold(
      appBar: AppBar(
        title: const Text('CAMERA APP'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          InkWell(
            borderRadius: BorderRadius.circular(83),
            onTap: () {
              _addimage();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(75))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Camera',
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(
                      Icons.camera,
                      size: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ClipRect(
            child: InkWell(
              borderRadius: BorderRadius.circular(48),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => const Gallery()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Gallery',
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(
                        Icons.image,
                        size: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Future _addimage() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    final imagedb = await Hive.openBox('imgstore');
    imagedb.add(image.path);
    await getimages();
    await saveImage(File(image.path), basename(image.path));
  }
}

Future<void> getimages() async {
  final imagedb = await Hive.openBox('imgstore');
  imagelist.value.clear();
  imagelist.value.addAll(imagedb.values);
  imagelist.notifyListeners();
}
