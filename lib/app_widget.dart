import 'package:desafio_tecnico_2/app_binding.dart';
import 'package:desafio_tecnico_2/features/presenter/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
      initialBinding: AppBinding(),
    );
  }
}
