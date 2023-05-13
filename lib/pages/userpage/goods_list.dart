import 'package:flutter/material.dart';

class GoodsList extends StatelessWidget {
  const GoodsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 0.8),
        itemBuilder: (content, index) {
          return SizedBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://p3-ecop-imagex.byteimg.com/tos-cn-i-5bio2hw93e/a19126cfdf99488389954f14086b82b9~tplv-5bio2hw93e-origin.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '小米手机XXXXX',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: const [
                              Text(
                                '￥9999',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '已售888',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )
                            ],
                          )
                        ]),
                  )
                ]),
          );
        });
  }
}
