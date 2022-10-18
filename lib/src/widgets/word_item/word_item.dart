import 'package:capital/src/models/world/world.dart';
import 'package:flutter/material.dart';

class WordItemWidget extends StatelessWidget {
  final World world;
  const WordItemWidget({Key? key, required this.world}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      child:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          children: [
            Expanded(child: Text(world.country ?? '....',style: const TextStyle(fontSize: 24),)),
            const Icon(
              Icons.chevron_right_outlined,
              size: 32,
              color: Colors.black38,
            )
          ],
        ),
      ),
    );
  }
}
