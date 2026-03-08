import 'package:api_integration_app/features/posts/view/post_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Api Intrigration App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home:  PostListScreen(),
    );
  }
}
