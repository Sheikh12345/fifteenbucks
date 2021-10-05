import 'package:http/http.dart' as http;

class Server {
  getProducts(String endPoint) async {
    http.Response response = await http
        .get(Uri.parse('https://fyp-87.herokuapp.com/getdata/$endPoint'));

    if(response.statusCode == 200){

    }else{
       
    }

  }
}
