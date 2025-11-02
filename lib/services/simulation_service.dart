
import 'package:flutter/material.dart';
import 'package:kawai_app/services/gemini_service.dart';
import 'package:kawai_app/services/simulation_cache.dart';

class SimulationService {
  final GeminiService _geminiService;
  final SimulationCache _simulationCache;

  SimulationService(
      {required GeminiService geminiService, required SimulationCache simulationCache}) : _geminiService = geminiService, _simulationCache = simulationCache;

  Future<List<Color>> getColorsForTheme(String themeName) async {
    final cachedColors = _simulationCache.getColors(themeName);
    if (cachedColors != null) {
      return cachedColors;
    }

    final generatedColors = await _geminiService.generateFluidColors(themeName);
    _simulationCache.setColors(themeName, generatedColors);
    return generatedColors;
  }
}
