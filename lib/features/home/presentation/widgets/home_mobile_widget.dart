import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:paisa/features/home/presentation/pages/home/home_page.dart';
import 'package:paisa/features/home/presentation/widgets/content_widget.dart';
import 'package:paisa/features/profile/presentation/pages/paisa_user_widget.dart';

import '../../../../core/app_lifecycle_reactor.dart';
import '../../../../core/app_open_ad_manager.dart';
import 'home_search_button.dart';

final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();

class HomeMobileWidget extends StatefulWidget {
  const HomeMobileWidget({
    super.key,
    required this.floatingActionButton,
    required this.destinations,
  });

  final List<Destination> destinations;
  final Widget floatingActionButton;

  @override
  State<HomeMobileWidget> createState() => _HomeMobileWidgetState();
}

class _HomeMobileWidgetState extends State<HomeMobileWidget> {
  late AppLifecycleReactor _appLifecycleReactor;
  GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      AppOpenAdManager appOpenAdManager = AppOpenAdManager()
        ..loadAd();
      _appLifecycleReactor =
          AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
      _appLifecycleReactor.listenToAppStateChanges();
      await initBannerAds();
      await Future.delayed(Duration(seconds: 5));
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    MySize().init(context);
    return Scaffold(
      key: _scaffoldStateKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MySize.getHeight(120)),
          // here the desired height
          child: CustomAppBar(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Image.asset(
                            "assets/images/menu.png", height: 40,
                            width: 40,
                            color: Colors.white,)),
                      PaisaTitle(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: PaisaUserWidget(),
                      ),

                    ],
                  ),
                  Spacing.height(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      Container(
                        width: MySize.getHeight(290),
                        height: MySize.getHeight(40),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          shadows: [
                            BoxShadow(
                              color: Color(0x26000000),
                              blurRadius: 4,
                              offset: Offset(2, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'enter name & location ',
                                style: appTheme.normalText(
                                    12, Color(0xFF8A8686)),
                              ),
                            ),
                            PaisaSearchButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacing.height(18)
                ],
              ))),

      drawer: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return NavigationDrawer(
            selectedIndex: homeBloc.selectedIndex,
            onDestinationSelected: (index) {
              _scaffoldStateKey.currentState?.closeDrawer();
              homeBloc.add(CurrentIndexEvent(index));
            },
            children: [
              const PaisaIconTitle(),
              ...widget.destinations
                  .map(
                    (e) =>
                    NavigationDrawerDestination(
                      icon: e.icon,
                      selectedIcon: e.selectedIcon,
                      label: Text(e.pageType.name(context)),
                    ),
              )
                  .toList(),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  onTap: () {
                    context.pushNamed(settingsName);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.settings),
                  title: Text(
                    context.loc.settings,
                    style: context.bodyLarge,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      body: const ContentWidget(),
      floatingActionButton: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            widget.floatingActionButton,
            Container(height: 8, color: Colors.white),
            if (isBannerLoaded)
              Center(child: getBannerAds())
            else
              const SizedBox(),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current is CurrentIndexState,
        builder: (context, state) {
          if (state is CurrentIndexState &&
              (state.currentPage == 4 ||
                  state.currentPage == 6 ||
                  state.currentPage == 5)) {
            return const SizedBox.shrink();
          }
          return Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
            ),
            child: NavigationBar(
              elevation: 1,
              backgroundColor: context.surface,
              selectedIndex: homeBloc.selectedIndex,
              onDestinationSelected: (index) =>
                  homeBloc.add(CurrentIndexEvent(index)),
              destinations: widget.destinations
                  .sublist(0, 4)
                  .map((e) =>
                  NavigationDestination(
                    icon: e.icon,
                    selectedIcon: e.selectedIcon,
                    label: e.pageType.name(context),
                  ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double height;

  CustomAppBar({
    required this.child,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
      width: MySize.screenWidth,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.04, -1.00),
          end: Alignment(-0.04, 1),
          colors: [Color(0xFF6A14F3), Color(0xFF863AFF)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
      child: child,
    );
    // Container(
    // height: preferredSize.height,
    // color: Colors.orange,
    // alignment: Alignment.center,
    // child: child,
    // );
  }
}
