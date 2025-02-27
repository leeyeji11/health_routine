import 'package:flutter/material.dart';
import 'package:health_routine/gen/assets.gen.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class RecommendedWorkoutCard extends StatefulWidget {
  final String title;
  final String description;
  final String image;

  const RecommendedWorkoutCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  State<RecommendedWorkoutCard> createState() => _RecommendedWorkoutCardState();
}

class _RecommendedWorkoutCardState extends State<RecommendedWorkoutCard> {
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
                          style: AppTextStyle.subSectionTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.description,
                    style: AppTextStyle.workoutDescription,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            widget.image,
            width: MediaQuery.of(context).size.width * 0.3,
            height: 90,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
