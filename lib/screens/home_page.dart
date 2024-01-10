import 'package:calculator/util/custom_buttons.dart';
import 'package:calculator/util/custom_drawer.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = '';
  String _newCounter = '';
  double firstCounter = 0.0;
  String operation = '';
  String _operationDisplay = '';

  final List<String> _operationsHistory = [];
  final List<String> _operationsHistoryDisplay = [];
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> firstList = ['AC', '+/-', '%', '/'];
  final List<String> num7to9List = ['7', '8', '9', 'x'];
  final List<String> num4to6List = ['4', '5', '6', '-'];
  final List<String> num1to3List = ['1', '2', '3', '+'];

  bool isOperation(String buttonLabel) {
    const operationList = ['/', 'x', '-', '+'];
    return operationList.contains(buttonLabel);
  }

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
          setState(() {
            _newCounter = _counter;
          });
        } else if (operation == '-') {
          result = firstCounter - double.parse(_counter);
          result = double.parse(result.toStringAsFixed(2));
          setState(() {
            _newCounter = _counter;
          });
        } else if (operation == 'x') {
          result = firstCounter * double.parse(_counter);
          result = double.parse(result.toStringAsFixed(2));
          setState(() {
            _newCounter = _counter;
          });
        } else if (operation == '/') {
          result = firstCounter / double.parse(_counter);
          result = double.parse(result.toStringAsFixed(2));
          setState(() {
            _newCounter = _counter;
          });
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

    if (key == '=') {
      setState(() {
        int newFirstCounter = 0;
        if (firstCounter == firstCounter.toInt()) {
          newFirstCounter = firstCounter.toInt();
          _operationsHistoryDisplay
              .add('$newFirstCounter $operation $_newCounter = $_counter');
        } else {
          _operationsHistoryDisplay
              .add('$firstCounter $operation $_newCounter = $_counter');
        }
      });
    }
  }

  void closeDrawer(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 70;

    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        top: true,
        child: OperationsHistoryDrawer(
          operationsHistoryDisplay: _operationsHistoryDisplay,
          onItemSelected: (selectedItem) {
            setState(() {
              _counter = selectedItem.split('=')[1].trim();
              _operationDisplay = selectedItem.split('=')[0].trim();
            });
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _operationsHistory.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_operationsHistory[index]),
                      );
                    },
                  ),
                ),
              ),
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
                      child: SelectableText(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: firstList.map<Widget>((number) {
                  return CustomButton(
                    buttonSize: buttonSize,
                    text: number,
                    onPressed: () => _incrementCounter(number),
                    color: isOperation(number)
                        ? Colors.orange
                        : Colors.grey as Color,
                    overlayColor: const Color.fromARGB(90, 255, 255, 255),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: num7to9List.map<Widget>((number) {
                  return CustomButton(
                    buttonSize: buttonSize,
                    text: number,
                    onPressed: () => _incrementCounter(number),
                    color: isOperation(number)
                        ? Colors.orange
                        : Colors.grey[800] as Color,
                    overlayColor: const Color.fromARGB(90, 255, 255, 255),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: num4to6List.map<Widget>((number) {
                  return CustomButton(
                    buttonSize: buttonSize,
                    text: number,
                    onPressed: () => _incrementCounter(number),
                    color: isOperation(number)
                        ? Colors.orange
                        : Colors.grey[800] as Color,
                    overlayColor: const Color.fromARGB(90, 255, 255, 255),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: num1to3List.map<Widget>((number) {
                  return CustomButton(
                    buttonSize: buttonSize,
                    text: number,
                    onPressed: () => _incrementCounter(number),
                    color: isOperation(number)
                        ? Colors.orange
                        : Colors.grey[800] as Color,
                    overlayColor: const Color.fromARGB(90, 255, 255, 255),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}