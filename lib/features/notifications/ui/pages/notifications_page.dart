import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadaf/core/extensions/extensions.dart';
import 'package:sadaf/core/widgets/app_bar/app_bar_widget.dart';
import 'package:sadaf/features/notifications/ui/widget/notifivcation_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../bloc/notification_count_cubit/notification_count_cubit.dart';
import '../../bloc/notifications_cubit/notifications_cubit.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    AppSharedPreference.clearNotificationCount();
    context.read<NotificationCountCubit>().changeCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titleText: 'الإشعارات'),
      body: BlocBuilder<NotificationsCubit, NotificationsInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          if (state.result.isEmpty) {
            return const Expanded(
              child: NotFoundWidget(
                icon: Assets.iconsNoNotifications,
                text: 'لا يوجد إشعارات',
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.length,
            itemBuilder: (_, i) {
              return NotificationWidget(not: state.result[i]);
            },
          );
        },
      ),
    );
  }
}
