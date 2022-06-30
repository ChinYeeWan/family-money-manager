import 'package:flutter/material.dart';

import '../../constants/color.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/default-profile-picture.png"),
          ),
          Positioned(
            right: -12,
            bottom: 0,
            child: SizedBox(
              height: 40,
              width: 40,
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: white),
                  ),
                  primary: grey,
                  onPrimary: Colors.grey[100],
                ),
                child: Icon(
                  //Icons.camera_alt_rounded,
                  Icons.edit,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
