import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:provider/provider.dart';

class VariableFABSize extends StatelessWidget {
  const VariableFABSize({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<dynamic>>(
      valueListenable: Provider.of<Box<dynamic>>(context).listenable(
        keys: [
          smallSizeFabKey,
        ],
      ),
      builder: (context, value, child) {
        final isSmallSize = value.get(smallSizeFabKey, defaultValue: false);
        if (isSmallSize) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child:  FloatingActionButton(
              onPressed: onPressed,

              child: Container(
                height: 60,
                width: 60,
                decoration:  const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    begin: Alignment(0.03, -1.00),
                    end: Alignment(-0.03, 1),
                    colors: [Color(0xFF751EFF), Color(0xFFBC92FF)],
                  ),
                ),
                child:  Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child:  FloatingActionButton(
              onPressed: onPressed,
              child: Container(
                height: 60,
                width: 60,
                decoration:  const BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    begin: Alignment(0.03, -1.00),
                    end: Alignment(-0.03, 1),
                    colors: [Color(0xFF751EFF), Color(0xFFBC92FF)],
                  ),
                ),
                child:  Icon(
                  icon,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
