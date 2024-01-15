import 'package:flutter/material.dart';
import 'package:calculator/util/custom_drawer.dart';
import 'package:calculator/screens/portrait_screen.dart';
import 'package:calculator/screens/landscape_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = '0';
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
  final List<String> num0List = ['.00', '0', '.', '='];

  bool isOperation(String buttonLabel) {
    const operationList = ['/', 'x', '-', '+', '='];
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
      case '.00':
        if (key == '.00' && _counter.contains('.')) {
        } else if (_counter == '0') {
          setState(() {
            _counter = key;
          });
        } else if (_counter.length < 9) {
          setState(() {
            _counter += key;
          });
        }
        break;
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
        if (_counter != '0') {
          operation = key;
          firstCounter = double.parse(_counter);
          if (firstCounter == 0.0) {
            firstCounter = double.parse(_counter);
            _counter = '0';
          } else if (_counter != '0') {
            _counter = '0';
          }
        }
        break;
      case 'x':
        if (_counter != '0') {
          operation = key;
          firstCounter = double.parse(_counter);
          if (firstCounter == 0.0) {
            firstCounter = double.parse(_counter);
            _counter = '0';
          } else if (_counter != '0') {
            _counter = '0';
          }
        }
        break;
      case '-':
        if (_counter != '0') {
          operation = key;
          firstCounter = double.parse(_counter);
          if (firstCounter == 0.0) {
            firstCounter = double.parse(_counter);
            _counter = '0';
          } else if (_counter != '0') {
            _counter = '0';
          }
        }
        break;
      case '+':
        if (_counter != '0') {
          operation = key;
          firstCounter = double.parse(_counter);
          if (firstCounter == 0.0) {
            firstCounter = double.parse(_counter);
            _counter = '0';
          } else if (_counter != '0') {
            _counter = '0';
          }
        }
        break;
      case '%':
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
        break;
      case '+/-':
        if (_counter != '0') {
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
          if (_counter != '0') {
            _counter = _counter.substring(0, _counter.length - 1);
          }
        });
      case '=':
        if (_counter == '0') {
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
          setState(() {
            _newCounter = _counter;
          });
        } else if (operation == '-') {
          result = firstCounter - double.parse(_counter);
          setState(() {
            _newCounter = _counter;
          });
        } else if (operation == 'x') {
          result = firstCounter * double.parse(_counter);
          setState(() {
            _newCounter = _counter;
          });
        } else if (operation == '/') {
          result = firstCounter / double.parse(_counter);
          setState(() {
            _newCounter = _counter;
          });
        }

        if (result.abs() < 1) {
          setState(() {
            result = double.parse(result.toStringAsFixed(9));
            _counter = result.toString();
          });
          if (result.abs() < 0.00005) {
            setState(() {
              _counter = result.toStringAsExponential(2);
            });
          }
        } else {
          result = double.parse(result.toStringAsFixed(2));
          String resultString = result.toString();
          List<String> resultSplit = resultString.split('.');

          if (resultSplit.length > 1 && resultSplit[1] == '0') {
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
        }

        setState(() {
          _operationDisplay = '';
        });

        setState(() {
          _operationsHistory.add('= $_counter');
        });

        bool isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait;

        if (isPortrait) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          });
        }

        break;
      case 'AC':
        setState(() {
          _counter = '0';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Stack(
        children: [
          Positioned(
            left: 5.0,
            top: 120,
            child: FloatingActionButton(
              elevation: 1,
              backgroundColor: Colors.grey[800] as Color,
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: const Icon(Icons.history, color: Colors.white),
            ),
          ),
        ],
      ),
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
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return PortraitWidget(
                scrollController: _scrollController,
                operationsHistory: _operationsHistory,
                operationDisplay: _operationDisplay,
                counter: _counter,
                incrementCounter: _incrementCounter,
                isOperation: isOperation,
                firstList: firstList,
                num7to9List: num7to9List,
                num4to6List: num4to6List,
                num1to3List: num1to3List,
                num0List: num0List,
              );
            } else {
              return LandscapeWidget(
                counter: _counter,
                operationDisplay: _operationDisplay,
                incrementCounter: _incrementCounter,
                isOperation: isOperation,
                firstList: firstList,
                num7to9List: num7to9List,
                num4to6List: num4to6List,
                num1to3List: num1to3List,
                num0List: num0List,
              );
            }
          },
        ),
      ),
    );
  }
}
