import 'package:flutter/material.dart';
import 'package:network_requests/page/network_page.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 350,
          height: 80,
          child: MaterialButton(
            color: Colors.blueAccent,
            onPressed: () {
              Navigator.pushNamed(context, NetworkPage.id);
            },
            child: Text('click me'),
          ),
        ),
      ),
    );
  }
}
