import 'package:desafio_tecnico_2/features/presenter/stores/all_books_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AllBooksStore allBooksStore = Get.put<AllBooksStore>(AllBooksStore());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Livros'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Favoritos'),
                  ),
                ],
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
        ),
      ),
    );
  }
}
