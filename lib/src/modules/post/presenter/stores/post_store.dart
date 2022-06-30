import 'package:clean_arquitecture/src/modules/post/domain/usecases/get_posts_usecase.dart';
import 'package:clean_arquitecture/src/modules/post/presenter/states/post_state.dart';
import 'package:flutter/cupertino.dart';

class PostStore extends ValueNotifier<PostState> {
  final IGetPostsUsecase getPost;
  PostStore(this.getPost) : super(EmptyPostState());
  void emit(PostState newState) => value = newState;
  Future<void> fetchPosts() async {
    emit(LoadingPostState());
    final result = await getPost.call();

    final newState = result.fold((l) => ErrorPostState(l.message.toString()),
        (r) => SuccessPostState(r));
    emit(newState);
  }
}
