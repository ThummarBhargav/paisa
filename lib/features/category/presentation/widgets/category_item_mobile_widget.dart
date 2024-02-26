import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/features/category/domain/entities/category.dart';

class CategoryItemMobileWidget extends StatelessWidget {
  const CategoryItemMobileWidget({
    Key? key,
    required this.category,
    this.onclick
  }) : super(key: key);

  final CategoryEntity category;
  final VoidCallback? onclick;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return InkWell(
        onTap: onclick?? () {
          context.pushNamed(
            editCategoryName,
            pathParameters: <String, String>{'cid': category.superId.toString()},
          );
        },
      child: Container(
        width: MySize.getWidth(165),
        height: MySize.getWidth(120),
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
        child: Column(
          children: [
            Spacing.height(20),
            Container(
              width: MySize.getWidth(48.14),
              height: MySize.getWidth(48),
              decoration: ShapeDecoration(
                color: Color(category.color ?? context.surface.value).withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 3,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(category.color ?? context.surface.value).withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Icon(
                IconData(
                  category.icon ?? 0,
                  fontFamily: fontFamilyName,
                  fontPackage: fontFamilyPackageName,
                ),
                color: Color(category.color ?? context.surface.value),
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            category.name ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Maven Pro',
                              fontWeight: FontWeight.w500,

                              letterSpacing: -0.41,
                            ),
                          ),
                          Container(
                            child: category.description == null || category.description == ''
                                ? null
                                : Text(
                              category.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.bodyLarge?.copyWith(
                                color: Colors.black
                                    .withOpacity(0.75),
                              ),
                            ),
                          )
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
    );
  }
}
