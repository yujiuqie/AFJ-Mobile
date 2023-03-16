import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: WindowCaptionButton.minimize(
            brightness: Brightness.light,
            onPressed: () async {
              bool isMinimized = await windowManager.isMinimized();
              if (isMinimized) {
                windowManager.restore();
              } else {
                windowManager.minimize();
              }
            },
          ),
        ),
        SizedBox(
          width: 30,
          height: 30,
          child: FutureBuilder<bool>(
            future: windowManager.isMaximized(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return WindowCaptionButton.unmaximize(
                  brightness: Brightness.light,
                  onPressed: () async{
                    await windowManager.unmaximize();
                    setState(() {

                    });
                  },
                );
              }
              return WindowCaptionButton.maximize(
                brightness: Brightness.light,
                onPressed: () async{
                  await windowManager.maximize();
                  setState(() {

                  });
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 30,
          width: 30,
          child: WindowCaptionButton.close(
            brightness: Brightness.light,
            onPressed: () {
              windowManager.close();
            },
          ),
        ),
      ],
    );
  }
}
