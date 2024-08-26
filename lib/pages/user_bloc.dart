import 'package:bloc/bloc.dart';

class UserBloc extends Bloc<bool, bool> {
  // Explicitly call the constructor of the superclass
  UserBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}

final userBloc = UserBloc();