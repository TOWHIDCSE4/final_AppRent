import 'package:flutter/material.dart';

class YearDropdownMenuBar extends StatefulWidget {
  const YearDropdownMenuBar({super.key});

  @override
  State<YearDropdownMenuBar> createState() => _YearDropdownMenuBarState();
}

class _YearDropdownMenuBarState extends State<YearDropdownMenuBar> {
  List<int> years =
      List<int>.generate(50, (index) => DateTime.now().year + index);
  late int selectedYear;

  @override
  void initState() {
    super.initState();
    // Set an initial value if required
    selectedYear = years.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('(đvt: tỷ đồng)'),
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            menuMaxHeight: 350,
            value: selectedYear,
            onChanged: (newValue) {
              setState(() {
                selectedYear = newValue!;
              });
            },
            items: years.map<DropdownMenuItem<int>>((int year) {
              return DropdownMenuItem<int>(
                value: year,
                child: Text(year.toString()),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
