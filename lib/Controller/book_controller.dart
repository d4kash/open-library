import 'dart:convert';

import 'package:bookstore/features/books/data/repository/book_repo.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  BookRepository api = BookRepository();
  RxBool isLoading = false.obs;
  Future<String> fetchBooks() async {
    isLoading.value = true;
    var response = await api.bookgetApi();
    // print("sucess: on fetch books: ${response}");
    String stringResponse = json.encode(response['reading_log_entries']);
    isLoading.value = false;
    return stringResponse;
    // }).onError((error, stackTrace) {
    //   print("error: on fetch books: $error");
    //   return "";
    // });
  }

  Future<String> searchBooks(String query) async {
       isLoading.value = true;
    var response = await api.bookSearchApi(query);
    
    // print("sucess: on search books: ${response}");
    String stringResponse = json.encode(response);
       isLoading.value = false;
    return stringResponse;
    // }).onError((error, stackTrace) {
    //   print("error: on fetch books: $error");
    //   return "";
    // });
  }
}
