import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/models/event.dart';
import 'package:project/screens/home/organizer/attendees_screen.dart';
import 'package:project/screens/home/organizer/create_event.dart';
import 'package:project/utils/show_toast.dart';
import 'package:project/widgets/amount_text.dart';
import 'package:project/widgets/details_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/services/database_service.dart';
import 'package:toastification/toastification.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  double totalCommission = 0;
  int eventsCreated = 0;
  int ticketsSold = 0;
  List<EventModel> liveEvents = [];
  bool isLoading = true;

  final DatabaseService _databaseService = DatabaseService();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _loadOrganizerData();
  }

  Future<void> _loadOrganizerData() async {
    try {
      setState(() => isLoading = true);

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final uid = userProvider.user!.uid;

      final stats = await _databaseService.fetchOrganizerStats(uid);
      final todayEvents = await _databaseService.fetchEventsToday();

      setState(() {
        totalCommission = (stats['totalCommission'] as num).toDouble();
        eventsCreated = stats['totalEventsCreated'];
        ticketsSold = stats['ticketsSold'];
        liveEvents = todayEvents;

        isLoading = false;
      });
    } catch (e) {
      String errorMessage = 'Something went wrong. Please try again.';

      if (e.toString().contains('SocketException')) {
        errorMessage = 'No internet connection. Please check your network.';
      }

      if (mounted) {
        showToast(errorMessage, ToastificationType.error, context);
        setState(() => isLoading = false);
      }
    } finally {
      _refreshController.refreshCompleted();
    }
  }

  void _onRefresh() async {
    await _loadOrganizerData();
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
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.black,
                size: 30.sp,
              ),
            )
          : SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              header: CustomHeader(
                builder: (context, mode) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.black,
                      size: 30.sp,
                    ),
                  );
                },
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                            title: 'Total Commissions',
                            value:
                                '₦${NumberFormat("#,##0.00").format(totalCommission)}',
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
                                title: 'Tickets Sold',
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    liveEvents.isEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.h),
                            child: Center(
                              child: Text(
                                'No events today',
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
                                        image: DecorationImage(
                                          image: NetworkImage(event.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                    ),
                                    title: Text(
                                      '${event.eventName} \nLocation: ${event.location}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${DateFormat.yMEd().add_jms().format(event.date)}'
                                      '\nNumber of Tickets: ${event.totalTickets}'
                                      '\nAvailable Tickets: ${event.availableTickets}',
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
            onTap: () {},
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
