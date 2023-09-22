import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Running-crew',
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32.5),
                  child: Image.asset(
                    "assets/moja.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    showImageChange();
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[100],
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class showImageChange extends StatefulWidget {
  const showImageChange({super.key});

  @override
  State<showImageChange> createState() => _showImageChangeState();
}

class _showImageChangeState extends State<showImageChange> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}