import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nex_vote/consts/conts.dart';

class ProposalBottomSheet extends StatefulWidget {
  final VoidCallback onSubmit;

  ProposalBottomSheet({required this.onSubmit});

  @override
  State<ProposalBottomSheet> createState() => _ProposalBottomSheetState();
}

class _ProposalBottomSheetState extends State<ProposalBottomSheet> {
  final TextEditingController title = TextEditingController();
  final TextEditingController des = TextEditingController();

  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add New Proposal',
            style: GoogleFonts.openSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: title,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: des,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, isStartDate: true),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: TextEditingController(
                        text: _startDate == null
                            ? ''
                            : '${_startDate!.toLocal()}'
                                .split(' ')[0], // Formatting date
                      ),
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectTime(context, isStartTime: true),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: TextEditingController(
                        text: _startTime == null
                            ? ''
                            : _startTime!.format(context), // Formatting time
                      ),
                      decoration: InputDecoration(
                        labelText: 'Start Time',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, isStartDate: false),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: TextEditingController(
                        text: _endDate == null
                            ? ''
                            : '${_endDate!.toLocal()}'
                                .split(' ')[0], // Formatting date
                      ),
                      decoration: InputDecoration(
                        labelText: 'End Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectTime(context, isStartTime: false),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: TextEditingController(
                        text: _endTime == null
                            ? ''
                            : _endTime!.format(context),
                      ),
                      decoration: InputDecoration(
                        labelText: 'End Time',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (kDebugMode) {
                  print('Title: ${title.text}');
                  print('Description: ${des.text}');
                  print('Start Date: $_startDate');
                  print('Start Time: $_startTime');
                  print('End Date: $_endDate');
                  print('End Time: $_endTime');
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeNavColors.selectedIconBox,
              ),
              child: Text(
                'Submit',
                style: GoogleFonts.openSans(
                  color: ThemeNavColors.backgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context,
      {required bool isStartDate}) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate =
        isStartDate ? _startDate ?? now : _endDate ?? now;
    final DateTime firstDate = DateTime(now.year - 100);
    final DateTime lastDate = DateTime(now.year + 100);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      if (isStartDate) {
        setState(() {
          _startDate = pickedDate;
        });
      } else {
        setState(() {
          _endDate = pickedDate;
        });
      }
    }
  }

  Future<void> _selectTime(BuildContext context,
      {required bool isStartTime}) async {
    final TimeOfDay initialTime = isStartTime
        ? _startTime ?? TimeOfDay.now()
        : _endTime ?? TimeOfDay.now();

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      if (isStartTime) {
        setState(() {
          _startTime = pickedTime;
        });
      } else {
        setState(() {
          _endTime = pickedTime;
        });
      }
    }
  }
}
