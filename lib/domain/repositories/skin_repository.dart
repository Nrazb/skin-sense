import 'package:skin_sense/domain/entities/skin_analysis.dart';

abstract interface class SkinRepository {
  Future<SkinAnalysis> getLatestAnalysis();
}
