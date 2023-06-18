import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class BasePage extends StatelessWidget {
  Widget page;
  BasePage({required this.page});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return new Stack(
            fit: StackFit.expand,
            children: [
              page,
              Positioned(
                bottom: 50.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                  child: Text(
                    "${connected ? 'ONLINE' : 'OFFLINE'}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
        child: page);
  }
}
