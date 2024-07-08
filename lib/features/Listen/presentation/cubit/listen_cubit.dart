import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'listen_state.dart';

class ListenCubit extends Cubit<ListenState> {
  ListenCubit() : super(ListenInitial());
}
