import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:project/widgets/event_details_textfield.dart';
import 'package:toastification/toastification.dart';
import 'package:image_picker/image_picker.dart';

class CreateEvent extends StatefulWidget {
  static String routeName = '/create_event';

  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();
  final TextEditingController eventAddressController = TextEditingController();
  File? _eventImage;

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

  final List<Map<String, TextEditingController>> tickets = [];

  void addTicketField() {
    setState(() {
      tickets.add({
        'name': TextEditingController(),
        'price': TextEditingController(),
      });
    });
  }

  void removeTicketField(int index) {
    setState(() {
      tickets.removeAt(index);
    });
  }

  String? selectedEventType;
  String? selectedCategory;
  DateTime? _selectedDateTime;

  Future<void> pickEventImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _eventImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Create Event',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(25.h),
                  Text(
                    'Event Image',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(5),
                  GestureDetector(
                    onTap: pickEventImage,
                    child: Container(
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0XFF828282),
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(5.r),
                        image: _eventImage != null
                            ? DecorationImage(
                                image: FileImage(_eventImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _eventImage == null
                          ? Center(
                              child: Text(
                                'Select Event Image',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.sp,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tickets',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: addTicketField,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    ),
                    child:
                        Text('Add new', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              Gap(10.h),
              ...List.generate(tickets.length, (index) {
                final ticket = tickets[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: ticket['name'],
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: 'Ticket Name',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.w,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.w),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          controller: ticket['price'],
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: '₦0.00',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.w,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.w),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.black),
                        onPressed: () => removeTicketField(index),
                      ),
                    ],
                  ),
                );
              }),
              Gap(20.h),
              GestureDetector(
                onTap: () {
                  final hasValidTickets = tickets.isNotEmpty &&
                      tickets.every((ticket) =>
                          ticket['name']!.text.isNotEmpty &&
                          ticket['price']!.text.isNotEmpty);

                  if (eventNameController.text.isNotEmpty &&
                      eventDescriptionController.text.isNotEmpty &&
                      eventAddressController.text.isNotEmpty &&
                      selectedEventType != null &&
                      _selectedDateTime != null &&
                      selectedCategory != null &&
                      _eventImage != null &&
                      hasValidTickets) {
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
                      'Add Event',
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
