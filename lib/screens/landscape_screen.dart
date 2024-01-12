import 'package:calculator/util/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:calculator/util/media_query.dart';

class LandscapeWidget extends StatelessWidget {
  final String counter;
  final String operationDisplay;
  final Function(String) incrementCounter;
  final Function(String) isOperation;
  final List<String> firstList;
  final List<String> num7to9List;
  final List<String> num4to6List;
  final List<String> num1to3List;

  const LandscapeWidget({
    required this.counter,
    required this.operationDisplay,
    required this.incrementCounter,
    required this.isOperation,
    required this.firstList,
    required this.num7to9List,
    required this.num4to6List,
    required this.num1to3List,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onHorizontalDragStart: (details) {
                            incrementCounter('delete');
                          },
                          child: SelectableText(
                            counter,
                            style: const TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      operationDisplay,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: firstList.map<Widget>((number) {
                        return CustomButton(
                          buttonHeight: getButtonHeight(context),
                          buttonWidth: getButtonWidth(context),
                          fontSize: getFontSize(context),
                          text: number,
                          onPressed: () => incrementCounter(number),
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
                          buttonHeight: getButtonHeight(context),
                          buttonWidth: getButtonWidth(context),
                          fontSize: getFontSize(context),
                          text: number,
                          onPressed: () => incrementCounter(number),
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
                          buttonHeight: getButtonHeight(context),
                          buttonWidth: getButtonWidth(context),
                          fontSize: getFontSize(context),
                          text: number,
                          onPressed: () => incrementCounter(number),
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
                          buttonHeight: getButtonHeight(context),
                          buttonWidth: getButtonWidth(context),
                          fontSize: getFontSize(context),
                          text: number,
                          onPressed: () => incrementCounter(number),
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
                          buttonHeight: getButtonHeight(context),
                          buttonWidth: getButtonWidth(context),
                          fontSize: getFontSize(context),
                          fun: () => incrementCounter('0'),
                        ),
                        CustomButton(
                          text: ',',
                          onPressed: () => incrementCounter('.'),
                          color: Colors.grey[800] as Color,
                          buttonHeight: getButtonHeight(context),
                          buttonWidth: getButtonWidth(context),
                          fontSize: getFontSize(context),
                          overlayColor: const Color.fromARGB(90, 255, 255, 255),
                        ),
                        CustomButton(
                          text: '=',
                          onPressed: () => incrementCounter('='),
                          color: Colors.orange,
                          buttonHeight: getButtonHeight(context),
                          buttonWidth: getButtonWidth(context),
                          fontSize: getFontSize(context),
                          overlayColor: const Color.fromARGB(50, 50, 50, 50),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
