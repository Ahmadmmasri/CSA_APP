import 'dart:ui';

class ColorConverter {
  static Color hexToColor(String code) {
    // Remove the '#' if present
    String hex = code.replaceAll('#', '');

    // Parse the hex string to an integer
    int hexColor = int.parse(hex, radix: 16);

    // Add the alpha value to the hexadecimal color (0xFF)
    hexColor = 0xFF000000 + hexColor;

    // Create a Color object from the integer
    return Color(hexColor);
  }
}
