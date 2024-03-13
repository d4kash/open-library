import 'dart:convert';

import 'package:bookstore/core/network/network_api_services.dart';
import 'package:bookstore/res/constant_page.dart';

class BookRepository {
  final api = NetworkApiServices();
 
  Future<dynamic> bookgetApi() async {
    
    dynamic response = await api.getApi(Constant.fetchBookUrl);
    return response;
  }
  Future<dynamic> bookSearchApi(String query) async {
    
    dynamic response = await api.getApi('${Constant.searcgBookUrl}?q=${json.encode(query)}');
    return response;
  }
 
}
