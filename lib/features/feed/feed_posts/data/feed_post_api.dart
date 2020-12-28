import 'package:zoom_golb/core/api/base_api.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';

abstract class FeedPostApi {
  Stream<List<PostModel>> fetchFakePosts();
  Stream<List<PostModel>> fetchPosts();
}

class FeedPostApiImp with Api implements FeedPostApi {
  @override
  Stream<List<PostModel>> fetchFakePosts() async* {
    Response response = await dummyApi.get('post');
    print(response);
    if (response != null &&
        response.statusCode == 200 &&
        response.data != null) {
      Map<String, Object> responseData = Map.from(response.data);
      List<dynamic> rawPostsList = responseData['data'];
      yield rawPostsList.map((rawPost) {
        Map<String, Object> rawUser = rawPost['owner'];
        return PostModel(
            message: Message(
              content: (rawPost['text'])
                  .toString()
                  .padRight(280, ' ')
                  .substring(0, 280),
              createdAt: DateTime.tryParse(rawPost['publishDate']),
            ),
            user: UserModel(
                id: rawUser['id'],
                email: rawUser['email'],
                name: rawUser['firstName'],
                profilePicture: rawUser['picture']));
      }).toList();
      return;
    }
    yield [];
  }

  @override
  Stream<List<PostModel>> fetchPosts() {
    // TODO: implement fetchPosts
    throw UnimplementedError();
  }
}
