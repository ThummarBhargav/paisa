import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/constants/sizeConstant.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/transaction/domain/entities/transaction.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    super.key,
    required this.categoryGrouped,
    required this.totalExpense,
  });

  final List<MapEntry<CategoryEntity, List<TransactionEntity>>> categoryGrouped;
  final double totalExpense;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 124),
      itemCount: categoryGrouped.length,
      itemBuilder: (context, index) {
        final MapEntry<CategoryEntity, List<TransactionEntity>> map =
            categoryGrouped[index];
        return InkWell(
          onTap: () {
            context.pushNamed(
              expensesByCategoryName,
              pathParameters: {'cid': map.key.superId.toString()},
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MySize.getWidth(345),
              height: MySize.getHeight(95),
              padding: const EdgeInsets.only(
                top: 15,
                left: 15.93,
                right: 9,
                bottom: 16,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x338A959E),
                    blurRadius: 60,
                    offset: Offset(0, 30),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: MySize.getWidth(46.14),
                          height: MySize.getWidth(46),
                          decoration: ShapeDecoration(
                            color: Color(map.key.color ?? Colors.amber.shade100.value).withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 3,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(map.key.color ?? Colors.amber.shade100.value).withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Icon(
                            IconData(
                              map.key.icon ?? 0,
                              fontFamily: fontFamilyName,
                              fontPackage: fontFamilyPackageName,
                            ),
                            color: Color(map.key.color ?? Colors.amber.shade100.value),
                          ),
                        ),

                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(map.key.name ?? '', style: appTheme.normalText(16,Colors.black),
                            )),
                            Text(
                              map.value.total.toFormateCurrency(context),
                              style: appTheme.normalText(17,Color(0xFF07B103)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MySize.getWidth(60.14),
                        height: MySize.getWidth(5),),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: map.value.total / totalExpense,
                                color: Color(
                                    map.key.color ?? Colors.amber.shade100.value),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
