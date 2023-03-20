import 'package:flutter/material.dart';

import 'package:talk_stream/app/view/widgets/margins/x_margin.dart';
import 'package:talk_stream/app/view/widgets/margins/y_margin.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({
    super.key,
    this.profileImage,
    this.title,
    this.description,
    this.time,
    this.count,
    this.onTap,
  });
  final ImageProvider? profileImage;
  final String? title;
  final String? description;
  final String? time;
  final String? count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(
          20,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFF2F2F2),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: profileImage,
            ),
            const XMargin(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    style: const TextStyle(
                      color: Color(0xFF121212),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    description ?? '',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (time != null)
                  Text(
                    time ?? '2:58PM',
                    style: TextStyle(
                      color: const Color(0xFF1F1F1F).withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                const YMargin(5),
                if (count != null)
                  const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 10,
                    child: Center(
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
