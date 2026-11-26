import 'package:flutter_bloc/flutter_bloc.dart';

abstract final class AppTab {
  static const home = 0;
  static const scan = 1;
  static const history = 2;
  static const profile = 3;
}

/// State = indeks tab aktif pada navigasi bawah.
class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(AppTab.home);

  void select(int index) => emit(index);
}
