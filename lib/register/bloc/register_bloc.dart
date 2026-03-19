import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../repository/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());
      try {
        final success = await authRepository.register(
          email: event.email,
          password: event.password,
        ); 

        if (success) {
          emit(RegisterSuccess()); 
        } else {
          emit(RegisterFailure("Registration failed")); 
        }
      } catch (e) {
        emit(RegisterFailure(e.toString())); 
      }
    });
  }
}
