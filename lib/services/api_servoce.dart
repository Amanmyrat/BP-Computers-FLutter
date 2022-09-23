import 'package:bp_computers/models/computer.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Computer>> fetchComputers() async {
    final response = await http
        .get(Uri.parse('http://10.0.10.85:71/api/computers'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return computerModelFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}