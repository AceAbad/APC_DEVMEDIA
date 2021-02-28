import 'package:DOSTv/pages/Episodes.dart';
import 'package:DOSTv/pages/balitang.dart';
import 'package:DOSTv/pages/home.dart';
import 'package:DOSTv/pages/psa.dart';
import 'package:DOSTv/pages/sinesensya.dart';
import 'package:bloc/bloc.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  EpisodesClickedEvent,
  SinesensyaClickedEvent,
  BalitangClickedEvent,
  PSAClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => Homepage();

  @override
  Stream<NavigationStates> mapEventToState(event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield Homepage();
        break;
      case NavigationEvents.EpisodesClickedEvent:
        yield Episodes();
        break;
      case NavigationEvents.SinesensyaClickedEvent:
        yield Sinesensya();
        break;
      case NavigationEvents.BalitangClickedEvent:
        yield Balitang();
        break;
      case NavigationEvents.PSAClickedEvent:
        yield PSA();
        break;
    }
  }
}
