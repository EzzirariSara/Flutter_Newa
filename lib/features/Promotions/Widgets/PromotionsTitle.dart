import 'package:flutter/material.dart';

class Promotionstitle extends StatelessWidget {
  const Promotionstitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Text(
            "Offres limitées",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF243B6A),
            ),
          ),
          // const Spacer(),
          // TextButton(
          //   onPressed: () {
          //   },
          //   child: Text(
          //     "Voir tout",
          //     style: TextStyle(
          //       color: Colors.blue[700],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}