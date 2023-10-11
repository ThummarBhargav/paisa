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
  List<bool> selectedItem = [true, false, false, false];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
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
              context: context,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            _scaffoldStateKey.currentState?.openDrawer();
                          },
                          child: Image.asset(
                            "assets/images/menu.png",
                            height: 40,
                            width: 40,
                            color: Colors.white,
                          )),
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
                                style:
                                    appTheme.normalText(12, Color(0xFF8A8686)),
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
                    (e) => NavigationDrawerDestination(
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
          return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Container(
              width: MySize.screenWidth,
              height: MySize.getHeight(70),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 10,
                    offset: Offset(-1, 3),
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Row(
                children: [
                  bottomItem(
                      "assets/images/HomeS.png", "assets/images/HomeU.png",0,"Home",homeBloc),
                  bottomItem(
                      "assets/images/AcS.png", "assets/images/AcU.png",1,"Account",homeBloc),
                  bottomItem(
                      "assets/images/DebS.png", "assets/images/DebU.png",2,"Debts",homeBloc),
                  bottomItem(
                      "assets/images/OvrS.png", "assets/images/OvrU.png",3,"OverView",homeBloc),
                ],
              ),
            ),
          );
        },
      ),

    );
  }

  Widget bottomItem(String selUri, String unUri,int pos,String name,homeBloc) {
    return Expanded(
        child: GestureDetector(
          onTap: (){
            for(int i=0;i<selectedItem.length;i++){
              selectedItem[i]=false;
            }
            selectedItem[pos]=true;
            homeBloc.add(CurrentIndexEvent(pos));
            setState(() {

            });

          },
          child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Image.asset(selectedItem[pos] ? selUri : unUri),
          Spacing.height(4),
          Text(
           name.toUpperCase(),
            style: appTheme.normalText(
                14, selectedItem[pos] ? Color(0xFF6E1AF5) : Color(0xFF9A9797)),
          )
      ],
    ),
        ));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double height;
  final BuildContext context;

  CustomAppBar(
      {required this.child,
      this.height = kToolbarHeight,
      required this.context});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(context) {
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
