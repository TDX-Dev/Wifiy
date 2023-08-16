import 'package:http/http.dart' as http;

class NetworkUtils {
  static Future<bool> SendLoginRequest(String username, String password) async {
    final response = await http.post(
      Uri.parse("http://phc.prontonetworks.com/cgi-bin/authlogin?URI=http://www.msftconnecttest.com/redirect"),
      body: {
        'userId': username,
        'password': password,
        'serviceName' : 'ProntoAuthentication',
        'Submit22': 'Login'
      }
    );

    return response.body.contains('<html><head><meta http-equiv="refresh" content="0;url=http://www.msftconnecttest.com/redirect"></head></html>') || response.body.contains("You have been logged in. You may now surf the Internet.");
  }
}