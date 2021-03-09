import 'package:dostv_app/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:dostv_app/sidebar/searchbar.dart';
import 'package:dostv_app/sidebar/sidebar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SearchButton(),
            Sidebar(),
          ],
        ),
      ),
    );
  }
}
