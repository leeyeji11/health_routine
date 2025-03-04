import 'package:flutter/material.dart';
import 'package:health_routine/gen/assets.gen.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class RecWorkoutCard extends StatefulWidget {
  final String title;
  final String description;
  final String time;
  final String image;

  const RecWorkoutCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.image,
  });

  @override
  State<RecWorkoutCard> createState() => _RecWorkoutCardState();
}

class _RecWorkoutCardState extends State<RecWorkoutCard> {
  bool isMarked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMarked = !isMarked;
                          });
                        },
                        child: isMarked
                            ? Assets.icons.bookmarkSelected
                                .svg(width: 15, height: 15)
                            : Assets.icons.bookmark.svg(width: 15, height: 15),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: AppTextStyle.cardTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.description,
                    style: AppTextStyle.cardDescription,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    " ${widget.time}분",
                    style: AppTextStyle.cardDescription,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 100,
                maxHeight: 150,
              ),
              child: Image.asset(
                widget.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
