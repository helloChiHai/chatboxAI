import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_event.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeMode: ThemeMode.system)) {
    on<ToggleThemeEvent>((event, emit) {
      final newTheme =
          state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      emit(ThemeState(themeMode: newTheme));
    });
  }
}
