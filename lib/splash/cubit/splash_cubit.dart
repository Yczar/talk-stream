import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  Future<void> splashDelay() async {
    emit(SplashLoading());
    await Future<dynamic>.delayed(
      const Duration(seconds: 2),
    );
    emit(SplashLoaded());
  }
}
