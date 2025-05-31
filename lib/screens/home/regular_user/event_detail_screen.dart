import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends StatefulWidget {
  static String routeName = 'event_details_screen';
  const EventDetailScreen({super.key, required this.tag});

  final dynamic tag;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final Map<String, int> ticketPrices = {
    'Regular': 2000,
    'VIP': 2500,
    'VVIP': 3000,
    'TF2': 3500,
    'TF8': 4000,
    'TF12': 4000,
  };

  String selectedTicket = 'Regular';
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.tag,
                child: Container(
                  width: double.infinity,
                  height: 200.h,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15.r)
                      // image: DecorationImage(image: AssetImage())
                      ),
                ),
              ),
              Gap(15.h),
              Text(
                'Made for more Conference',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              Gap(5.h),
              Text(
                'Category - Technology',
                style: TextStyle(fontSize: 14.sp, color: Colors.black54),
              ),
              Gap(5.h),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.calendar,
                    size: 16.sp,
                  ),
                  Gap(8.w),
                  Text(
                    DateFormat.yMEd().add_jms().format(DateTime.now()),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Gap(5.h),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.locationPin,
                    size: 16.sp,
                  ),
                  Gap(8.w),
                  Text(
                    'FUTA North Gate, Nigeria',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Gap(10.h),
              Wrap(
                spacing: 8.h,
                children: ticketPrices.keys.map((ticket) {
                  return ChoiceChip(
                    selectedColor: Color(0XFF518E99).withOpacity(0.3),
                    label: Text(ticket),
                    selected: selectedTicket == ticket,
                    onSelected: (_) {
                      setState(() {
                        selectedTicket = ticket;
                      });
                    },
                  );
                }).toList(),
              ),
              Gap(10.h),
              Text(
                '₦${ticketPrices[selectedTicket]!.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              Gap(8.h),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.minus,
                            size: 16.sp,
                          ),
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                        IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.plus,
                            size: 16.sp,
                          ),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Gap(10.w),
                  ElevatedButton(
                    onPressed: () {
                      // final total = ticketPrices[selectedTicket]! * quantity;
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //       content: Text(
                      //           'Buying $quantity x $selectedTicket for ₦$total')),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Gap(10.h),
              Text(
                'Event Description',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(5.h),
              Text(
                'Lorem Ipsum is simply dummy text of the printing  typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop software like Aldus PageMaker including versions of Lorem Ipsum.',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
