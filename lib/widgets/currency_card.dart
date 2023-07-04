import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  final bool isInverted;

  const CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: isInverted ? Colors.white : const Color(0xFF1F2123),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 32,
                  color: isInverted ? const Color(0xFF1F2123) : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 20,
                      color:
                          isInverted ? const Color(0xFF1F2123) : Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    code,
                    style: TextStyle(
                      color: isInverted
                          ? const Color(0xFF1F2123).withOpacity(0.8)
                          : Colors.white.withOpacity(0.8),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Transform.translate(
            offset: const Offset(-10, 20),
            child: Transform.scale(
              scale: 2,
              child: Icon(
                icon,
                color: isInverted ? const Color(0xFF1F2123) : Colors.white,
                size: 88,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
