import 'package:calculator/util/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:calculator/util/media_query.dart';

class PortraitWidget extends StatelessWidget {
  final ScrollController scrollController;
  final List<String> operationsHistory;
  final String operationDisplay;
  final String counter;
  final Function(String) incrementCounter;
  final Function(String) isOperation;
  final List<String> firstList;
  final List<String> num7to9List;
  final List<String> num4to6List;
  final List<String> num1to3List;

  const PortraitWidget({
    required this.scrollController,
    required this.operationsHistory,
    required this.operationDisplay,
    required this.counter,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          height: 35,
          child: ListView.builder(
            controller: scrollController,
            itemCount: operationsHistory.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.zero,
                child: ListTile(
                  title: Text(operationsHistory[index]),
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 23.0),
                    child: Text(
                      operationDisplay,
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
                        incrementCounter('delete');
                      },
                      child: SelectableText(
                        counter,
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
    );
  }
}
