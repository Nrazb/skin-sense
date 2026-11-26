import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_sense/domain/entities/skin_analysis.dart';
import 'package:skin_sense/domain/repositories/skin_repository.dart';

sealed class SkinState {
  const SkinState();
}

final class SkinLoading extends SkinState {
  const SkinLoading();
}

final class SkinLoaded extends SkinState {
  const SkinLoaded(this.analysis);

  final SkinAnalysis analysis;
}

final class SkinFailure extends SkinState {
  const SkinFailure(this.message);

  final String message;
}

class SkinCubit extends Cubit<SkinState> {
  SkinCubit(this._repository) : super(const SkinLoading());

  final SkinRepository _repository;

  Future<void> load() async {
    emit(const SkinLoading());
    try {
      emit(SkinLoaded(await _repository.getLatestAnalysis()));
    } catch (_) {
      emit(const SkinFailure('Hasil analisis gagal dimuat. Coba lagi.'));
    }
  }
}
