enum AppRoute {
  splash,
  home,
  cartaz,
}

extension AppRouteExtension on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.splash:
        return '/splash';
      case AppRoute.home:
        return '/home';
      case AppRoute.cartaz:
        return '/cartaz';
    }
  }
}