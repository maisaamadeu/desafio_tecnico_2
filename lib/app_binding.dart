import 'package:desafio_tecnico_2/features/presenter/stores/all_books_store.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllBooksStore());
  }
}
