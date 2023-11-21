import 'package:desafio_tecnico_2/features/presenter/stores/all_books_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AllBooksStore allBooksStore = Get.find<AllBooksStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {},
          child: Text('TESTE'),
        ),
      ),
    );
  }
}
