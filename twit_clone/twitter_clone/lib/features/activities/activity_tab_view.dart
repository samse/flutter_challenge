import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/common/roundbutton.dart';
import 'package:twitter_clone/features/activities/viewmodels/activity_view_model.dart';

import '../../common/avatar.dart';
import 'models/activity_model.dart';

class ActivityTabView extends ConsumerStatefulWidget {
  final String type;
  const ActivityTabView({super.key, required this.type});

  @override
  ConsumerState<ActivityTabView> createState() => _ActivityTabViewState();
}

class _ActivityTabViewState extends ConsumerState<ActivityTabView> {
  late ActivityViewModel _activityProvider;
  List<Activity> _activities = [];

  @override
  void initState() {
    _activityProvider = ref.read(activityProvider.notifier);
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return makeActivityTab(context);
  }

  void _fetchData() async {
    _activities = await _activityProvider.fetchActivities();
  }

  Widget makeActivityTab(BuildContext context) {
    if (widget.type == "All") {
      return ListView.builder(
        itemBuilder: (context, index) {
          return makeTile(context, index);
        },
        itemCount: _activities.length,
      );
    } else {
      return Center(
        child: Text(
          widget.type,
          style: context.ultraTitle,
        ),
      );
    }
  }

  Widget makeTile(BuildContext context, int index) {
    final item = _activities[index];
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(
            url: item.profileUrl,
            hasPlusIcon: false,
            iconWidget: item.profileIcon,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          item.name,
                          style: context.textTheme.headlineMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Gaps.h4,
                        Text(
                          item.hour,
                          style: context.textTheme.headlineMedium!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    if (item.following != null)
                      const SizedBox(
                          width: 90,
                          height: 30,
                          child: RoundButton(title: "Follow"))
                  ],
                ),
                Text(
                  item.comment,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.headlineMedium!
                      .copyWith(color: Colors.grey),
                ),
                if (item.subComment != null) Text(item.subComment!),
              ],
            ),
          )
        ],
      ),
      // subtitle: (item.subComment != null) ? Text(item.subComment!) : null,
    );
  }
}
