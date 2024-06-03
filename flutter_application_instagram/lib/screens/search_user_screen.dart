import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/models/user_search_result_model.dart';
import 'package:flutter_application_instagram/resources/firebase/firestore_methods.dart';
import 'package:flutter_application_instagram/widgets/user_search_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  Future<List<UserSearchResultModel>> searchUser(String userName) async {
    List<UserSearchResultModel> data =
        await FireStoreMethods().searchUser(userName);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextField(
            controller: _searchController,
            decoration: const InputDecoration(label: Text("Search user")),
            onSubmitted: (value) {
              setState(() {});
            },
          ),
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: searchUser(_searchController.text),
            builder:
                (context, AsyncSnapshot<List<UserSearchResultModel>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: UserSearchResult(
                          userName: snapshot.data![index].userName,
                          userUid: snapshot.data![index].userUid,
                          profileIamgeUrl:
                              snapshot.data![index].profileImageUrl),
                    );
                  },
                );
              }

              return const Center(
                child: Text('No Posts Found'),
              );
            },
          ),
        ));
  }
}
