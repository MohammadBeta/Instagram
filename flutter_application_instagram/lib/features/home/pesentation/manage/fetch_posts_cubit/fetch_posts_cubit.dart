import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_instagram/features/home/data/model/post_model.dart';
import 'package:flutter_application_instagram/features/home/pesentation/manage/fetch_posts_cubit/fetch_posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchPostsCubit extends Cubit<FetchPostsState> {
  FetchPostsCubit() : super(FetchPostsInitial()) {
    _addPostsListener();
  }

  final List<PostModel> postsList = [];
  void _addPostsListener() {
    FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {
      postsList.clear();
        for (var element in event.docs) {
          postsList.add(PostModel.formSnap(element));
        }
        emit(FetchPostsSuccess());
    });
  }
}
