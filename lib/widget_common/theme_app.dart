import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Theme 1 - Teal theme
final ThemeData tealTheme = ThemeData(
  primaryColor: Colors.teal,
  appBarTheme: AppBarTheme(
    color: Colors.teal.withOpacity(0.8),
    brightness: Brightness.dark,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.teal.withOpacity(0.8),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white.withOpacity(0.6),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.teal.withOpacity(0.8),
    ),
    bodyMedium: TextStyle(
      color: Colors.teal.withOpacity(0.8),
    ),
    titleLarge: TextStyle(
      color: Colors.teal.withOpacity(0.8),
    ),
    titleMedium: TextStyle(
      color: Colors.teal.withOpacity(0.8),
    ),
    titleSmall: TextStyle(
      color: Colors.teal.withOpacity(0.8),
    ),
  ),
);

// Theme 2 - Purple theme
final ThemeData purpleTheme = ThemeData(
  primaryColor: Colors.purple,
  appBarTheme: AppBarTheme(
    color: Colors.purple.withOpacity(0.8), systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.purple.withOpacity(0.8),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white.withOpacity(0.6),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.purple.withOpacity(0.8),
    ),
    bodyMedium: TextStyle(
      color: Colors.purple.withOpacity(0.8),
    ),
    titleLarge: TextStyle(
      color: Colors.purple.withOpacity(0.8),
    ),
    titleMedium: TextStyle(
      color: Colors.purple.withOpacity(0.8),
    ),
    titleSmall: TextStyle(
      color: Colors.purple.withOpacity(0.8),
    ),
  ),
);

// Theme 3 - Orange theme
final ThemeData orangeTheme = ThemeData(
  primaryColor: Colors.orange,
  appBarTheme: AppBarTheme(
    color: Colors.orange.withOpacity(0.8),
    brightness: Brightness.dark,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.orange.withOpacity(0.8),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white.withOpacity(0.6),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.orange.withOpacity(0.8),
    ),
    bodyMedium: TextStyle(
      color: Colors.orange.withOpacity(0.8),
    ),
    titleLarge: TextStyle(
      color: Colors.orange.withOpacity(0.8),
    ),
    titleMedium: TextStyle(
      color: Colors.orange.withOpacity(0.8),
    ),
    titleSmall: TextStyle(
      color: Colors.orange.withOpacity(0.8),
    ),
  ),
);








// final theme1 = ThemeData(
  
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Colors.amberAccent
//   )
// );

// final theme2 = ThemeData(
//     appBarTheme: const AppBarTheme(
//         backgroundColor: Colors.black,
//     )
// );

// final theme3 = ThemeData(
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.red,
//     ),
//   scaffoldBackgroundColor: Colors.grey
// );
