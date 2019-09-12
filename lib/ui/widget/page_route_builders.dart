import 'package:flutter/material.dart';

/// function: page_route_builders
/// <p>Created by Leo on 2019/5/16.</p>
class RouteBuilders {
  /// 从右边滑入路由
  static Route slideFromRight(Widget child) => PageRouteBuilder(
        pageBuilder: (context, _, __) {
          return child;
        },
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0),
              end: Offset(0.0, 0.0),
            ).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
            child: child,
          );
        },
      );
}
