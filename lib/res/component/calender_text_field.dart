import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarTextField extends StatelessWidget {
  final TextEditingController calenderController;
  final String labelText;
  final String? calenderValidationText;
  final FormFieldValidator? onValidator;

  final Function(DateTime?) onDateSelected;

  const CalendarTextField({
    Key? key,
    required this.calenderController,
    required this.labelText,
    required this.onDateSelected,
    this.calenderValidationText,
    this.onValidator,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2006),
      firstDate: DateTime(1933),
      lastDate: DateTime(2006),
    );

    if (picked != null) {
      onDateSelected(picked);
      calenderController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: TextFormField(
                controller: calenderController,
                readOnly: true,
                validator: onValidator,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: labelText,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
