import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/models/event.dart';
import 'package:project/screens/home/organizer/attendees_screen.dart';
import 'package:project/screens/home/organizer/edit_event_screen.dart';
import 'package:project/services/database_service.dart';
import 'package:project/utils/show_toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toastification/toastification.dart';

class EventScreen extends StatefulWidget {
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
      onTap: () async {
        final attendees = await _databaseService.fetchEventAttendees(event.id);
        if (!mounted) return;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AttendeesScreen(attendees: attendees),
          ),
        );
      },
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
            onSelected: (value) async {
              if (value == 'edit') {
                final shouldRefresh = await Navigator.of(context).push<bool>(
                  MaterialPageRoute(
                    builder: (_) => EditEvent(event: event),
                  ),
                );

                if (shouldRefresh == true) {
                  _loadEvents();
                }
              } else if (value == 'delete') {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Event'),
                    content: const Text(
                        'Are you sure you want to delete this event?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  try {
                    await _databaseService.deleteEventFromDatabase(event.id);
                    setState(() {
                      _events.removeWhere((e) => e.id == event.id);
                    });
                    if (!mounted) return;

                    showToast('Event deleted successfully',
                        ToastificationType.success, context);
                  } catch (e) {
                    if (!mounted) return;

                    showToast('Failed to delete event',
                        ToastificationType.error, context);
                  }
                }
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
