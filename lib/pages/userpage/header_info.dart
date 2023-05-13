import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderInfo extends StatelessWidget {
  const HeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 90, left: 15),
      child: Row(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 0.12.sw,
              backgroundColor: Colors.white,
              backgroundImage: const NetworkImage(
                  'https://p3-pc.douyinpic.com/img/aweme-avatar/tos-cn-avt-0015_dd6bbf583de38e271b63b18a3bb36ae2~c5_300x300.jpeg?from=2956013662'),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '喵喵漫剪',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: .04.sw,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(top: 6, bottom: 6),
                child: Row(
                  children: [
                    const Text(
                      '抖音号：zxcvbnm....',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Icon(
                        Icons.content_copy,
                        size: 16,
                        color: Colors.white70,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.only(top: 2, bottom: 2, left: 6, right: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color.fromRGBO(0, 0, 0, .3),
                ),
                child: const Text(
                  '昨日获赞100W+',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
