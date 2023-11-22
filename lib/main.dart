import 'package:desafio_tecnico_2/app_module.dart';
import 'package:desafio_tecnico_2/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  });
}
