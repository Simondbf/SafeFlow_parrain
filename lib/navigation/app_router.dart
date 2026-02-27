import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safeflow_parrain/core/app_colors.dart';
import 'package:safeflow_parrain/screens/dashboard/home_screen.dart';
import 'package:safeflow_parrain/screens/dashboard/filleuls_screen.dart';
import 'package:safeflow_parrain/screens/dashboard/parametres_screen.dart';
// Au merge feat/auth, ajouter :
// import 'package:safeflow_parrain/screens/auth/login_screen.dart';
// import 'package:safeflow_parrain/providers/auth_provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey:    _rootNavigatorKey,
  initialLocation: '/home',

  // Auth guard — décommenter au merge feat/auth :
  // redirect: (context, state) {
  //   final user = ref.read(authProvider);
  //   if (user == null && state.uri.toString() != '/login')
  //     return '/login';
  //   return null;
  // },

  routes: [
    // StatefulShellRoute — garde le scroll et l'état de chaque onglet.
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) =>
          ScaffoldWithAdaptiveNav(navigationShell: shell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/home',
            builder: (_, __) => const HomeScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/filleuls',
            builder: (_, __) => const FilleulsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/parametres',
            builder: (_, __) => const ParametresScreen()),
        ]),
      ],
    ),
    // Route login — décommenter au merge feat/auth :
    // GoRoute(path: '/login',
    //   builder: (_, __) => const LoginScreen()),
  ],
);

class ScaffoldWithAdaptiveNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithAdaptiveNav({super.key, required this.navigationShell});

  static const _destinations = [
    (icon: Icons.home_outlined,     active: Icons.home,     label: 'Accueil'),
    (icon: Icons.people_outlined,   active: Icons.people,   label: 'Filleuls'),
    (icon: Icons.settings_outlined, active: Icons.settings, label: 'Paramètres'),
  ];

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: Row(
        children: [
          if (isTablet) ...[
            NavigationRail(
              selectedIndex:         navigationShell.currentIndex,
              onDestinationSelected: navigationShell.goBranch,
              labelType:             NavigationRailLabelType.all,
              backgroundColor:       AppColors.surface,
              selectedIconTheme:
                const IconThemeData(color: AppColors.primary),
              destinations: [
                for (final d in _destinations)
                  NavigationRailDestination(
                    icon:         Icon(d.icon),
                    selectedIcon: Icon(d.active),
                    label:        Text(d.label),
                  ),
              ],
            ),
            const VerticalDivider(
              thickness: 1, width: 1, color: AppColors.divider),
          ],
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar: isTablet
          ? null
          : NavigationBar(
              selectedIndex:         navigationShell.currentIndex,
              onDestinationSelected: navigationShell.goBranch,
              backgroundColor:       AppColors.surface,
              indicatorColor:
                AppColors.primary.withOpacity(0.12),
              destinations: [
                for (final d in _destinations)
                  NavigationDestination(
                    icon:         Icon(d.icon),
                    selectedIcon: Icon(d.active),
                    label:        d.label,
                  ),
              ],
            ),
    );
  }
}
