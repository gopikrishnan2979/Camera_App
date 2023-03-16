import 'dart:io';
import 'package:flutter/material.dart';
import 'imageshow.dart';

ValueNotifier<List> imagelist = ValueNotifier([]);

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Gallery'),),
      body: ValueListenableBuilder(
        valueListenable: imagelist,
        builder: (context, value, child) {
          return GridView.builder(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: GridTile(
                    child: Image.file(File(value[index]), fit: BoxFit.cover),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => IMageshow(index: index)));
                  },
                ),
              );
            },
            itemCount: value.length,
          );
        },
      ),
    );
  }
}
