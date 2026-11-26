enum SkinType {
  oily('Kulit Berminyak', 'Berminyak'),
  normal('Kulit Normal', 'Normal'),
  dry('Kulit Kering', 'Kering');

  const SkinType(this.displayName, this.className);

  final String displayName;
  final String className;
}

class SkinNeedProfile {
  const SkinNeedProfile({required this.oilControl, required this.hydration, required this.smoothness});

  /// Semua nilai dalam persen, 0 sampai 100.
  final int oilControl;
  final int hydration;
  final int smoothness;
}

class RoutineStep {
  const RoutineStep({required this.title, required this.description, this.frequency});

  final String title;
  final String description;
  final String? frequency;
}

class SkinAnalysis {
  const SkinAnalysis({
    required this.scanWidthPx,
    required this.dominantType,
    required this.probabilities,
    required this.needs,
    required this.priorityNote,
    required this.meaning,
    required this.specialNote,
    required this.morningRoutine,
    required this.nightRoutine,
    required this.recommendedIngredients,
    required this.avoidedIngredients,
  });

  final int scanWidthPx;
  final SkinType dominantType;

  /// Peluang tiap kelas sebagai pecahan 0..1.
  final Map<SkinType, double> probabilities;
  final SkinNeedProfile needs;
  final String priorityNote;
  final String meaning;
  final String specialNote;
  final List<RoutineStep> morningRoutine;
  final List<RoutineStep> nightRoutine;
  final List<String> recommendedIngredients;
  final List<String> avoidedIngredients;

  double get confidence => probabilities[dominantType] ?? 0;

  List<MapEntry<SkinType, double>> get ranked =>
      probabilities.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
}
