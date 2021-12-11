import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class SpaceScreenEvent {}

class ChangeSpaceScreenState extends SpaceScreenEvent {
  final int index;

  ChangeSpaceScreenState(this.index);
}

class SpaceScreenBloc extends Bloc<SpaceScreenEvent, int> {
  SpaceScreenBloc() : super(0);

  @override
  void onTransition(Transition<SpaceScreenEvent, int> transition) {
    super.onTransition(transition);
    log(transition.toString());
  }

  @override
  Stream<int> mapEventToState(SpaceScreenEvent event) async* {
    if (event is ChangeSpaceScreenState) {
      yield event.index;
    }
  }
}
