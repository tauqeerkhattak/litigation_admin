import 'package:flutter/material.dart';

class AppColors {
  static const Color navy = Color(0xFF0B1F3A);
  static const Color navyMid = Color(0xFF122848);
  static const Color navyLight = Color(0xFF1A3A5C);
  static const Color gold = Color(0xFFC9A84C);
  static const Color goldLight = Color(0xFFE2C87A);
  static const Color cream = Color(0xFFF5F0E8);
  static const Color creamDark = Color(0xFFEDE6D6);
  static const Color red = Color(0xFFC0392B);
  static const Color green = Color(0xFF1A7A4A);
  static const Color text = Color(0xFF1C2B3A);
  static const Color muted = Color(0xFF6B7C93);
  static const Color white = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFD4C9B0);
}

enum UserRole {
  editor, // Can create cases, hearings, and add documents
  commentor, // Cannot create cases, can create hearings and add documents
  documentor, // Cannot create cases and hearings, can only add documents
  viewer, // Only view cases, hearings, and documents
}
