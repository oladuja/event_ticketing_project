import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/widgets/event_details_textfield.dart';

class CreateEvent extends StatelessWidget {
  static String routeName = '/create_event';

  const CreateEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              EventDetailsField(
                title: 'Event Type',
                child: DropdownButtonFormField(
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('data'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('data1'),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('data21'),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Text('data121'),
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
                title: 'Event Description',
                child: TextField(
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
                    DropdownMenuItem(
                      value: 1,
                      child: Text('data'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('data1'),
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
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
