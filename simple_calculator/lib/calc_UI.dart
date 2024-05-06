import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'btn_name_list.dart';

class CalculatorUI extends StatefulWidget {
  @override
  State<CalculatorUI> createState() => _CalculatorUIState();
}

class _CalculatorUIState extends State<CalculatorUI> {
  String userInput = "0";
  String result = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 18, 43, 100),
      body: Column(
        children: [
          SizedBox(height: 80),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: FittedBox(
              child: Text(
                userInput,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: FittedBox(
              child: Text(
                result,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SizedBox(height: 45),
          Divider(
            color: Color.fromRGBO(99, 89, 133, 100),
            height: 2,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        calculateResult(buttonList[index]);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: getColor(buttonList[index]),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(-3, -3),
                            spreadRadius: 1,
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Text(
                        buttonList[index],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Functions to Calculate result and to handle exceptions
  void calculateResult(String text) {
    if (text == "AC") {
      setState(() {
        userInput = "0";
        result = "0";
      });
      return;
    }

    if (text == "C") {
      setState(() {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        } else {
          return null;
        }
      });
      return;
    }

    if (text == "=") {
      try {
        var exp = Parser().parse(userInput);
        var eval = exp.evaluate(EvaluationType.REAL, ContextModel());
        String ans = eval.toString();

        if (ans.endsWith(".0")) {
          ans = ans.replaceAll(".0", "");
        }

        setState(() {
          userInput = ans;
          result = ans;
        });
      } catch (e) {
        setState(() {
          result = "Error";
        });
      }
      return;
    }

    RegExp calcRegex = RegExp(
        r'^(-?\d+(\.\d+)?([-+*/().]\d+(\.\d+)?)*([-+*/().])?)|\(-?\d+(\.\d+)?([-+*/().]\d+(\.\d+)?)*([-+*/().])?\)$');

    setState(() {
      if ((userInput == "0" && text != ".") ||
          (userInput == "" && text != ".")) {
        userInput = text;
      } else if ((RegExp(r'^[-+*/().!]$').hasMatch(text) &&
              !RegExp(r'^[-+*/().!]$')
                  .hasMatch(userInput.substring(userInput.length - 1))) ||
          (calcRegex.hasMatch(userInput) &&
              (RegExp(r'^-?\d+(\.\d+)?$').hasMatch(text)))) {
        userInput += text;
      }
    });
  }

  getColor(String text) {
    if (text == "AC") {
      return Color.fromRGBO(255, 132, 0, 100);
    }
    if (text == "(" ||
        text == ")" ||
        text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "=" ||
        text == "." ||
        text == "C") {
      return Color.fromRGBO(57, 48, 83, 100);
    } else {
      return Color.fromRGBO(99, 89, 133, 100);
    }
  }
}
