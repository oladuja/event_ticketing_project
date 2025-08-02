import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:project/models/event.dart';
import 'package:project/models/user.dart';
import 'package:project/providers/ticket_notifier.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/database_service.dart';
import 'package:provider/provider.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key, required this.tag, required this.event});

  final dynamic tag;
  final EventModel event;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  String selectedTicket = '';
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    if (widget.event.ticketsType.isNotEmpty) {
      selectedTicket = widget.event.ticketsType.first['name'] ?? '';
    }
  }

  double _getPriceForSelectedTicket() {
    final ticket = widget.event.ticketsType.firstWhere(
      (t) => t['name'] == selectedTicket,
      orElse: () => {'price': 0},
    );
    return double.tryParse(ticket['price'].toString()) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    final price = _getPriceForSelectedTicket();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
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
                    borderRadius: BorderRadius.circular(15.r),
                    image: DecorationImage(
                      image: NetworkImage(widget.event.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Gap(15.h),
              Text(
                widget.event.eventName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              Gap(5.h),
              Text(
                'Category - ${widget.event.category}',
                style: TextStyle(fontSize: 14.sp, color: Colors.black54),
              ),
              Gap(5.h),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.calendar, size: 16.sp),
                  Gap(8.w),
                  Text(
                    DateFormat.yMEd().add_jms().format(widget.event.date),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Gap(5.h),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.locationPin, size: 16.sp),
                  Gap(8.w),
                  Text(
                    widget.event.location,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Gap(10.h),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.ticket, size: 16.sp),
                  Gap(8.w),
                  Text(
                    '${widget.event.availableTickets} Ticket(s) Left',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Gap(10.h),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.userGroup, size: 16.sp),
                  Gap(8.w),
                  FutureBuilder<UserModel?>(
                    future: DatabaseService()
                        .getOrganizerById(widget.event.organizerId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return Container();
                      } else {
                        final organizer = snapshot.data!;
                        return Text("Organized by: ${organizer.name}");
                      }
                    },
                  )
                ],
              ),
              Gap(10.h),
              Wrap(
                spacing: 8.h,
                children: widget.event.ticketsType.map<Widget>((ticket) {
                  final name = ticket['name'];
                  return ChoiceChip(
                    selectedColor:
                        const Color(0xFF518E99).withAlpha((0.3 * 255).toInt()),
                    label: Text(name),
                    selected: selectedTicket == name,
                    onSelected: (_) {
                      setState(() {
                        selectedTicket = name;
                      });
                    },
                  );
                }).toList(),
              ),
              Gap(10.h),
              Text(
                '₦${price.toStringAsFixed(2)}',
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
                          icon: FaIcon(FontAwesomeIcons.minus, size: 16.sp),
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() => quantity--);
                            }
                          },
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.plus, size: 16.sp),
                          onPressed: () {
                            setState(() => quantity++);
                          },
                        ),
                      ],
                    ),
                  ),
                  Gap(10.w),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final Customer customer = Customer(
                          name: user.user!.name,
                          phoneNumber: user.user!.phoneNumber,
                          email: user.user!.email,
                        );

                        final Flutterwave flutterwave = Flutterwave(
                          publicKey:
                              "FLWPUBK_TEST-8248fd5f2c301eed1e7ddc771d83a43d-X",
                          currency: "NGN",
                          redirectUrl: "https://google.com",
                          txRef: DateTime.now().toIso8601String(),
                          amount: (price * quantity).toStringAsFixed(2),
                          customer: customer,
                          paymentOptions: "card",
                          customization: Customization(
                            title: 'Pay Now',
                            description: 'Pay Now',
                          ),
                          isTestMode: true,
                        );

                        final ChargeResponse response =
                            await flutterwave.charge(context);
                        if (response.status == 'successful') {
                          await DatabaseService().handleSuccessfulPurchase(
                            event: widget.event,
                            ticketsBought: quantity,
                            ticketPrice: price,
                            buyerId: AuthService().currentUser!.uid,
                            ticketType: selectedTicket,
                            organizerName: user.user!.name,
                          );
                        }
                        if (context.mounted) {
                          Provider.of<TicketNotifier>(context, listen: false)
                              .triggerRefresh();
                        }
                      } catch (e) {}
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
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
                widget.event.description,
                style: TextStyle(fontSize: 14.sp),
                textAlign: TextAlign.justify,
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
