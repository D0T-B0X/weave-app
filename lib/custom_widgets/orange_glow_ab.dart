import 'package:flutter/material.dart'; 

class OrangeGlow extends StatelessWidget {
  final double top; 
  final double left; 

  // Constructor to initialize postion of top and left
  const OrangeGlow({super.key, required this.top, required this.left});

  @override 
  Widget build(BuildContext context) {
    return Positioned( // Positions the glow effect on each page
      top: top, 
      left: left, 
      child: Container(
        width: 300, 
        height: 300, 
        decoration: BoxDecoration(
          shape: BoxShape.circle, 
          gradient: RadialGradient( // Creates a radial gradient effect
            colors: [ // Defines different shades of orange with varying opacity.
              const Color(0xFFE76F04).withAlpha(80), // Strongest glow.
              const Color(0xFFE76F04).withAlpha(50),
              const Color(0xFFE76F04).withAlpha(45),
              const Color(0xFFE76F04).withAlpha(28),
              const Color(0xFFE76F04).withAlpha(25),
              const Color(0xFFE76F04).withAlpha(15),
              const Color(0xFFE76F04).withAlpha(15),
              const Color(0xFFE76F04).withAlpha(10),
              const Color(0xFFE76F04).withAlpha(8),
              const Color(0xFFE76F04).withAlpha(5),
              const Color(0xFFE76F04).withAlpha(3), // Faintest glow.
            ],
            stops: const [ //colour change position
              0.0, 0.2, 0.3, 0.4, 0.45, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0
            ],
            radius: 1.0, // Controls the spread of the radial gradient.
            center: Alignment.center, // Centers the glow effect.
          ),
        ),
      ),
    );
  }
}
