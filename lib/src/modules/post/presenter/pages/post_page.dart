import 'package:clean_arquitecture/src/modules/post/presenter/states/post_state.dart';
import 'package:clean_arquitecture/src/modules/post/presenter/stores/post_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    context.read<PostStore>().fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<PostStore>();
    final state = store.value;
    Widget child = Container();
    if (state is LoadingPostState) {
      child = const CircularProgressIndicator();
    }
    if (state is ErrorPostState) {
      child = Text(state.message);
    }
    if (state is SuccessPostState) {
      child = ListView.builder(
        itemBuilder: ((context, index) {
          final post = state.posts[index];
          return PostCard(post: post);
        }),
        itemCount: state.posts.length,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
      ),
      body: child,
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: Image.network(post.user.photo),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                post.user.name,
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          Text(post.text),
          TextButton(
              onPressed: () {},
              child: Text("COMENTARIOS ${post.totalComments.toString()}"))
        ]),
      ),
    );
  }
}
