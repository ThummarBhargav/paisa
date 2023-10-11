import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/core/extensions/build_context_extension.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';

import '../../../home/presentation/widgets/home_mobile_widget.dart';

class CategoryIconPickerPage extends StatefulWidget {
  const CategoryIconPickerPage({super.key});

  @override
  State<CategoryIconPickerPage> createState() => _CategoryIconPickerPageState();
}

class _CategoryIconPickerPageState extends State<CategoryIconPickerPage> {
  late IconData? selectedIcon = MdiIcons.abTesting;

  @override
  Widget build(BuildContext context) {
    final map = paisaIconMap.entries.toList();
    MySize().init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MySize.getHeight(130)),
        child: CustomAppBar(
          context: context,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        GoRouter.of(context).pop(selectedIcon);
                      },
                      icon: const Icon(Icons.close,color: Colors.white,)),
                Text(context.loc.chooseIcon,style: appTheme.normalText(22)),
                InkWell(
                    onTap: (){
                      paisaIconPicker(
                        context: context,
                        defaultIcon: selectedIcon!,
                      ).then((resultIcon) => selectedIcon = resultIcon);

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(context.loc.more,style: appTheme.normalText(15)),
                    )),

                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PaisaBigButton(
            onPressed: () {
              GoRouter.of(context).pop(selectedIcon);
            },
            title: context.loc.done,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: map.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final iconData = map[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: PaisaFilledCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -3),
                    title: Text(
                      iconData.key,
                      style: appTheme.normalText(18),
                    ),
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: iconData.value.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 40,
                      childAspectRatio: 1 / 1,
                    ),
                    itemBuilder: (context, index) {
                      final bool isSelected =
                          selectedIcon == iconData.value[index];
                      return Container(
                        decoration: isSelected
                            ? BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white)
                            : null,
                        child: IconButton(
                          padding: EdgeInsets.only(bottom: isSelected ? 0 : 3),
                          iconSize: 25,
                          key: ValueKey(iconData.value[index].hashCode),
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          onPressed: () {
                            setState(() {
                              selectedIcon = iconData.value[index];
                            });
                          },
                          icon: Icon(iconData.value[index], shadows: [
                            Shadow(color: Colors.black, offset: Offset(0, 1))
                          ]),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final paisaIconMap = {
  "Animal": [
    MdiIcons.butterfly,
    MdiIcons.cat,
    MdiIcons.cow,
    MdiIcons.dog,
    MdiIcons.dogSide,
    MdiIcons.duck,
    MdiIcons.fish,
    MdiIcons.horse,
    MdiIcons.owl,
    MdiIcons.panda,
    MdiIcons.pig,
    MdiIcons.sheep,
    MdiIcons.rabbit,
    MdiIcons.snail,
    MdiIcons.snake,
    MdiIcons.spider,
    MdiIcons.tortoise,
    MdiIcons.turtle,
    MdiIcons.turkey,
  ],
  "Brands": [
    MdiIcons.android,
    MdiIcons.angular,
    MdiIcons.apple,
    MdiIcons.atlassian,
    MdiIcons.aws,
    MdiIcons.bitbucket,
    MdiIcons.bitcoin,
    MdiIcons.blenderSoftware,
    MdiIcons.bootstrap,
    MdiIcons.codepen,
    MdiIcons.devTo,
    MdiIcons.deviantart,
    MdiIcons.docker,
    MdiIcons.dropbox,
    MdiIcons.evernote,
    MdiIcons.facebook,
    MdiIcons.firebase,
    MdiIcons.firefox,
    MdiIcons.github,
    MdiIcons.gitlab,
    MdiIcons.gmail,
    MdiIcons.google,
    MdiIcons.googleAds,
    MdiIcons.googleDrive,
    MdiIcons.googlePlay,
    MdiIcons.hulu,
    MdiIcons.instagram,
    MdiIcons.jira,
    MdiIcons.kickstarter,
    MdiIcons.languageSwift,
    MdiIcons.linkedin,
    MdiIcons.microsoft,
    MdiIcons.microsoftAzure,
    MdiIcons.nintendoSwitch,
    MdiIcons.onepassword,
    MdiIcons.pandora,
    MdiIcons.patreon,
    MdiIcons.pinterest,
    MdiIcons.qqchat,
    MdiIcons.reddit,
    MdiIcons.skype,
    MdiIcons.snapchat,
    MdiIcons.soundcloud,
    MdiIcons.spotify,
    MdiIcons.steam,
    MdiIcons.wechat,
    MdiIcons.whatsapp,
    MdiIcons.wikipedia,
    MdiIcons.wordpress,
    MdiIcons.youtube,
  ],
  "Computer": [
    MdiIcons.album,
    MdiIcons.audioVideo,
    MdiIcons.earbuds,
    MdiIcons.headphones,
    MdiIcons.musicNote,
    MdiIcons.speaker,
    MdiIcons.printer,
    MdiIcons.radio,
    MdiIcons.wifi,
    MdiIcons.bluetooth,
    MdiIcons.phone,
    MdiIcons.laptop,
    MdiIcons.desktopClassic,
    MdiIcons.televisionSpeaker,
    MdiIcons.videoVintage,
    MdiIcons.film,
    MdiIcons.camcorder,
    MdiIcons.video,
    MdiIcons.webcam,
    MdiIcons.camera,
  ],
  "Food": [
    MdiIcons.carrot,
    MdiIcons.chiliMild,
    MdiIcons.corn,
    MdiIcons.egg,
    MdiIcons.foodApple,
    MdiIcons.fruitGrapes,
    MdiIcons.fruitCherries,
  ],
  "Health": [
    MdiIcons.pillMultiple,
    MdiIcons.needle,
    MdiIcons.motherNurse,
    MdiIcons.truckPlus,
    MdiIcons.medication,
    MdiIcons.hospitalBuilding,
    MdiIcons.emoticonSick,
  ],
  "Shopping": [
    MdiIcons.basket,
    MdiIcons.cart,
    MdiIcons.cash,
    MdiIcons.creditCard,
    MdiIcons.sale,
    MdiIcons.shopping,
    MdiIcons.store,
    MdiIcons.cashRegister,
    MdiIcons.cartVariant,
  ],
  "Transportation": [
    MdiIcons.airplane,
    MdiIcons.car,
    MdiIcons.ferry,
    MdiIcons.taxi,
    MdiIcons.tram,
    MdiIcons.train,
    MdiIcons.bus,
  ],
  "Other": [
    MdiIcons.circle,
    MdiIcons.circleHalf,
    MdiIcons.heart,
    MdiIcons.hexagon,
    MdiIcons.decagram,
    MdiIcons.shape,
    MdiIcons.hexagonMultiple,
    MdiIcons.triangle,
    MdiIcons.shapePlus,
  ],
};
