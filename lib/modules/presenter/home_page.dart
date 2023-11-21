import 'package:desafio_tecnico_2/modules/book/external/datasources/local_storage_datasource_implementation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences sharedPreferences;
  late LocalStorageDatasourceImplementation local;

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    local = LocalStorageDatasourceImplementation(
        sharedPreferences: sharedPreferences);
  }

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

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
