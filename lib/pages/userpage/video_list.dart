import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mock.dart';

class VideoList extends StatelessWidget {
  const VideoList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 0.8),
        itemBuilder: (content, index) {
          return InkWell(
            onTap: () {
              Get.toNamed('/preview_video', arguments: {'index': index});
            },
            child: Image.network(
              (coverList[(index % coverList.length).toInt()]['cover']),
              fit: BoxFit.cover,
            ),
          );
        });
  }
}
