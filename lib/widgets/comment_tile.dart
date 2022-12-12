import 'package:flutter/material.dart';
import 'package:shrine/data/user_details.dart';
import 'package:shrine/supplemental/constants.dart';

class CommentTile extends StatelessWidget {
  final String comment;
  final String user;
  const CommentTile({Key? key, required this.comment, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          kDefaultPadding / 2, kDefaultPadding / 4, kDefaultPadding / 2, 0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue,
            child: Text(
              '${firstName[0]}${lastName[0]}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user, style: const TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 5 * 3,
                  child: Text(comment)),
            ],
          )
        ],
      ),
    );
  }
}
