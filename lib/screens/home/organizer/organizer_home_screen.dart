import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/screens/home/organizer/attendees_screen.dart';
import 'package:project/screens/home/organizer/create_event.dart';
import 'package:project/widgets/amount_text.dart';
import 'package:project/widgets/details_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/services/database_service.dart';

class OrganizerHomeScreen extends StatefulWidget {
  static String routeName = '/organizer_home_screen';

  const OrganizerHomeScreen({super.key});

  @override
  State<OrganizerHomeScreen> createState() => _OrganizerHomeScreenState();
}

class _OrganizerHomeScreenState extends State<OrganizerHomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int totalCommission = 0;

  int eventsCreated = 0;
  int ticketsSold = 0;
  List<Map<String, dynamic>> liveEvents = [];
  bool isLoading = true;

  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _loadOrganizerData();
  }

  Future<void> _loadOrganizerData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final uid = userProvider.user!.uid;

    final stats = await _databaseService.fetchOrganizerStats(uid);
    final events = await _databaseService.fetchLiveEvents(uid);

    setState(() {
      totalCommission = stats['totalCommission'];
      eventsCreated = stats['totalEventsCreated'];
      ticketsSold = stats['ticketsSold'];
      liveEvents = events;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome back',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.visible,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: isLoading
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.black,
                  size: 30.sp,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AmountText(
                            title: 'Total Commisions',
                            value:
                                '₦${NumberFormat("#,##0").format(totalCommission)}',
                          ),
                          Gap(20.h),
                          Row(
                            children: [
                              DetailsText(
                                title: 'Events Created',
                                value: eventsCreated.toString(),
                              ),
                              Spacer(),
                              DetailsText(
                                title: 'Ticket Sold',
                                value: ticketsSold.toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gap(30.h),
                    Text(
                      'Today Events',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    liveEvents.isEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.h),
                            child: Center(
                              child: Text(
                                'No events at the moment',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: liveEvents.length,
                            itemBuilder: (context, index) {
                              final event = liveEvents[index];
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => AttendeesScreen(),
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                      width: 50.h,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                    ),
                                    title: Text(
                                      '${event['title']} \nLocation: ${event['location']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${DateFormat.yMEd().add_jms().format(DateTime.parse(event['date']))}'
                                      '\nPrice: ₦${event['price']}'
                                      '\nNumber of Tickets: ${event['totalTickets']}'
                                      '\nAvailable Tickets: ${event['availableTickets']}',
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        foregroundColor: Colors.white,
        animatedIconTheme: IconThemeData(size: 22),
        backgroundColor: Colors.black,
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            shape: CircleBorder(),
            child: FaIcon(FontAwesomeIcons.qrcode, color: Colors.white),
            backgroundColor: Colors.black,
            onTap: (){},
            label: 'Scan QR Code',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16.0,
            ),
            labelShadow: [BoxShadow(color: Colors.transparent)],
            labelBackgroundColor: Colors.transparent,
          ),
          SpeedDialChild(
            shape: CircleBorder(),
            child: FaIcon(FontAwesomeIcons.plus, color: Colors.white),
            backgroundColor: Colors.black,
            onTap: () => Navigator.of(context).pushNamed(CreateEvent.routeName),
            label: 'Create Event',
            labelShadow: [BoxShadow(color: Colors.transparent)],
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16.0,
            ),
            labelBackgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
