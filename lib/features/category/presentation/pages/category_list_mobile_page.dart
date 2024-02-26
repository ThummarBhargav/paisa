import 'package:flutter/material.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/category/presentation/widgets/category_item_mobile_widget.dart';

class CategoryListMobileWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  CategoryListMobileWidget({required this.categories,});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        physics: BouncingScrollPhysics(),
        childAspectRatio: (1 / 0.75),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: List.generate(categories.length, (index) {
          return Center(
            child: CategoryItemMobileWidget(category: categories[index])
          );
        }));

  }
}
