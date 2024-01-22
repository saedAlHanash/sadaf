import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/features/notifications/ui/widget/notifivcation_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

import '../../bloc/notifications_cubit/notifications_cubit.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    AppSharedPreference.cashReadiedNotifications(
        context.read<NotificationsCubit>().state.result.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: S.of(context).notification,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
            child: StatefulBuilder(builder: (context, mState) {
              return Switch(
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
                value: AppSharedPreference.getActiveNotification(),
                onChanged: (value) =>
                    mState(() => AppSharedPreference.cashActiveNotification(value)),
              );
            }),
          ),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          if (state.result.isEmpty) {
            return Expanded(
              child: NotFoundWidget(
                icon: Assets.iconsNoNotificationsResult,
                text: S.of(context).emptyNotifications,
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.length,
            itemBuilder: (_, i) {
              return NotificationWidget(not: state.result[i], i: i);
            },
          );
        },
      ),
    );
  }
}
