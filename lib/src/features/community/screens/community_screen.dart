import 'package:flutter/material.dart';

import '../components/mangas_recommendations_section.dart';
import '../components/users_activity_list.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [MangasRecommendationsSection(), UsersAtivityList()],
        ),
      ),
    );
  }
}
