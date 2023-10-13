import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:paisa/main.dart';

import '../../../../core/constants/color_constant.dart';

class IntroImagePickerWidget extends StatelessWidget {
  const IntroImagePickerWidget({
    Key? key,
  }) : super(key: key);

  void _pickImage(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((pickedFile) {
      if (pickedFile != null) {
        context.read<Box<dynamic>>().put(userImageKey, pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ProfileCubit>(),
      child: SafeArea(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    "assets/images/iconAdd.png",
                    height: 100,
                    width: 100,
                  ),
                  Column(
                    children: [],
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        context.loc.image,
                        style: appTheme.shadowText(
                            24, FontWeight.w500, Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        context.loc.imageDesc,
                        style: appTheme.normalText(
                          15,
                          Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: PaisaUserImageWidget(
                  pickImage: () => _pickImage(context),
                  maxRadius: 72,
                  useDefault: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
