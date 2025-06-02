import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:project/services/flutterwave_service.dart';
import 'package:project/services/local_card_storage.dart';

class SavedCardsScreen extends StatefulWidget {
  const SavedCardsScreen({super.key});

  @override
  State<SavedCardsScreen> createState() => _SavedCardsScreenState();
}

class _SavedCardsScreenState extends State<SavedCardsScreen> {
  final LocalCardStorage _storage = LocalCardStorage();
  List<Map<String, dynamic>> _cards = [];

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    final cards = await _storage.getSavedCards();
    setState(() => _cards = cards);
  }

  Future<void> _deleteCard(int index) async {
    await _storage.deleteCard(index);
    _loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved Cards",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(8.r),
            padding: EdgeInsets.all(8.w),
            height: 35.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.w),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  try {
                    final Customer customer = Customer(
                        name: "Flutterwave Developer",
                        phoneNumber: "1234566677777",
                        email: "customer@customer.com");
                    final Flutterwave flutterwave = Flutterwave(
                        publicKey:
                            "FLWPUBK_TEST-8248fd5f2c301eed1e7ddc771d83a43d-X",
                        currency: "NGN",
                        redirectUrl: "https://google.com",
                        txRef: DateTime.now().toString(),
                        amount: "100",
                        customer: customer,
                        paymentOptions: "card",
                        customization: Customization(title: ""),
                        isTestMode: true);

                    final ChargeResponse response =
                        await flutterwave.charge(context);

                    Logger().d(
                      "Payment successful: ${response.toJson()}",
                    );
                    final tokenDetails = await FlutterwaveService()
                        .verifyTransaction(response.toJson()['transaction_id']);
                    Logger().d(tokenDetails);
                    await LocalCardStorage().saveCard(
                      token: tokenDetails!['token'],
                      last4: tokenDetails['last4'],
                      type: tokenDetails['type'],
                      expiry: tokenDetails['expiry'],
                    );
                    await _loadCards();
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: Text(' + Add Card'),
              ),
            ),
          )
        ],
      ),
      body: _cards.isEmpty
          ? const Center(child: Text("No cards saved"))
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                final card = _cards[index];
                final cardType = card['type'] ?? 'card';
                final cardImage = _getCardImage(cardType);
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  leading: Image.asset(
                    cardImage,
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    "**** **** **** ${card['last4']}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${cardType.toUpperCase()} \nExpire: ${card['expiry']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                  trailing: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.red,
                      size: 22.sp,
                    ),
                    onPressed: () => _deleteCard(index),
                  ),
                );
              },
            ),
    );
  }

  String _getCardImage(String type) {
    switch (type.toLowerCase()) {
      case 'visa':
        return 'assets/visa.png';
      case 'mastercard':
        return 'assets/mastercard.png';
      case 'verve':
        return 'assets/verve.png';
      default:
        return 'assets/visa.png';
    }
  }
}
