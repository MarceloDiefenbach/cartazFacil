import 'package:flutter/material.dart';

import '../DesingSystem.dart';

class NavigatorBar extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback onExport;


  const NavigatorBar({
    super.key,
    this.onBack,
    required this.onExport,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      color: AppColors.navigatorBar,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.s3),
        child: Row(
          children: [
            AppButtonIcon(
                icon: Icons.chevron_left,
                hasBackground: false,
                onPressed: () {
                  onBack?.call;
                  Navigator.pop(context);
                }
            ),

            Spacer(),

            AppButtonIcon(
                icon: Icons.ios_share_outlined,
                hasBackground: false,
                onPressed: onExport),
          ],
        ),
      ),
    );
  }
}