import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:project/widgets/event_details_textfield.dart';
import 'package:toastification/toastification.dart';

class EditEvent extends StatefulWidget {
  static String routeName = '/edit_event';

  const EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();
  final TextEditingController eventAddressController = TextEditingController();

  final eventTypes = [
    'Conference',
    'Workshop',
    'Webinar',
    'Meetup',
    'Seminar',
  ];

  final categories = [
    'Technology',
    'Health',
    'Education',
    'Business',
    'Arts',
  ];

  String? selectedEventType;
  String? selectedCategory;

  DateTime? _selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Edit Event',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              EventDetailsField(
                title: 'Event Type',
                child: DropdownButtonFormField(
                  items: [
                    ...eventTypes.map(
                      (type) => DropdownMenuItem(
                        onTap: () => selectedEventType = type,
                        key: ValueKey(type),
                        value: type,
                        child: Text(type),
                      ),
                    ),
                  ],
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                  onChanged: (_) {},
                ),
              ),
              EventDetailsField(
                title: 'Event Name',
                child: TextField(
                  controller: eventNameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                ),
              ),
              EventDetailsField(
                title: 'Event Date & Time',
                child: GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2099),
                    );
                    if (pickedDate != null) {
                      if (!context.mounted) return;
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _selectedDateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        });
                      }
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 20.sp, color: Colors.grey),
                        Gap(10.w),
                        Text(
                          _selectedDateTime != null
                              ? '${_selectedDateTime!.toLocal()}'
                                  .split('.')
                                  .first
                              : 'Select date & time',
                          style: TextStyle(
                            color: _selectedDateTime != null
                                ? Colors.black
                                : Colors.grey,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              EventDetailsField(
                title: 'Event Description',
                child: TextField(
                  controller: eventDescriptionController,
                  maxLines: 3,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                ),
              ),
              EventDetailsField(
                title: 'Category',
                child: DropdownButtonFormField(
                  items: [
                    ...categories.map(
                      (category) => DropdownMenuItem(
                        onTap: () => selectedCategory = category,
                        key: ValueKey(category),
                        value: category,
                        child: Text(category),
                      ),
                    ),
                  ],
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                  onChanged: (_) {},
                ),
              ),
              EventDetailsField(
                title: 'Event Address',
                child: TextField(
                  controller: eventAddressController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                ),
              ),
              Gap(20.h),
              GestureDetector(
                onTap: () {
                  if (eventNameController.text.isNotEmpty &&
                      eventDescriptionController.text.isNotEmpty &&
                      eventAddressController.text.isNotEmpty &&
                      selectedEventType != null &&
                      _selectedDateTime != null &&
                      selectedCategory != null) {
                    Navigator.of(context).pop();
                    toastification.show(
                      context: context,
                      type: ToastificationType.success,
                      style: ToastificationStyle.fillColored,
                      title: Text(
                        'You have successfully created an event.',
                        overflow: TextOverflow.visible,
                      ),
                      autoCloseDuration: const Duration(seconds: 4),
                    );
                  } else {
                    toastification.show(
                      context: context,
                      type: ToastificationType.error,
                      style: ToastificationStyle.fillColored,
                      title: Text(
                        'Please fill all fields before adding an event.',
                        overflow: TextOverflow.visible,
                      ),
                      autoCloseDuration: const Duration(seconds: 4),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Color(0XFF518E99),
                  ),
                  child: Center(
                    child: Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
