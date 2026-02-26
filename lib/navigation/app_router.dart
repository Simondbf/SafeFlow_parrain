import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safeflow_parrain/screens/dashboard/home_screen.dart';
import 'package:safeflow_parrain/screens/dashboard/filleuls_screen.dart';
import 'package:safeflow_parrain/screens/dashboard/parametres_screen.dart';
import 'package:safeflow_parrain/core/app_colors.dart';

/// Router principal avec ShellRoute pour conserver la BottomNavigationBar
final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => _ScaffoldWithNav(child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/filleuls', builder: (_, __) => const FilleulsScreen()),
        GoRoute(path: '/parametres', builder: (_, __) => const ParametresScreen()),
      ],
    ),
  ],
);

class _ScaffoldWithNav extends StatelessWidget {
  final Widget child;
  const _ScaffoldWithNav({required this.child});

  static const _tabs = ['/home', '/filleuls', '/parametres'];

  /// Détermine l'index actif à partir de la location courante.
  int _currentIndex(BuildContext context) {
    final loc = GoRouter.of(context).location;
    final i = _tabs.indexWhere((t) => loc.startsWith(t));
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex(context),
        selectedItemColor: AppColors.primary,
        onTap: (i) => context.go(_tabs[i]),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outlined), activeIcon: Icon(Icons.people), label: 'Filleuls'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Paramètres'),
        ],
      ),
    );
  }
}
