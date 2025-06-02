import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class FlutterwaveService {
  final Dio _dio = Dio();
  final Logger _logger = Logger(); 
  final String _secretKey = 'FLWSECK_TEST-ffec287b7beffd96eb11290a9caf7c3a-X';

  Future<Map<String, dynamic>?> verifyTransaction(String transactionId) async {
    try {
      _logger.i("🔍 Verifying transaction ID: $transactionId");

      final response = await _dio.get(
        'https://api.flutterwave.com/v3/transactions/$transactionId/verify',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_secretKey',
            'Content-Type': 'application/json',
          },
        ),
      );
      final data = response.data['data'];
      _logger.i("🔍 Response data : ${response.data}");
      
      if (data != null && data['status'] == 'successful') {
        final card = data['card'];

        _logger.i("✅ Transaction successful");
        _logger.i("✅ Card Token: ${card?['token']}");
        _logger.i("✅ Last4: ${card?['last_4digits']}");
        _logger.i("✅ Type: ${card?['type']}");
        _logger.i("✅ Expiry Date: ${card?['expiry']}");

        return {
          'token': card?['token'],
          'last4': card?['last_4digits'],
          'type': card?['type'],
          'expiry': card?['expiry'],
        };
      } else {
        _logger.w("⚠️ Transaction not successful or missing card info.");
      }
    } catch (e) {
      _logger.e("❌ Error verifying transaction");
    }
    return null;
  }

  Future<void> chargeTokenizedCard({
  required String token,
  required String email,
  required String amount,
}) async {
  final dio = Dio();
  final secretKey = 'FLWSECK_TEST-xxxxxxxxxxxx';

  try {
    final response = await dio.post(
      'https://api.flutterwave.com/v3/tokenized-charges',
      options: Options(headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/json',
      }),
      data: {
        "token": token,
        "amount": amount,
        "currency": "NGN",
        "email": email,
        "tx_ref": DateTime.now().millisecondsSinceEpoch.toString(),
      },
    );

    final data = response.data;
    if (data['status'] == 'success') {
      _logger.i("✅ Payment successful: ${data['data']}");
    } else {
      _logger.i("❌ Payment failed: $data");
    }
  } catch (e) {
    _logger.i("❌ Error charging tokenized card: $e");
  }
}

}
