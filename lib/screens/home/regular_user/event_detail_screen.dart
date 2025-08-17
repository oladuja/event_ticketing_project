import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:project/models/event.dart';
import 'package:project/models/user.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/database_service.dart';
import 'package:project/utils/amount_format.dart';
import 'package:project/utils/format_date.dart';
import 'package:project/utils/show_toast.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key, required this.tag, required this.event});

  final dynamic tag;
  final EventModel event;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  String selectedTicket = '';
  String selectedLocationId = '';
  int quantity = 1;
  UserModel? organizer;
  bool isLoadingOrganizer = true;

  @override
  void initState() {
    super.initState();
    if (widget.event.ticketsType.isNotEmpty) {
      selectedTicket = widget.event.ticketsType.first['name'] ?? '';
    }
    _loadOrganizer();
  }

  Future<void> _loadOrganizer() async {
    try {
      final organizerData =
          await DatabaseService().getOrganizerById(widget.event.organizerId);
      if (mounted) {
        setState(() {
          organizer = organizerData;
          isLoadingOrganizer = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoadingOrganizer = false;
        });
      }
    }
  }

  double _getPriceForSelectedTicket() {
    final ticket = widget.event.ticketsType.firstWhere(
      (t) => t['name'] == selectedTicket,
      orElse: () => {'price': 0},
    );
    return double.tryParse(ticket['price'].toString()) ?? 0;
  }

  Map<String, dynamic>? _getSelectedLocation() {
    if (selectedLocationId.isEmpty) return null;
    return widget.event.location.firstWhere(
      (loc) => loc['placeId'] == selectedLocationId,
      orElse: () => {},
    );
  }

  int _getAvailableTicketsForLocation() {
    final location = _getSelectedLocation();
    if (location == null) return 0;
    return location['ticketCount'] ?? 0;
  }

  bool _canPurchase() {
    return selectedLocationId.isNotEmpty &&
        _getAvailableTicketsForLocation() >= quantity &&
        widget.event.ticketsType.isNotEmpty &&
        selectedTicket.isNotEmpty &&
        widget.event.availableTickets > 0;
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
                    formatDate(widget.event.date),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Gap(5.h),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.ticket, size: 16.sp),
                  Gap(8.w),
                  Text(
                    '${widget.event.availableTickets} Total Ticket(s) Left',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Gap(10.h),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.userGroup, size: 16.sp),
                  Gap(8.w),
                  if (isLoadingOrganizer)
                    SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.grey.shade600),
                      ),
                    )
                  else if (organizer != null)
                    Text("Organized by: ${organizer!.name}")
                  else
                    Text(
                      "Organizer information unavailable",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                ],
              ),
              Gap(15.h),

              // Locations Section
              Text(
                'Select Location',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(8.h),

              if (widget.event.location.isEmpty)
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    'No locations available for this event',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                )
              else
                ...widget.event.location.map<Widget>((location) {
                  final isSelected = selectedLocationId == location['placeId'];
                  final ticketCount = location['ticketCount'] ?? 0;

                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF518E99)
                            : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: ListTile(
                      title: Text(
                        location['name'] ?? 'Unknown Location',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location['address'] ?? '',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          Text(
                            '$ticketCount tickets available',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color:
                                  ticketCount > 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      selected: isSelected,
                      selectedTileColor: const Color(0xFF518E99)
                          .withAlpha((0.1 * 255).toInt()),
                      onTap: ticketCount > 0
                          ? () {
                              setState(() {
                                selectedLocationId = location['placeId'];
                                // Reset quantity if it exceeds available tickets
                                if (quantity > ticketCount) {
                                  quantity = ticketCount;
                                }
                              });
                            }
                          : null,
                      enabled: ticketCount > 0,
                    ),
                  );
                }),

              Gap(15.h),

              Text(
                'Select Ticket Type',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(8.h),
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
                formatCurrency(price),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              Gap(8.h),

              // Quantity and Purchase Section
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
                            final maxTickets =
                                _getAvailableTicketsForLocation();
                            if (quantity < maxTickets) {
                              setState(() => quantity++);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Gap(10.w),
                  ElevatedButton(
                    onPressed: _canPurchase()
                        ? () async {
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
                                final selectedLocation =
                                    _getSelectedLocation()!;
                                await DatabaseService()
                                    .handleSuccessfulPurchase(
                                  event: widget.event,
                                  ticketsBought: quantity,
                                  ticketPrice: price,
                                  location: selectedLocation['address'],
                                  locationId: selectedLocationId,
                                  buyerId: AuthService().currentUser!.uid,
                                  ticketType: selectedTicket,
                                );

                                if (context.mounted) {
                                  showToast('Tickets purchased successfully!',
                                      ToastificationType.success, context);
                                  // Provider.of<StateNotifier>(context,
                                  //         listen: false)
                                  //     .triggerRefresh();
                                  Navigator.pop(context, true);
                                }
                              } else {
                                if (context.mounted) {
                                  showToast(
                                      'Payment was not successful. Please try again.',
                                      ToastificationType.error,
                                      context);
                                }
                              }
                            } catch (e) {
                              if (!context.mounted) return;

                              String errorMessage =
                                  'An error occurred while processing payment';
                              if (e.toString().contains(
                                  'Tickets are no longer available')) {
                                errorMessage =
                                    'Sorry, these tickets are no longer available. Please refresh and try again.';
                              } else if (e
                                  .toString()
                                  .contains('No tickets available')) {
                                errorMessage =
                                    'No tickets available for this event or location.';
                              }

                              showToast(errorMessage, ToastificationType.error,
                                  context);
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _canPurchase() ? Colors.black : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _canPurchase()
                          ? 'Buy Now (${formatCurrency(price * quantity)})'
                          : selectedLocationId.isEmpty
                              ? 'Select Location'
                              : 'Not Available',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),

              if (selectedLocationId.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    'Available at selected location: ${_getAvailableTicketsForLocation()} tickets',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.green,
                    ),
                  ),
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
