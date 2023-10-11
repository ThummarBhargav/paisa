import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/constants.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/core/enum/box_types.dart';
import 'package:paisa/core/extensions/build_context_extension.dart';
import 'package:paisa/core/extensions/category_extension.dart';
import 'package:paisa/core/extensions/color_extension.dart';
import 'package:paisa/core/extensions/text_style_extension.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/category/data/data_sources/default_category.dart';
import 'package:paisa/features/category/data/data_sources/local/category_data_source.dart';
import 'package:paisa/features/category/data/model/category_model.dart';
import 'package:paisa/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../transaction/presentation/widgets/select_category_widget.dart';

class CategorySelectorPage extends StatefulWidget {
  const CategorySelectorPage({super.key});

  @override
  State<CategorySelectorPage> createState() => _CategorySelectorPageState();
}

class _CategorySelectorPageState extends State<CategorySelectorPage> {
  final LocalCategoryManager dataSource = getIt.get();
  final List<CategoryModel> defaultModels = defaultCategoriesData;
  final settings = getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name);

  @override
  void initState() {
    super.initState();
    getIt.get<Box<CategoryModel>>().values.filterDefault.forEach((element) {
      defaultModels.remove(element);
    });
  }

  Future<void> saveAndNavigate() async {
    await settings.put(userCategorySelectorKey, false);
    if (mounted) {
      context.go(accountSelectorPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return ValueListenableBuilder<Box<CategoryModel>>(
      valueListenable: getIt.get<Box<CategoryModel>>().listenable(),
      builder: (context, value, child) {
        final List<CategoryModel> categoryModels =
            value.values.filterDefault.toList();
        return PaisaAnnotatedRegionWidget(
          color: context.background,
          child: Scaffold(
            appBar: context.materialYouAppBar(
              context.loc.categories,
              actions: [
                InkWell(
                    onTap: saveAndNavigate,
                    child: Container(
                      height: MySize.getHeight(30),
                      width: MySize.getWidth(70),
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF9F63FF), Color(0xFF8F4DFA)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 8,
                            offset: Offset(2, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Center(
                          child: Text(
                        "Done",
                        style: appTheme.normalText(17),
                      )),
                    )),
                const SizedBox(width: 16)
              ],
            ),
            body: ListView(
              children: [
                ListTile(
                  title: Text(
                    context.loc.addedCategories,
                    style: appTheme.normalText(17,Colors.black),
                  ),
                ),
                ScreenTypeLayout.builder(
                  mobile: (p0) => ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryModels.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final CategoryModel model = categoryModels[index];
                      return CategoryItemWidget(
                        model: model,
                        onPress: () async {
                          await model.delete();
                          defaultModels.add(model);
                        },
                      );
                    },
                  ),
                  tablet: (p0) => GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 2,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryModels.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final CategoryModel model = categoryModels[index];
                      return CategoryItemWidget(
                        model: model,
                        onPress: () async {
                          await model.delete();
                          defaultModels.add(model);
                        },
                      );
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    context.loc.defaultCategories,
                    style: appTheme.normalText(17,Colors.black),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        childAspectRatio: (1 / 0.70),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10),
                        crossAxisCount: 2,
                        children: List.generate(defaultModels.length, (index) {
                          return CategoryChip(
                            selected: false,
                            onSelected: () {
                              dataSource.add(defaultModels[index]);
                              setState(() {
                                defaultModels.remove(defaultModels[index]);
                              });
                            },
                            icon: defaultModels[index].icon ?? 0,
                            title: defaultModels[index].name ?? "",
                            iconColor: Color(defaultModels[index].color ??
                                context.primary.value),
                            titleColor: context.primary,
                          );
                        }))),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.model,
    required this.onPress,
  });

  final CategoryModel model;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MySize.getWidth(345),
        height: MySize.getHeight(60),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 25,
              offset: Offset(0, 0),
              spreadRadius: 1,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    width: MySize.getWidth(35.14),
                    height: MySize.getWidth(35),
                    decoration: ShapeDecoration(
                      color: Color(model.color ?? Colors.brown.shade200.value)
                          .withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 3,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color:
                              Color(model.color ?? Colors.brown.shade200.value)
                                  .withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Icon(
                      IconData(
                        model.icon ?? 0,
                        fontFamily: fontFamilyName,
                        fontPackage: fontFamilyPackageName,
                      ),
                      color: Color(model.color ?? Colors.brown.shade200.value),
                    ),
                  ),
                ),
                Spacing.width(15),
                Text(
                  model.name ?? '',
                  style: appTheme.normalText(15, Colors.black),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(onTap: onPress, child: Icon(Icons.delete)),
            ),
          ],
        ),
      ),
    );
  }
}
