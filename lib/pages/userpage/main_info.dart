import 'package:flutter/material.dart';

class MainInfo extends StatelessWidget {
  const MainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: const [
                  Text(
                    '100万',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '获赞',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: const [
                    Text(
                      '100',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '关注',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: const [
                    Text(
                      '666万',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '粉丝',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ))
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), // 适当增加 padding 来调整左边距
          child: SizedBox(
            width: 200,
            child: Text(
              '分享各种奇闻异事 每天更新有趣的人生百态 喜欢的话点个关注叭..',
              style: TextStyle(height: 1.2),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xffeeeeee),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.male,
                        color: Colors.blue,
                      ),
                      Text('男', style: TextStyle(color: Colors.grey))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xffeeeeee),
                  ),
                  child:
                      const Text('IP：广东', style: TextStyle(color: Colors.grey)),
                )
              ],
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xffeeeeee),
                    ),
                    child: const Icon(Icons.shopping_bag_outlined),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Badge(
                          child: SizedBox(
                            width: 65,
                            child: Text(
                              '进入橱窗',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Text(
                          '75件好物',
                          style: TextStyle(color: Colors.black38, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xffeeeeee),
                    ),
                    child: const Icon(Icons.group_add_outlined),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '粉丝群',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          '2个群聊',
                          style: TextStyle(color: Colors.black38, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: MediaQuery.of(context).size.width - 80,
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(252, 44, 85, 1)),
                ),
                onPressed: () {
                  // Do something when button is pressed
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Icon(Icons.add), Text('关注')],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xffeeeeee),
              ),
              child: const Icon(
                Icons.arrow_drop_down_rounded,
                size: 36,
              ),
            )
          ]),
        ),
      ],
    );
  }
}
