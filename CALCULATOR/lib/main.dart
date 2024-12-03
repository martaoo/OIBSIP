import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String userInput = '';
  String result = '0';

  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '7', '8', '9', '*',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '0', '.', '=', '',
  ];

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        userInput = '';
        result = '0';
      } else if (buttonText == 'DEL') {
        userInput = userInput.isNotEmpty
            ? userInput.substring(0, userInput.length - 1)
            : '';
      } else if (buttonText == '=') {
        try {
          Parser parser = Parser();
          Expression exp = parser.parse(userInput);
          ContextModel contextModel = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, contextModel)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        userInput += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          width: 360, // Simulates a typical phone screen width
          height: 640, // Simulates a typical phone screen height
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        userInput,
                        style: const TextStyle(fontSize: 32, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        result,
                        style: const TextStyle(fontSize: 48, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.grey[900],
                  child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, index) {
                      final button = buttons[index];
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _getButtonColor(button),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: button.isNotEmpty
                            ? () => onButtonPressed(button)
                            : null,
                        child: Text(
                          button,
                          style: TextStyle(
                            color: _getTextColor(button),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(String button) {
    if (button == 'C' || button == 'DEL') return Colors.red;
    if (button == '=' || button == '+' || button == '-' || button == '*' || button == '/') {
      return Colors.orange;
    }
    return Colors.grey[850]!;
  }

  Color _getTextColor(String button) {
    return button == '=' || button == '+' || button == '-' || button == '*' || button == '/'
        ? Colors.white
        : Colors.white70;
  }
}
