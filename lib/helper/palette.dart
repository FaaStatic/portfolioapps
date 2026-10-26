import 'package:flutter/material.dart';

class Palette {
  static const background = Color(0xFFF5F9FF);
  static const panel = Color(0xFFE6F1FD);
  static const heading = Color(0xFF0D47A1);
  static const primary = Color(0xFF1976D2);
  static const body = Color(0xFF4A5A70);
  static const accent = Color(0xFFFFCA28);

  static const buttonGradient = LinearGradient(colors: [Color(0xFF42A5F5), primary]);

  /// Backdrops for the round project badges, cycled per card.
  static const badgeGradients = [
    LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF90CAF9), Color(0xFF1E88E5)]),
    LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFFFE082), Color(0xFFFFB300)]),
    LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1976D2), heading]),
    LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFE3F2FD), Color(0xFF64B5F6)]),
  ];
}

/// Body copy uses Quicksand; headings and UI inherit Nunito from the theme.
const bodyFont = "Quicksand";
