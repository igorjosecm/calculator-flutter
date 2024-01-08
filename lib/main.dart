import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      darkTheme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.grey),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = '';
  double firstCounter = 0.0;
  String operation = '';
  String _operationDisplay = '';
  final List<String> _operationsHistory = [];
  final ScrollController _scrollController = ScrollController();

  void _incrementCounter(String key) {
    switch (key) {
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
      case '.':
        if (key == '.' && _counter.contains('.')) {
        } else if (_counter.length < 10) {
          setState(() {
            _counter += key;

            if (!_counter.contains('.')) {
              int counterInt = int.parse(_counter);
              _counter = counterInt.toString();
            }
          });
        }
        break;
      case '/':
        operation = key;
        firstCounter = double.parse(_counter);
        _counter = '0';
        break;
      case 'x':
        operation = key;
        firstCounter = double.parse(_counter);
        _counter = '0';
        break;
      case '-':
        if (_counter != '') {
          operation = key;
          firstCounter = double.parse(_counter);
          _counter = '0';
        }
        break;
      case '+':
        if (_counter != '') {
          operation = key;
          firstCounter = double.parse(_counter);
          _counter = '0';
        }
        break;
      case '%':
        if (_counter != '') {
          if (_counter != '0' &&
              _counter != double.negativeInfinity.toString() &&
              firstCounter != double.negativeInfinity) {
            double counterValue = double.parse(_counter);
            if (counterValue < 0) {
            } else {
              setState(() {
                firstCounter = counterValue / 100;
                _counter = firstCounter.toString();
              });
            }
          }
        }
        break;
      case '+/-':
        if (_counter != '' && _counter != '0') {
          if (_counter[0] == '-') {
            setState(() {
              _counter = _counter.substring(1);
            });
          } else {
            setState(() {
              _counter = '-$_counter';
            });
          }
        }
        break;
      case 'delete':
        setState(() {
          if (_counter != '') {
            _counter = _counter.substring(0, _counter.length - 1);
          }
        });
        break;
      case '=':
        if (_counter == '') {
          return;
        }

        double result = 0.0;

        if (operation == '/') {
          if (double.parse(_counter) == 0) {
            setState(() {
              _counter = 'ERRO';
            });
            return;
          }
        }

        if (operation == '+') {
          result = firstCounter + (double.parse(_counter));
          result = double.parse(result.toStringAsFixed(2));
        } else if (operation == '-') {
          result = firstCounter - double.parse(_counter);
          result = double.parse(result.toStringAsFixed(2));
        } else if (operation == 'x') {
          result = firstCounter * double.parse(_counter);
          result = double.parse(result.toStringAsFixed(2));
        } else if (operation == '/') {
          result = firstCounter / double.parse(_counter);
          result = double.parse(result.toStringAsFixed(2));
        }

        String resultString = result.toString();
        List<String> resultSplit = resultString.split('.');

        if (resultSplit[1] == '0') {
          setState(() {
            _counter = int.parse(resultSplit[0]).toString();
          });
        } else {
          setState(() {
            _counter = result.toString();
          });
        }

        if (resultString.length > 10) {
          setState(() {
            resultString = result.toStringAsExponential(2);
            _counter = resultString;
          });
        }

        setState(() {
          _operationDisplay = '';
        });

        setState(() {
          _operationsHistory.add('= $_counter');
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        });

        break;
      case 'AC':
        setState(() {
          _counter = '';
          firstCounter = 0.0;
          _operationDisplay = '';
        });
        break;
      default:
        if (_counter.length < 10) {
          key += _counter;
        }
        break;
    }

    if (['/', 'x', '-', '+', '%'].contains(key) && _counter.isNotEmpty) {
      if (double.parse(_counter) < 0 && key == '%') {}
      operation = key;
      setState(() {
        _operationDisplay = '$firstCounter $operation';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 70;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: ListView.builder(
              controller: _scrollController,
              itemCount: _operationsHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_operationsHistory[index]),
                );
              },
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Text(
                    _operationDisplay,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onHorizontalDragStart: (details) {
                      _incrementCounter('delete');
                    },
                    child: Text(
                      _counter,
                      style: const TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomButton(
                  buttonSize: buttonSize,
                  text: 'AC',
                  onPressed: () => _incrementCounter('AC'),
                  color: Colors.grey,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
                CustomButton(
                  buttonSize: buttonSize,
                  text: '+/-',
                  onPressed: () => _incrementCounter('+/-'),
                  color: Colors.grey,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
                CustomButton(
                  buttonSize: buttonSize,
                  text: '%',
                  onPressed: () => _incrementCounter('%'),
                  color: Colors.grey,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
                CustomButton(
                  buttonSize: buttonSize,
                  text: '/',
                  onPressed: () => _incrementCounter('/'),
                  color: Colors.orange,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomButton(
                  buttonSize: buttonSize,
                  text: '7',
                  onPressed: () => _incrementCounter('7'),
                  color: Colors.grey[800] as Color,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
                CustomButton(
                  buttonSize: buttonSize,
                  text: '8',
                  onPressed: () => _incrementCounter('8'),
                  color: Colors.grey[800] as Color,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
                CustomButton(
                  buttonSize: buttonSize,
                  text: '9',
                  onPressed: () => _incrementCounter('9'),
                  color: Colors.grey[800] as Color,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
                CustomButton(
                  buttonSize: buttonSize,
                  text: 'x',
                  onPressed: () => _incrementCounter('x'),
                  color: Colors.orange,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomButton(
                  buttonSize: buttonSize,
                  text: '4',
                  onPressed: () => _incrementCounter('4'),
                  color: Colors.grey[800] as Color,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
                CustomButton(
                  buttonSize: buttonSize,
                  text: '5',
                  onPressed: () => _incrementCounter('5'),
                  color: Colors.grey[800] as Color,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
                CustomButton(
                  buttonSize: buttonSize,
                  text: '6',
                  onPressed: () => _incrementCounter('6'),
                  color: Colors.grey[800] as Color,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
                CustomButton(
                  buttonSize: buttonSize,
                  text: '-',
                  onPressed: () => _incrementCounter('-'),
                  color: Colors.orange,
                  overlayColor: const Color.fromARGB(50, 50, 50, 50),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomButton(
                  buttonSize: buttonSize,
                  text: '1',
                  onPressed: () => _incrementCounter('1'),
                  color: Colors.grey[800] as Color,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
                CustomButton(
                  buttonSize: buttonSize,
                  text: '2',
                  onPressed: () => _incrementCounter('2'),
                  color: Colors.grey[800] as Color,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
                CustomButton(
                  buttonSize: buttonSize,
                  text: '3',
                  onPressed: () => _incrementCounter('3'),
                  color: Colors.grey[800] as Color,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
                CustomButton(
                  buttonSize: buttonSize,
                  text: '+',
                  onPressed: () => _incrementCounter('+'),
                  color: Colors.orange,
                  overlayColor: const Color.fromARGB(50, 50, 50, 50),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DoubleButton(
                  number: '0',
                  buttonSize: buttonSize,
                  fun: () => _incrementCounter('0'),
                ),
                CustomButton(
                  text: ',',
                  onPressed: () => _incrementCounter('.'),
                  color: Colors.grey[800] as Color,
                  buttonSize: buttonSize,
                  overlayColor: const Color.fromARGB(90, 255, 255, 255),
                ),
                CustomButton(
                  text: '=',
                  onPressed: () => _incrementCounter('='),
                  color: Colors.orange,
                  buttonSize: buttonSize,
                  overlayColor: const Color.fromARGB(50, 50, 50, 50),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DoubleButton extends StatelessWidget {
  final String number;
  final double buttonSize;
  final Function() fun;

  const DoubleButton({
    required this.number,
    required this.buttonSize,
    required this.fun,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (buttonSize * 2) + 20,
      height: buttonSize,
      margin: const EdgeInsets.all(5),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => Colors.grey[800] as Color,
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return const Color.fromARGB(90, 255, 255, 255);
              }
              return null;
            },
          ),
        ),
        onPressed: fun,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;
  final Color? overlayColor;
  final double buttonSize;

  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.color,
    this.overlayColor,
    required this.buttonSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonSize,
      height: buttonSize,
      margin: const EdgeInsets.all(5),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => color),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return overlayColor;
              }
              return null;
            },
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
