import 'package:flutter/material.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';

class IntroSetNameWidget extends StatelessWidget {
  const IntroSetNameWidget({
    Key? key,
    required this.formState,
    required this.nameController,
  }) : super(key: key);

  final GlobalKey<FormState> formState;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset("assets/images/paisa.png",height: 100,width: 100),

              ],
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    style: appTheme.shadowText(24,FontWeight.w500,Colors.black),
                    text: context.loc.welcome,
                  ),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Money Tracker',
                  style: appTheme.shadowText(24,FontWeight.w600,context.primary),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.loc.welcomeDesc,
                  style: appTheme.normalText(15,Color(0xFF666666),),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Form(
              key: formState,
              child: PaisaTextFormField(
                key: const Key('user_name_textfield'),
                controller: nameController,
                hintText: context.loc.enterNameHint,
                label: context.loc.nameHint,
                keyboardType: TextInputType.name,

                validator: (val) {
                  if (val!.isNotEmpty) {
                    return null;
                  } else {
                    return context.loc.enterNameHint;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
