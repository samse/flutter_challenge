import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/avatar.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/features/search/viewmodels/search_view_model.dart';

import '../../common/roundbutton.dart';
import 'models/user.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static const routeURL = "/search";
  static const routeName = "search";
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<User> _searchResults = [];
  late SearchViewModel _searchProvider;
  @override
  void initState() {
    super.initState();
    _searchProvider = ref.read(searchProvider.notifier);
    doQuery('');
  }

  void doQuery(String value) async {
    _searchResults = await _searchProvider.queryUsers(value);
  }

  void _onSubmitted(String value) async {
    print("value: $value");
    _searchResults = await _searchProvider.queryUsers(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CupertinoSearchTextField(
          onSubmitted: _onSubmitted,
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemBuilder: (context, index) {
              final user = _searchResults[index];
              return ListTile(
                title: Row(
                  children: [
                    Avatar(
                      url: user.profileUrl,
                      hasPlusIcon: false,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              user.name,
                              style: context.searchTitleText,
                            ),
                            Gaps.h4,
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 18,
                            )
                            // FaIcon(FontAwesomeIcons
                            //     .checkToSlot) //Image.asset("assets/images/free-icon-verified.png")
                          ],
                        ),
                        if (user.subTitle != null)
                          Text(
                            user.subTitle!,
                            style: context.searchSubTitleText,
                          ),
                      ],
                    ),
                    Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                          SizedBox(
                              width: 90,
                              height: 30,
                              child: RoundButton(title: "Follow"))
                        ]))
                  ],
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Gaps.h52,
                        if (user.repFollowerProfileUrl != null)
                          Avatar(
                              url: user.repFollowerProfileUrl!,
                              // url: user.profileUrl,
                              hasPlusIcon: false,
                              size: 20),
                        if (user.followCount != null)
                          Text(
                            "${user.followCount!} followers",
                            style: context.searchFollowersText,
                          )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60.0),
                      child: context.divider(context),
                    ),
                  ],
                ),
                // trailing: SizedBox(
                //     width: 90, height: 30, child: RoundButton(title: "Follow")),
              );
            },
            itemCount: _searchResults.length),
      ),
    );
  }
}
