import 'dart:convert';

import 'package:fifteenbucks/model/all_orders_history_model.dart';
import 'package:http/http.dart' as http;

class GetHistoryApi {
  Future<AllOrdersHistoryModel> getOrdersList() async {
    http.Response response =
        await http.get(Uri.parse('https://fyp-80.herokuapp.com/order/all'));
    if (response.statusCode == 200) {
      print("Data => ${response.body}");
      return AllOrdersHistoryModel.fromJson(json.decode(response.body));
    } else {
      return AllOrdersHistoryModel.fromJson(json.decode(response.body));
    }
  }
}
