import 'package:flutter/material.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Discover View'),
      ),
    );
  }
}
