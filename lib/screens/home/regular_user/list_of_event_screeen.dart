import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:project/models/event.dart';
import 'package:project/screens/home/regular_user/event_detail_screen.dart';
import 'package:project/services/database_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ListOfEventScreeen extends StatefulWidget {
  static String routeName = '/list_of_event_screen';
  const ListOfEventScreeen({super.key});

  @override
  State<ListOfEventScreeen> createState() => _ListOfEventScreeenState();
}

class _ListOfEventScreeenState extends State<ListOfEventScreeen>
    with AutomaticKeepAliveClientMixin {
  final DatabaseService _databaseService = DatabaseService();
  List<EventModel> _events = [];
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    setState(() => _loading = true);
    try {
      final events = await _databaseService.fetchEvents();
      events.sort((a, b) => a.date.compareTo(b.date));
      setState(() => _events = events);
    } catch (e) {
      debugPrint('Error fetching events: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _onRefresh() async {
    await _fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Available Events',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: _loading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.black,
                size: 30.sp,
              ),
            )
          : RefreshIndicator(
              onRefresh: _onRefresh,
              child: _events.isEmpty
                  ? ListView(
                      children: [
                        SizedBox(height: 100.h),
                        Center(
                          child: Text(
                            "No events available.",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: _events.length,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      itemBuilder: (context, index) {
                        final event = _events[index];
                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EventDetailScreen(
                                  event: event, tag: event.id),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: ListTile(
                              leading: Hero(
                                tag: event.id,
                                child: Container(
                                  width: 50.h,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    image: event.imageUrl.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(event.imageUrl),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                              title: Text(
                                '${event.eventName}\nLocation: ${event.location}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              subtitle: Text(
                                '${DateFormat.yMEd().add_jms().format(event.date)}\n'
                                'Price: ₦${event.ticketsType.isNotEmpty ? event.ticketsType.first["price"] : "N/A"}\n'
                                '${event.availableTickets} Ticket(s) Left',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
