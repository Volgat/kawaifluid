
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';

class GeminiService {
  final _model = FirebaseAI.googleAI().generativeModel(model: 'gemini-1.5-flash');

  Future<List<Color>> generateFluidColors(String themeName) async {
    try {
      final prompt =
          'Generate a palette of 3 vibrant and harmonious colors for a fluid simulation with the theme "$themeName". Return the colors as a comma-separated list of hex codes (e.g., #RRGGBB, #RRGGBB, #RRGGBB).';
      final response = await _model.generateContent([Content.text(prompt)]);
      final hexCodes = response.text!.split(',').map((e) => e.trim()).toList();
      return hexCodes.map((hex) => _hexToColor(hex)).toList();
    } catch (e) {
      debugPrint('Error generating colors: $e');
      // Return default colors on error
      return [Colors.blue, Colors.green, Colors.purple];
    }
  }

  Color _hexToColor(String hexCode) {
    return Color(int.parse(hexCode.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
