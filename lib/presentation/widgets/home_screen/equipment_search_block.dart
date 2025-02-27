import 'package:flutter/material.dart';
import 'package:health_routine/gen/assets.gen.dart';
import 'package:health_routine/presentation/theme/app_color.dart';

Widget equipmentSearchBlock() {
  final List<Map<String, dynamic>> equipmentList = [
    {'image': 'assets/images/equipment/trade_mill.png', 'name': '런닝머신'},
    {'image': 'assets/images/equipment/cycle.png', 'name': '싸이클'},
    {'image': 'assets/images/equipment/trade_mill.png', 'name': '덤벨'},
    {'image': 'assets/images/equipment/cycle.png', 'name': '로잉 머신'},
  ];

  return GridView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.9,
    ),
    itemCount: equipmentList.length,
    itemBuilder: (context, index) {
      return EquipmentCard(equipment: equipmentList[index]);
    },
  );
}

class EquipmentCard extends StatefulWidget {
  final Map<String, dynamic> equipment;
  const EquipmentCard({super.key, required this.equipment});

  @override
  createState() => _EquipmentCardState();
}

class _EquipmentCardState extends State<EquipmentCard> {
  bool _isMarked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.equipment['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isMarked = !_isMarked;
                  });
                },
                child: _isMarked
                    ? Assets.icons.bookmarkSelected.svg(width: 24, height: 24)
                    : Assets.icons.bookmark.svg(width: 24, height: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
