import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCardStorage {
  final String _key = "saved_cards";

  Future<void> saveCard({
    required String token,
    required String last4,
    required String type,
    required String expiry,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await getSavedCards();

    // Check for existing token
    final alreadySaved = existing.any((card) => card['token'] == token);
    if (alreadySaved) return; // Skip saving duplicate

    existing.add({
      "token": token,
      "last4": last4,
      "type": type,
      "expiry": expiry,
      "savedAt": DateTime.now().toIso8601String(),
    });

    await prefs.setString(_key, jsonEncode(existing));
  }


  Future<List<Map<String, dynamic>>> getSavedCards() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }

  Future<void> deleteCard(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final cards = await getSavedCards();
    cards.removeAt(index);
    await prefs.setString(_key, jsonEncode(cards));
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
