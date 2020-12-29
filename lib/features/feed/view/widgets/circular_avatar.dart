import 'package:flutter/material.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';

class CircularAvatar extends StatelessWidget {
  final UserModel user;
  final double radius;

  const CircularAvatar({Key key, this.user, this.radius = 26})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: ClipOval(child: _photoOrInitials()),
    );
  }

  Widget _photoOrInitials() {
    String initial = 'xD';
    if (user?.name != null && user.name.length > 1) {
      initial = user.name.substring(0, 2);
    }

    Text textWidget = Text(initial,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ));

    if (user?.profilePicture != null)
      return Image.network(
        user?.profilePicture,
        loadingBuilder: (context, child, loadingProcess) {
          Semantics imageSemantics = child;
          if (loadingProcess != null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (imageSemantics.child is RawImage &&
              (imageSemantics.child as RawImage).image == null) {
            return textWidget;
          }
          return child;
        },
      );

    return textWidget;
  }
}
