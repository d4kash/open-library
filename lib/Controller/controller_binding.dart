import 'package:bookstore/Controller/book_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
  
    Get.lazyPut<BookController>(
        () => BookController());
  }
}