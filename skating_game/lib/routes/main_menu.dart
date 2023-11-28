import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    super.key,
    required this.countTurns,
    this.onPlayPressed,
    this.onSettingsPressed,
    this.paymentPressed,
  });
  static const id = 'MainMenu';
  final VoidCallback? onPlayPressed;
  final VoidCallback? onSettingsPressed;
  final int countTurns;
  final VoidCallback? paymentPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background/Background.jpeg"),
            alignment: Alignment.bottomCenter,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextBorder(
                text: 'Skating',
                textColor: Colors.red,
                fontSize: 64,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextBorder(
                    text: 'You have : ',
                    textColor: Colors.blue,
                    fontSize: 32,
                  ),
                  TextBorder(
                    text: countTurns.toString(),
                    textColor: Colors.red,
                    fontSize: 32,
                  ),
                  const TextBorder(
                    text: ' turn left ',
                    textColor: Colors.blue,
                    fontSize: 32,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(210, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        side: const BorderSide(
                          width: 0.0,
                          color: Color.fromARGB(210, 255, 255, 255),
                        ),
                      ),
                      onPressed: countTurns <= 0 ? null : onPlayPressed,
                      child: const Text('Start Game',
                          style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 150,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(210, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        side: const BorderSide(
                          width: 0.0,
                          color: Color.fromARGB(210, 255, 255, 255),
                        ),
                      ),
                      onPressed: paymentPressed,
                      child: const Text('Payment',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 7, 7),
                              fontSize: 20)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 150,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          side: const BorderSide(
                            width: 0.0,
                            color: Color.fromARGB(210, 255, 255, 255),
                          ),
                          backgroundColor:
                              const Color.fromARGB(210, 255, 255, 255)),
                      onPressed: onSettingsPressed,
                      child: const Text('Settings',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 7, 7),
                            fontSize: 20,
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  errorPlay(BuildContext context) {}
}

class TextBorder extends StatelessWidget {
  const TextBorder({
    super.key,
    required this.text,
    required this.textColor,
    required this.fontSize,
  });
  final String text;
  final Color textColor;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 6
              ..color = Colors.white,
          ),
        ),
        // Solid text as fill.
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
