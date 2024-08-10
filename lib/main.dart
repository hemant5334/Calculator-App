import 'package:calculator_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApplication());
}

class CalculatorApplication extends StatefulWidget {
  const CalculatorApplication({super.key});

  @override
  State<CalculatorApplication> createState() => _CalculatorApplicationState();
}

class _CalculatorApplicationState extends State<CalculatorApplication> {
  var result = '0';
  var inputUser = '';

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RawMaterialButton(
          onPressed: () {
            if (text1 == 'AC') {
              setState(() {
                inputUser = '';
                result = '0';
              });
            } else {
              buttonPressed(text1);
            }
          },
          elevation: 2.0,
          fillColor: const Color.fromARGB(255, 128, 209, 131),
          padding: const EdgeInsets.all(18.0),
          shape: const CircleBorder(),
          child: Text(
            text1,
            style: TextStyle(
                color: getTextColor(text1),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            if (text2 == '( )') {
              setState(() {
                if (inputUser.isNotEmpty) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          elevation: 2.0,
          fillColor: const Color.fromARGB(255, 128, 209, 131),
          padding: const EdgeInsets.all(18.0),
          shape: const CircleBorder(),
          child: Text(
            text2,
            style: TextStyle(
                color: getTextColor(text2),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            buttonPressed(text3);
          },
          elevation: 2.0,
          fillColor: const Color.fromARGB(255, 128, 209, 131),
          padding: const EdgeInsets.all(18.0),
          shape: const CircleBorder(),
          child: Text(
            text3,
            style: TextStyle(
                color: getTextColor(text3),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);

              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          elevation: 2.0,
          fillColor: Colors.white,
          padding: const EdgeInsets.all(14.0),
          shape: const CircleBorder(),
          child: Text(
            text4,
            style: const TextStyle(
                fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            inputUser,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            '= ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              result,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    getRow('AC', '( )', '%', '/'),
                    getRow('7', '8', '9', '*'),
                    getRow('4', '5', '6', '-'),
                    getRow('1', '2', '3', '+'),
                    getRow('0', '.', 'X', '='),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isOprator(String text) {
    var list = ['AC', '( )', '%'];

    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getTextColor(String text) {
    if (isOprator(text)) {
      return Colors.black;
    } else {
      return kWhite;
    }
  }
}
