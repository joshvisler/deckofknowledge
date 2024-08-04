import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/cards_overview/view/cards_overview_page.dart';
import 'package:myapp/home/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.amber,
        selectedIndex: selectedTab.index,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.style),
            label: 'Cards',
          ),
          NavigationDestination(
            icon: Icon(Icons.article),
            label: 'Read',
          ),
          NavigationDestination(
            icon: Icon(Icons.gamepad),
            label: 'Play',
          )
        ],
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1780936688.
        onDestinationSelected: (int index) {
          context.read<HomeCubit>().setTab(HomeTab.values[index]);
        },
      ),
      body: IndexedStack(
        index: selectedTab.index,
        children: const <Widget>[
          WordCardsOverviewPage(),
          Text('Read'),
          Text('Play'),
        ],
      ),
    );
  }
}
