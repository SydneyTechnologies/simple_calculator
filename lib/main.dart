import 'package:flutter/material.dart';
import 'package:simple_calculator/constants.dart';
import 'package:provider/provider.dart';
import 'calculator.dart';
import 'app_theme.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => CalculatorBrain(),
          ),
          ChangeNotifierProvider(
            create: (context) => CalcTheme(),
          ),
        ],
        child: Consumer<CalcTheme>(
          builder: (context, theme, child) => Scaffold(
            backgroundColor: (theme.getDarkMode() == true)
                ? AppConstants.backgroundColor
                : AppConstants.lightModeBackgroundColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
                  height: 30,
                ),
                AppTheme(),
                ViewPort(),
                InputBoard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppTheme extends StatelessWidget {
  const AppTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<CalcTheme>(
        builder: (context, theme, child) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                CalcTheme appTheme =
                    Provider.of<CalcTheme>(context, listen: false);
                appTheme.setLightMode();
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                decoration: BoxDecoration(
                  color: (theme.getDarkMode() == true)
                      ? AppConstants.inputBoardColor
                      : AppConstants.lightModeBoardColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.zero,
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.zero),
                ),
                child: const Icon(
                  Icons.sunny,
                  color: Colors.grey,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                CalcTheme appTheme =
                    Provider.of<CalcTheme>(context, listen: false);
                appTheme.setDarkMode();
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                decoration: BoxDecoration(
                  color: (theme.getDarkMode() == true)
                      ? AppConstants.inputBoardColor
                      : AppConstants.lightModeBoardColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(15)),
                ),
                child: const Icon(
                  Icons.dark_mode,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ViewPort extends StatelessWidget {
  const ViewPort({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Consumer<CalcTheme>(
      builder: (context, theme, child) => Container(
        padding: const EdgeInsets.all(30),
        width: double.infinity,
        child: Consumer<CalculatorBrain>(
          builder: (context, calcBrain, child) => Text(
            calcBrain.entryValue,
            textAlign: TextAlign.end,
            style: TextStyle(
                color:
                    (theme.getDarkMode() == true) ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 50),
          ),
        ),
      ),
    ));
  }
}

class InputBoard extends StatelessWidget {
  const InputBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Consumer<CalcTheme>(
        builder: (context, theme, child) => Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: (theme.getDarkMode() == true)
                ? AppConstants.inputBoardColor
                : AppConstants.lightModeBoardColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(35),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Wrap(
              children: [
                NumberButtons(
                  text: "AC",
                  color: Colors.amber.shade300,
                  operations: true,
                ),
                NumberButtons(
                  text: "+/-",
                  color: Colors.amber.shade300,
                  operations: true,
                ),
                NumberButtons(
                  text: "%",
                  color: Colors.amber.shade300,
                  operations: true,
                ),
                NumberButtons(
                  text: "÷",
                  color: Colors.amber.shade300,
                  operations: true,
                ),
                const NumberButtons(text: "7"),
                const NumberButtons(text: "8"),
                const NumberButtons(text: "9"),
                NumberButtons(
                  text: "×",
                  color: Colors.red.shade200,
                  operations: true,
                ),
                const NumberButtons(text: "4"),
                const NumberButtons(text: "5"),
                const NumberButtons(text: "6"),
                NumberButtons(
                  text: "-",
                  color: Colors.red.shade200,
                  operations: true,
                ),
                const NumberButtons(text: "1"),
                const NumberButtons(text: "2"),
                const NumberButtons(text: "3"),
                NumberButtons(
                  text: "+",
                  color: Colors.red.shade200,
                  operations: true,
                ),
                const NumberButtons(
                  text: "",
                  icon: Icon(
                    Icons.restart_alt_rounded,
                    color: Colors.white70,
                    size: 30,
                  ),
                ),
                const NumberButtons(text: "0"),
                const NumberButtons(
                  text: ".",
                  decimal: true,
                ),
                NumberButtons(
                  text: "=",
                  color: Colors.red.shade200,
                  operations: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NumberButtons extends StatelessWidget {
  final String text;
  final Color? color;
  final Icon? icon;
  final bool? operations;
  final bool? decimal;
  const NumberButtons(
      {Key? key,
      required this.text,
      this.color,
      this.icon,
      this.operations,
      this.decimal})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<CalcTheme>(
      builder: (context, theme, child) => GestureDetector(
        onTap: () {
          if (operations == null) {
            if (decimal == null) {
              Provider.of<CalculatorBrain>(context, listen: false)
                  .addNumber(double.parse(text));
            } else {
              Provider.of<CalculatorBrain>(context, listen: false)
                  .addNumber(0.0, decimalNumber: true);
            }
          } else {
            Provider.of<CalculatorBrain>(context, listen: false)
                .addOperation(text);
          }
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: (theme.getDarkMode() == true)
                ? AppConstants.inputBoardColor
                : Colors.white70,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: (icon != null)
                ? icon
                : Text(
                    text,
                    style: TextStyle(
                        letterSpacing: 2,
                        color: (color == null)
                            ? (theme.getDarkMode())
                                ? Colors.white70
                                : Colors.black
                            : color,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
          ),
        ),
      ),
    );
  }
}
