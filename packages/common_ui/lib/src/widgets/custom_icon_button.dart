

import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.press,
    this.numOfItem = 0,
    this.color
  });

  final IconData icon;
  final int numOfItem;
  final GestureTapCallback press;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            // padding: const EdgeInsets.all(12),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color(0xFF979797).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)
              // shape: BoxShape.circle,
            ),
            child: color != null
                ? Icon(icon, color: color, size: 24)
                : Icon(icon, size: 24),
          ),
          if (numOfItem != 0)
            Positioned(
              top: -3,
              right: -3,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfItem",
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

}