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
  List<bool> sideNevSelectedItem = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

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
          preferredSize: Size.fromHeight(MySize.getHeight(130)),
          // here the desired height
          child: CustomAppBar(
              context: context,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
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
                        PaisaUserWidget(),
                      ],
                    ),
                  ),
                  Spacing.height(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MySize.screenWidth/1.1,
                        height: MySize.getHeight(50),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
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
      drawer: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return SideNevBar(homeBloc);
      }),
      body: Stack(
        children: [
          const ContentWidget(),
          if (isBannerLoaded)
            Positioned(
             bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: getBannerAds()),
                ],
              ),
            )
          else
            const SizedBox(),
        ],
      ),
      floatingActionButton:  widget.floatingActionButton,
      bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current is CurrentIndexState,
        builder: (context, state) {
          if (state is CurrentIndexState &&
              (state.currentPage == 4 ||
                  state.currentPage == 6 ||
                  state.currentPage == 5)) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding:  EdgeInsets.only(bottom:MediaQuery.of(context).padding.bottom,left: 10,right: 10),
            child: Container(
              width: MySize.screenWidth,
              height: MySize.getHeight(80),
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
                  bottomItem(iconListSelected[0], iconList[0], 0,
                      iconListName[0], homeBloc),
                  bottomItem(iconListSelected[1], iconList[1], 1,
                      iconListName[1], homeBloc),
                  bottomItem(iconListSelected[2], iconList[2], 2,
                      iconListName[2], homeBloc),
                  bottomItem(iconListSelected[3], iconList[3], 3,
                      iconListName[3], homeBloc),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget bottomItem(
      String selUri, String unUri, int pos, String name, homeBloc) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        for (int i = 0; i < selectedItem.length; i++) {
          selectedItem[i] = false;
        }
        selectedItem[pos] = true;
        for (int i = 0; i < sideNevSelectedItem.length; i++) {
          sideNevSelectedItem[i] = false;
        }
        sideNevSelectedItem[pos] = true;
        homeBloc.add(CurrentIndexEvent(pos));
        setState(() {});
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(selectedItem[pos] ? selUri : unUri,width: 40,height: 40),
          Spacing.height(4),
          Text(
            name.toUpperCase(),
            style: appTheme.normalText(
                13, selectedItem[pos] ? Color(0xFF6E1AF5) : Color(0xFF9A9797)),
          )
        ],
      ),
    ));
  }

  Widget SideNevBar(homeBloc) {
    return Container(
      width: MySize.screenWidth / 1.45,
      height: MySize.screenHeight,
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Spacing.height(50),
          Row(
            children: [
              Image.asset("assets/images/paisa.png",height: 80,width: 80,),
              Spacing.width(7),
             Text("Money Tracker",style:  appTheme.normalText(20,Colors.black,FontWeight.w600),)
            ],
          ),
          nevItem(
              iconListSelected[0], iconList[0], iconListName[0], 0, homeBloc),
          nevItem(
              iconListSelected[1], iconList[1], iconListName[1], 1, homeBloc),
          nevItem(
              iconListSelected[2], iconList[2], iconListName[2], 2, homeBloc),
          nevItem(
              iconListSelected[3], iconList[3], iconListName[3], 3, homeBloc),
          nevItem(
              iconListSelected[4], iconList[4], iconListName[4], 4, homeBloc),
          nevItem(
              iconListSelected[5], iconList[5], iconListName[5], 5, homeBloc),
          nevItem(
              iconListSelected[6], iconList[6], iconListName[6], 6, homeBloc),
          Divider(),
          nevItem(
              iconListSelected[7], iconList[7], iconListName[7], 7, homeBloc),
        ],
      ),
    );
  }

  Widget nevItem(String selUri, String unUri, String name, int pos, homeBloc) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 10,
      ),
      child: GestureDetector(
        onTap: () {
          if(pos==7){

            Navigator.pop(context);
            Future.delayed(Duration(milliseconds: 300), () {
              context.pushNamed(settingsName);
            });


          }else{
            for (int i = 0; i < sideNevSelectedItem.length; i++) {
              sideNevSelectedItem[i] = false;
            }
            sideNevSelectedItem[pos] = true;
            if (pos <= 3) {
              for (int i = 0; i < selectedItem.length; i++) {
                selectedItem[i] = false;
              }
              selectedItem[pos] = true;
            }
            _scaffoldStateKey.currentState?.closeDrawer();
            homeBloc.add(CurrentIndexEvent(pos));
          }
          setState(() {});
        },
        child: Container(
          width: MySize.getWidth(220),
          height: MySize.getHeight(54),
          decoration: ShapeDecoration(
            gradient:sideNevSelectedItem[pos]? appTheme.g4():null,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Row(
            children: [
              Spacing.width(15),
              Image.asset(sideNevSelectedItem[pos] ? selUri : unUri,width: 40,height: 40,),
              Spacing.width(15),
              Text(iconListName[pos],style:  appTheme.normalText(16,Colors.black,FontWeight.w500),)
            ],
          ),
        ),
      ),
    );
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.04, -1.00),
          end: Alignment(-0.04, 1),
          colors: [Color(0xFF6A14F3), Color(0xFF863AFF)],
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
