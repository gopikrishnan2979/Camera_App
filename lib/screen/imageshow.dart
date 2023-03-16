import 'dart:io';
import 'package:cameraflutter/screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'gallery.dart';

class IMageshow extends StatelessWidget {
  late int index;
  IMageshow({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onPanUpdate: (details) {
            if (details.delta.dy > 0) {
              Navigator.pop(context);
            }
          },
          child: Container(
            color: Colors.black,
            child: Center(
              child: Image.file(
                File(imagelist.value[index]),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text('Are you sure you want to delete?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          delete(index, context);
                        },
                        child: const Text('Yes')),
                    TextButton(onPressed: () {Navigator.pop(context);}, child: const Text('No'))
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.delete),
        ));
  }

  Future delete(int index, ctx) async {
    final imagedb = await Hive.openBox('imgstore');
    imagedb.deleteAt(index);
    await getimages();
    Navigator.pop(ctx);
  }
}
