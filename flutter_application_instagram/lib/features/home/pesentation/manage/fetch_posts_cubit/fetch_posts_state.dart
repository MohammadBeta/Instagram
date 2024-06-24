abstract class FetchPostsState{}

class FetchPostsInitial extends FetchPostsState{}

class FetchPostsLoading extends FetchPostsState{}
class FetchPostsSuccess extends FetchPostsState{}
class FetchPostsFauiler extends FetchPostsState{
  final String errorMessage;
  FetchPostsFauiler({required this.errorMessage});
}
