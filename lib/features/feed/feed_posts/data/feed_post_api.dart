import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoom_golb/core/api/base_api.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';

abstract class FeedPostApi {
  static const collectionName = 'post';
  Stream<List<PostModel>> fetchFakePosts();
  Stream<List<PostModel>> fetchPosts();
  Future<void> addPost(PostModel post);
}

class FeedPostApiImp with Api implements FeedPostApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
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
  Stream<List<PostModel>> fetchPosts() async* {
    yield* firestore
        .collection(FeedPostApi.collectionName)
        .orderBy('created_at', descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => PostModel.fromJson(doc.data()).copyWith(id: doc.id))
          .toList();
    });
  }

  @override
  Future<void> addPost(PostModel post) async {
    if (post.id == null) {
      return await firestore
          .collection(FeedPostApi.collectionName)
          .add(post.copyWith(createdAt: DateTime.now().toUtc()).toJson());
    }
    return await firestore
        .collection(FeedPostApi.collectionName)
        .doc(post.id)
        .update(post.toJson());
  }
}
