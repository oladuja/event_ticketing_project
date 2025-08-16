import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:project/models/event.dart';
import 'package:project/providers/state_notifier.dart';
import 'package:project/services/database_service.dart';
import 'package:project/utils/format_date.dart';
import 'package:project/utils/show_toast.dart';
import 'package:project/widgets/event_details_textfield.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class EditEvent extends StatefulWidget {
  final EventModel event;

  const EditEvent({super.key, required this.event});

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
  void initState() {
    super.initState();

    final event = widget.event;
    eventNameController.text = event.eventName;
    eventDescriptionController.text = event.description;
    eventAddressController.text = 'event.location';
    selectedEventType = event.eventType;
    selectedCategory = event.category;
    _selectedDateTime = event.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Edit Event',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                child: DropdownButtonFormField<String>(
                  value: selectedEventType,
                  items: eventTypes
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedEventType = value;
                    });
                  },
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              EventDetailsField(
                title: 'Event Name',
                child: TextField(
                  controller: eventNameController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              EventDetailsField(
                title: 'Event Date & Time',
                child: GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDateTime ?? DateTime.now(),
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
                              ? formatDate(_selectedDateTime!)
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
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              EventDetailsField(
                title: 'Category',
                child: DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: categories
                      .map((cat) =>
                          DropdownMenuItem(value: cat, child: Text(cat)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              EventDetailsField(
                title: 'Event Address',
                child: TextField(
                  controller: eventAddressController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              Gap(20.h),
              GestureDetector(
                onTap: () async {
                  if (eventNameController.text.isNotEmpty &&
                      eventDescriptionController.text.isNotEmpty &&
                      eventAddressController.text.isNotEmpty &&
                      selectedEventType != null &&
                      _selectedDateTime != null &&
                      selectedCategory != null) {
                    final updatedEvent = widget.event.copyWith(
                      eventName: eventNameController.text.trim(),
                      description: eventDescriptionController.text.trim(),
                      location: [],
                      eventType: selectedEventType!,
                      category: selectedCategory!,
                      date: _selectedDateTime!,
                    );

                    try {
                      await DatabaseService()
                          .updateEventInDatabase(updatedEvent);
                      if (context.mounted) {
                        Provider.of<StateNotifier>(context, listen: false)
                            .triggerRefresh();
                      }
                      if (context.mounted) {
                        Navigator.of(context).pop(true);
                        showToast(
                          'Event updated successfully!',
                          ToastificationType.success,
                          context,
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        showToast(
                          'Failed to update event.',
                          ToastificationType.error,
                          context,
                        );
                      }
                    }
                  } else {
                    showToast(
                      'Please fill all fields before updating the event.',
                      ToastificationType.error,
                      context,
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.black,
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
