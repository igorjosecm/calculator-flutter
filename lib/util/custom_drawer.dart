import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OperationsHistoryDrawer extends StatelessWidget {
  final List<String> operationsHistoryDisplay;
  final Function(String) onItemSelected;

  const OperationsHistoryDrawer({super.key, 
    required this.operationsHistoryDisplay,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 90,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.orange,
                ),
                child: Center(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Histórico de operações',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: operationsHistoryDisplay.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(operationsHistoryDisplay[index]),
                    onTap: () {
                      onItemSelected(operationsHistoryDisplay[index]);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}