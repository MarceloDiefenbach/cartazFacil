import 'package:flutter/material.dart';

class Price extends StatelessWidget {
  final String moneySing;
  final String name;
  final String value;
  final String? valueOld;

  const Price({
    Key? key,
    required this.moneySing,
    required this.name,
    required this.value,
    this.valueOld,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
            if (valueOld != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("De:"),
                  Text(
                    valueOld!,
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (valueOld != null) Text("Por:"),
                Text(moneySing),
                Text(value),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
