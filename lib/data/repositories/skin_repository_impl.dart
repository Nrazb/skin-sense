import 'package:skin_sense/data/datasources/skin_local_data_source.dart';
import 'package:skin_sense/domain/entities/skin_analysis.dart';
import 'package:skin_sense/domain/repositories/skin_repository.dart';

class SkinRepositoryImpl implements SkinRepository {
  const SkinRepositoryImpl(this._dataSource);

  final SkinLocalDataSource _dataSource;

  @override
  Future<SkinAnalysis> getLatestAnalysis() => _dataSource.getLatestAnalysis();
}
