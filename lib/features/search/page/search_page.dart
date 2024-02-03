import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/features/search/bloc/search_bloc.dart';

import '../../../data/config/di.dart';
import '../repo/search_repo.dart';
import '../widgets/search_app_bar.dart';
import '../widgets/search_body.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SearchBloc(repo: sl<SearchRepo>()),
        child: const Column(
          children: [
            SearchAppBar(),
            SearchBody(),
          ],
        ),
      ),
    );
  }
}
