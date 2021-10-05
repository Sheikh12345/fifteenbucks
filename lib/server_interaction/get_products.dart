import 'dart:convert';

import 'package:fifteenbucks/model/product_model.dart';
import 'package:http/http.dart' as http;

class Server {
  Future<ProductModel> getProducts(String endPoint) async {
    print("kashif");
    http.Response response = await http.get(
        Uri.parse('https://fyp-87.herokuapp.com/getdata/$endPoint'),
        headers: {'Accept': 'Application/json'});

    if (response.statusCode == 200) {
      print(response.statusCode);
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      return ProductModel(success: json.decode(response.body)['success']);
    }
  }
}
