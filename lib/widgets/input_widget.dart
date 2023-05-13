import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:flutter_douyin/widgets/input_widget/emojis.dart';
import 'package:flutter_douyin/widgets/input_widget/my_span_builder.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({Key? key}) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> with WidgetsBindingObserver {
  double keyboardHeight = 0;
  late TextEditingController textEditingController;
  bool emojiShow = false;
  bool atShow = false;
  final GlobalKey<ExtendedTextFieldState> _key =
      GlobalKey<ExtendedTextFieldState>();

  @override
  void initState() {
    textEditingController = TextEditingController();
    // insertText('@www \uC001 ');
    textEditingController.addListener(editorListen);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    textEditingController.dispose();
    textEditingController.removeListener(editorListen);
    super.dispose();
  }

  void editorListen() {
    String text = textEditingController.text;

    if (text.isNotEmpty && text.substring(text.length - 1) == "@") {
      // FocusScope.of(context).unfocus();
    }
    setState(() {});
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQuery.of(context).viewInsets.bottom != 0) {
        setState(() {
          emojiShow = false;
          keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: keyboardHeight + 90 + (atShow ? 70 : 0),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              height: (atShow ? 70 : 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffeeeeee),
                    width: 1.0,
                  ),
                ),
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        insertText('@长笛琴人 ', 0);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(children: [
                          Container(
                            alignment: Alignment.center,
                            child: const CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  'https://i2.hdslb.com/bfs/face/de737cd746a96742c07ced6c213aa25cf0429d90.jpg@60w_60h_1c_1s_!web-avatar-comment.webp'),
                            ),
                          ),
                          Container(
                            width: 40,
                            alignment: Alignment.center,
                            child: const Text(
                              '长笛琴人',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black45),
                            ),
                          )
                        ]),
                      ),
                    );
                  }),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    // width: MediaQuery.of(context).size.width - 100,
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: ExtendedTextField(
                      key: _key,
                      autofocus: true,
                      controller: textEditingController,
                      maxLines: 3,
                      minLines: 3,
                      strutStyle: const StrutStyle(),
                      specialTextSpanBuilder: MySpecialTextSpanBuilder(
                        showAtBackground: false,
                      ),
                      cursorHeight: 18,
                      cursorColor: const Color.fromRGBO(238, 48, 88, 1),
                      style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Emojifont',
                          height: 1.2,
                          color: Color(0xff333333)),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 6),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none),
                        fillColor: const Color.fromRGBO(243, 243, 243, 1),
                        filled: true,
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            height: 1.2,
                            color: Color(0xff888888)),
                        hintText: '善语结善缘，恶言伤人心',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0, top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  debugPrint('@');
                                  setState(() {
                                    atShow = true;
                                  });
                                },
                                child: const Icon(Icons.alternate_email,
                                    color: Colors.grey),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      atShow = false;
                                      emojiShow = true;
                                    });
                                    SystemChannels.textInput
                                        .invokeMethod('TextInput.hide');
                                  },
                                  child: const Icon(
                                      Icons.emoji_emotions_outlined,
                                      color: Colors.grey),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  debugPrint('add_image');
                                },
                                child: const Icon(Icons.add_circle_outline,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                textEditingController.value.text != ""
                    ? TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20.0), // 设置圆角半径
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(40, 25)),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.all(0),
                            ),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              const TextStyle(fontSize: 12),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red,
                            )),
                        child: const Text('发送'),
                      )
                    : const Text('')
              ],
            ),
            Offstage(
              offstage: false,
              child: SizedBox(
                height: keyboardHeight,
                width: MediaQuery.of(context).size.width,
                child: emojiShow ? buildEmojiGird() : const Text(''),
              ),
            ),
          ],
        ));
  }

  void insertText(String text, int type) {
    final TextEditingValue value = textEditingController.value;
    final int start = value.selection.baseOffset;
    int end = value.selection.extentOffset;
    if (value.selection.isValid) {
      String newText = '';
      if (value.selection.isCollapsed) {
        if (end > 0) {
          newText += value.text.substring(0, end);
        }
        newText += text;
        if (value.text.length > end) {
          newText += value.text.substring(end, value.text.length);
        }
      } else {
        newText = value.text.replaceRange(start, end, text);
        end = start;
      }
      textEditingController.value = value.copyWith(
          text: newText + (type == 0 ? ' ' : ''),
          selection: value.selection.copyWith(
              baseOffset: end + text.length + (type == 0 ? 1 : 0),
              extentOffset: end + text.length + (type == 0 ? 1 : 0)));
    } else {
      textEditingController.value = TextEditingValue(
          text: text,
          selection:
              TextSelection.fromPosition(TextPosition(offset: text.length)));
    }

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      _key.currentState?.bringIntoView(textEditingController.selection.base);
    });
  }

  Widget buildEmojiGird() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            insertText(emojis[index], 1);
          },
          child: Text(
            emojis[index],
            style: const TextStyle(fontFamily: 'Emojifont', fontSize: 28),
          ),
        );
      },
      itemCount: emojis.length,
      padding: const EdgeInsets.all(5.0),
    );
  }
}
