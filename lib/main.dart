import 'package:calc_app/buttons.dart';
import 'package:calc_app/help_lists.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var userAnswer = '';
  var input = '';
  var ansHist = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black54,
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          input,
                          style: TextStyle(
                            fontSize: 48,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Text(
                          userAnswer,
                          style: TextStyle(
                            fontSize: 30,
                            color: const Color.fromARGB(255, 192, 192, 192),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  return MyButton(
                    buttonTapped: () {
                      if (isClear(buttons[index])) {
                        setState(() {
                          input = '';
                          userAnswer = '';
                        });
                      } else if (isDelete(buttons[index])) {
                        setState(() {
                          input = input.substring(0, input.length - 1);
                        });
                      } else if (isEquals(buttons[index])) {
                        setState(() {
                          equalPressed();
                        });
                      } else if (isAns(buttons[index])) {
                        setState(() {
                          input = ansHist;
                        });
                      } else {
                        setState(() {
                          input += buttons[index];
                        });
                      }
                    },
                    textColor:
                        isDelete(buttons[index]) || isClear(buttons[index])
                            ? Colors.deepOrange[300]
                            : Colors.white,
                    buttonText: buttons[index],
                    color: isEquals(buttons[index])
                        ? Colors.deepOrange[300]
                        : Colors.black,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isEquals(String x) {
    if (x == '=') {
      return true;
    }
    return false;
  }

  bool isDelete(String y) {
    if (y == 'DEL') {
      return true;
    }
    return false;
  }

  bool isClear(String z) {
    if (z == 'C') {
      return true;
    }
    return false;
  }

  bool isAns(String a) {
    if (a == 'ANS') {
      return true;
    }
    return false;
  }

  bool isOperator(String b) {
    if (b == '%' || b == '/' || b == '*' || b == '-' || b == '+') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String userQues = input;
    Parser p = Parser();
    Expression exp = p.parse(userQues);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
    ansHist = userAnswer;
  }
}
