import 'package:flutter/material.dart';

import '../../components/app_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child:  Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
