import 'package:bloc/bloc.dart';
import 'package:dostv_app/pages/balitang.dart';
import 'package:dostv_app/pages/bookmark.dart';
import 'package:dostv_app/pages/home/home.dart';
import 'package:dostv_app/pages/home/homelatestvideos.dart';
import 'package:dostv_app/pages/home/homelivestream.dart';
import 'package:dostv_app/pages/interviews.dart';
import 'package:dostv_app/pages/psaa.dart';
import 'package:dostv_app/pages/sinesensya.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  HomePageAClickedEvent,
  HomePageBClickedEvent,
  SinesensyaClickedEvent,
  BalitangClickedEvent,
  PSAClickedEvent,
  InterviewsClickedEvent,
  BookmarkClickedEvent,
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
      case NavigationEvents.HomePageAClickedEvent:
        yield HomepageA();
        break;
      case NavigationEvents.HomePageBClickedEvent:
        yield HomepageB();
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
      case NavigationEvents.InterviewsClickedEvent:
        yield Interview();
        break;
      case NavigationEvents.BookmarkClickedEvent:
        yield Bookmark();
        break;
    }
  }
}
