import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_event.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_state.dart';
import 'package:zoom_golb/features/feed/feed_posts/data/feed_post_datasource.dart';

class FeedPostBloc extends Bloc<FeedPostEvent, FeedPostState> {
  final FeedPostDatasource _datasource;
  UserModel currentUser;

  FeedPostBloc(this._datasource) {
    _init();
  }

  @override
  onData(FeedPostEvent event) {
    switch (event.runtimeType) {
      case FeedPostEventAddPost:
        _validateAndSubmit(event);
        break;
      default:
        stateController.add((lastState as FeedPostStateFetched).copyWith());
        break;
    }
  }

  _init() async {
    await _loadCurrentUser();
    _fetchInitialPosts();
  }

  _fetchInitialPosts() {
    _datasource.fetchPosts().listen((posts) {
      stateController
          .add(FeedPostStateFetched(posts: posts, user: currentUser));
    });
  }

  Future<void> _loadCurrentUser() async {
    currentUser = await _datasource.user;
    return;
  }

  void _addPost(FeedPostEventAddPost event) {
    _datasource
        .addPost(event.post.copyWith(user: currentUser))
        .listen((success) => event.success());
  }

  void _validateAndSubmit(FeedPostEventAddPost event) {
    if (event.post.message.content.isNotEmpty &&
        event.post.message.content.length < 281) {
      _addPost(event);
    } else {
      String errorMessage;
      if (event.post.message.content.isEmpty) {
        errorMessage = 'Digite uma mensagem para enviar';
      } else {
        errorMessage = 'Limite máximo de 280 caracteres';
      }
      FeedPostStateFetched fetchedState = lastState;
      stateController.add(fetchedState.copyWith(errorMessage: errorMessage));
    }
  }
}
