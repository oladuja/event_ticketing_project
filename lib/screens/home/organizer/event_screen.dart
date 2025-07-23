import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/models/event.dart';
import 'package:project/screens/home/organizer/attendees_screen.dart';
import 'package:project/screens/home/organizer/edit_event_screen.dart';
import 'package:project/services/database_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EventScreen extends StatefulWidget {
  static String routeName = '/event_screen';
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen>
    with AutomaticKeepAliveClientMixin {
  final DatabaseService _databaseService = DatabaseService();

  List<EventModel> _events = [];
  bool _loading = true;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    setState(() => _loading = true);
    try {
      final events = await _databaseService.fetchEvents();
      setState(() {
        _events = events;
      });
    } finally {
      setState(() => _loading = false);
      _refreshController.refreshCompleted();
    }
  }

  void _onRefresh() async {
    await _loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Events', style: TextStyle(fontWeight: FontWeight.bold)),
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
              child: _events.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("No events available."),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _events.length,
                      itemBuilder: (context, index) {
                        final event = _events[index];
                        return _buildEventTile(event);
                      },
                    ),
            ),
    );
  }

  Widget _buildEventTile(EventModel event) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AttendeesScreen()),
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
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          title: Text(
            '${event.eventName} \nLocation: ${event.location}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          subtitle: Text(
            '${DateFormat.yMEd().add_jms().format(
                  DateTime.parse(
                    event.date.toIso8601String(),
                  ),
                )}\nNumber of Tickets: ${event.totalTickets}\nAvailable Tickets: ${event.availableTickets}',
            style: TextStyle(fontSize: 12.sp),
          ),
          trailing: PopupMenuButton<String>(
            color: Colors.white,
            icon: const FaIcon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              if (value == 'edit') {
                Navigator.of(context).pushNamed(EditEvent.routeName);
              } else if (value == 'delete') {
                // Handle delete action
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ),
      ),
    );
  }
}
