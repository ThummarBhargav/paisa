import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TogSwitch extends StatefulWidget {
  const TogSwitch({
    Key? key,
    required this.switchButton,
  }) : super(key: key);
  final Widget switchButton;
  @override
  State<TogSwitch> createState() => _TogSwitchState();
}

class _TogSwitchState extends State<TogSwitch> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Color?> trackColor =
    MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.amber;
        }

        return null;
      },
    );


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget.switchButton,
    );
  }
}
