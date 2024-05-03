import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'audio_cubit_state.dart';

class AudioCubitCubit extends Cubit<AudioCubitState> {
  AudioCubitCubit() : super(AudioCubitInitial());
}
