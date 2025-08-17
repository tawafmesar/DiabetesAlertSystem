

import 'package:flutter/material.dart';

Widget customFAB({
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return Container(
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: [
          Color(0xFFEF3F2C),
          Color(0xFF954695),
          Color(0xFF0067B5),
        ],
        stops: [0.0, 0.6, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        transform: GradientRotation(0.4),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.transparent, // so gradient shows
      elevation: 0, // no extra shadow
      child: Icon(icon, color: Colors.white),
    ),
  );
}
