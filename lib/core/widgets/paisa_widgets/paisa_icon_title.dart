import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/constants/color_constant.dart';
import 'package:paisa/features/home/presentation/bloc/home/home_bloc.dart';

class PaisaIconTitle extends StatelessWidget {
  const PaisaIconTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              "assets/images/Woll.png",
              width: 48,
              height:50,
            ),
          ),
          Text(
           "Money Tracker",
            style: context.titleLarge?.copyWith(
              color: context.onBackground,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

class PaisaTitle extends StatelessWidget {
  const PaisaTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is CurrentIndexState,
      builder: (context, state) {
        String title = PageType.home.name(context);
        if (state is CurrentIndexState) {
          title = BlocProvider.of<HomeBloc>(context)
              .getPageFromIndex(state.currentPage)
              .name(context);
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Maven Pro',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ],
        );
      },
    );
  }
}

class PaisaIcon extends StatelessWidget {
  const PaisaIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.wallet,
      color: context.primary,
      size: 32,
    );
  }
}
