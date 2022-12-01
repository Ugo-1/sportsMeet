import 'package:flutter/material.dart';

class BuddiesView extends StatefulWidget {
  const BuddiesView({Key? key}) : super(key: key);

  @override
  State<BuddiesView> createState() => _BuddiesViewState();
}

class _BuddiesViewState extends State<BuddiesView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Buddies View'),
      ),
    );
  }
}
