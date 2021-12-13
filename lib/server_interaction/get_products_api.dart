import 'dart:convert';

import 'package:fifteenbucks/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class Server {
  Future<ProductModel> getProducts(String endPoint) async {
    http.Response response = await http.get(
        Uri.parse('https://fyp-87.herokuapp.com/getdata/$endPoint'),
        headers: {'Accept': 'Application/json'});

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      return ProductModel(success: json.decode(response.body)['success']);
    }
  }

  Future<bool> sendOrder(Map map) async {
    print("Sending data => ${map}");
    var dio = Dio();

    try {
      final response = await dio.post(
        'https://fyp-87.herokuapp.com/order/create',
        data: map,
      );
      print("Order is placed => ${response.data}");
      if (response.statusCode == 200) {
        print(response.data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Order is ${e.toString()}");
      return false;
    }
  }
}
