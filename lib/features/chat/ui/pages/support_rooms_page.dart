import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/strings/app_color_manager.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/core/widgets/my_card_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/support_rooms_cubit/support_rooms_cubit.dart';

class SupportRoomsPage extends StatelessWidget {
  const SupportRoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).support),
      body: BlocBuilder<SupportMessagesCubit, SupportMessagesInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return ListView.builder(
            itemCount: state.result.length,
            itemBuilder: (context, i) {
              final item = state.result[i];
              return InkWell(
                onTap: !item.open
                    ? null
                    : () {
                        Navigator.pushNamed(context, RouteName.supportRoom,
                            arguments: item);
                      },
                child: MyCardWidget(
                  cardColor:
                      !item.open ? AppColorManager.lightGray : AppColorManager.cardColor,
                  padding: const EdgeInsets.symmetric(vertical: 20.0).h,
                  elevation: 0,
                  child: ListTile(
                    horizontalTitleGap: 0,
                    title: DrawableText(text: '${S.of(context).support} ${item.id}'),
                    leading: const CircleImageWidget(url: Icons.support_agent),
                    subtitle: DrawableText(
                      text: item.lastMessage,
                      maxLines: 1,
                      size: 12.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
