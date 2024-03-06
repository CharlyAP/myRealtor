import 'package:flutter/material.dart';
import 'package:myrealtor/model/rent.dart';

class RentWidget extends StatelessWidget {
  const RentWidget({super.key, required this.rent});

  final Rent rent;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            Hero(
              tag: rent.client.phone,
              child: Row(
                children: [Text(rent.client.lastName)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
