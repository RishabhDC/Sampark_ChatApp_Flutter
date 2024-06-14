import 'package:flutter/material.dart';

myTabBar(TabController tabController, BuildContext context){
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: TabBar(
      controller: tabController,
      labelStyle: Theme.of(context).textTheme.bodyLarge,
      unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
      tabs: [
        Tab(
          text: "Chats",
        ),
        Tab(
          text: "Group",
        ),
        Tab(
          text: "Calls",
        )
      ],
    ),
  );
}