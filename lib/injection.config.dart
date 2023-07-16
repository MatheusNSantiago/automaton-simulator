// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/canvas_cubit/canvas_cubit.dart' as _i5;
import 'domain/canvas/i_canvas_repository.dart' as _i3;
import 'infrastructure/canvas/canvas_repository.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.ICanvasRepository>(() => _i4.CanvasRepository());
    gh.factory<_i5.CanvasCubit>(
        () => _i5.CanvasCubit(gh<_i3.ICanvasRepository>()));
    return this;
  }
}
