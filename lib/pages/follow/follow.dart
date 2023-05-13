import 'package:flutter/material.dart';

class Follow extends StatefulWidget {
  const Follow({Key? key}) : super(key: key);

  @override
  State<Follow> createState() => _FollowState();
}

class _FollowState extends State<Follow> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Follow'),
    );
  }
}
