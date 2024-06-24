import 'package:flutter/material.dart';
import 'package:flutter_application_instagram/core/constants/app_colors.dart';
import 'package:flutter_application_instagram/core/constants/app_images.dart';
import 'package:flutter_application_instagram/features/home/data/model/post_model.dart';
import 'package:flutter_application_instagram/features/home/pesentation/manage/fetch_posts_cubit/fetch_posts_cubit.dart';
import 'package:flutter_application_instagram/features/home/pesentation/manage/fetch_posts_cubit/fetch_posts_state.dart';
import 'package:flutter_application_instagram/features/home/pesentation/widgets/post_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: SvgPicture.asset(
            instagramLogo,
            color: primaryColor,
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.message_outlined))
          ],
        ),
        body: BlocProvider(
          create: (context) => FetchPostsCubit(),
          child: BlocConsumer<FetchPostsCubit, FetchPostsState>(
            listener: (context, state) {
              if (state is FetchPostsFauiler) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ));
              }
            },
            builder: (context, state) {
              List<PostModel> postsList =
                  BlocProvider.of<FetchPostsCubit>(context).postsList;
              return ListView.builder(
                itemCount: postsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: PostCard(
                      postModel: postsList[index],
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
