import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/features/category/data/model/category_model.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:paisa/main.dart';

import 'package:responsive_builder/responsive_builder.dart';

import '../../../../core/constants/color_constant.dart';

class SelectCategoryIcon extends StatelessWidget {
  const SelectCategoryIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<CategoryModel>>(
      valueListenable: getIt.get<Box<CategoryModel>>().listenable(),
      builder: (context, value, child) {
        final List<CategoryEntity> categories =
            value.values.filterDefault.toEntities();

        if (categories.isEmpty) {
          return ListTile(
            onTap: () => context.pushNamed(addCategoryPath),
            title: Text(context.loc.addCategoryEmptyTitle),
            subtitle: Text(context.loc.addCategoryEmptySubTitle),
            trailing: const Icon(Icons.keyboard_arrow_right),
          );
        }

        return ScreenTypeLayout.builder(
          tablet: (p0) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.loc.selectCategory,
                  style: context.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SelectedItem(categories: categories)
            ],
          ),
          mobile: (p0) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.loc.selectCategory,
               style: appTheme.normalText(18,Colors.black),
                ),
              ),
              SelectedItem(categories: categories)
            ],
          ),
        );
      },
    );
  }
}

class SelectedItem extends StatelessWidget {
  const SelectedItem({
    super.key,
    required this.categories,
  });

  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    final expenseBloc = BlocProvider.of<TransactionBloc>(context);
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {

        return GridView.count(
            physics: const BouncingScrollPhysics(),
            childAspectRatio: (1 / 0.70),
            shrinkWrap: true,
            padding: EdgeInsets.all(10),
            crossAxisCount: 2,
            children: List.generate( categories.length + 1, (index) {
              if (index == 0) {
                return CategoryChip(
                  selected: false,
                  onSelected:(){context.pushNamed(addCategoryPath);},
                  icon: MdiIcons.plus.codePoint,
                  title: context.loc.addNew,
                  iconColor: context.primary,
                  titleColor: context.primary,
                );
              } else {
                final CategoryEntity category = categories[index - 1];
                final bool selected =
                    category.superId == expenseBloc.selectedCategoryId;
                return CategoryChip(
                  selected: selected,
                  onSelected: (){expenseBloc.add(ChangeCategoryEvent(category));}
                      ,
                  icon: category.icon ?? 0,
                  title: category.name ?? '',
                  titleColor: Color(category.color ?? context.primary.value),
                  iconColor: Color(category.color ?? context.primary.value),
                );
              }

            }));

      },
    );
  }
}

class CategoryChip extends StatelessWidget {
  CategoryChip({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.titleColor,
  });

  final int icon;
  final VoidCallback onSelected;
  final bool selected;
  final String title;
  final Color iconColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap:onSelected,
        child: Container(
          width: MySize.getWidth(165),
          height: MySize.getWidth(130),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: selected ? titleColor.withOpacity(0.2) : Colors.white,
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
          child: Column(
            children: [
              Spacing.height(20),
              Container(
                width: MySize.getWidth(48.14),
                height: MySize.getWidth(48),
                decoration: ShapeDecoration(
                    color: iconColor.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 3,
                      strokeAlign: BorderSide.strokeAlignOutside,
                        color: iconColor.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Icon(
                  IconData(
                   icon,
                    fontFamily: fontFamilyName,
                    fontPackage: fontFamilyPackageName,
                  ),
                  color: iconColor,
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Spacing.height(8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                             title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: MySize.getHeight(15),
                                fontFamily: 'Maven Pro',
                                fontWeight: FontWeight.w500,

                                letterSpacing: -0.41,
                              ),
                            ),
                          ],

                        ),
                      ],
                    ),
                    SizedBox(height: 10,),


                  ],),
              ),


            ],
          ),
        ),
      ),
    );


  }
}
