import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/models/event.dart';
import 'package:project/screens/home/regular_user/event_detail_screen.dart';
import 'package:project/services/database_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/utils/format_date.dart';
import 'package:project/utils/show_toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toastification/toastification.dart';

class ListOfEventScreeen extends StatefulWidget {
  const ListOfEventScreeen({super.key});

  @override
  State<ListOfEventScreeen> createState() => _ListOfEventScreeenState();
}

class _ListOfEventScreeenState extends State<ListOfEventScreeen>
    with AutomaticKeepAliveClientMixin {
  final DatabaseService _databaseService = DatabaseService();
  final RefreshController _refreshController = RefreshController();

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
      final events = await _databaseService.fetchUpcomingEvents();
      setState(() => _events = events);
    } catch (e) {
      if (!mounted) return;
      showToast(
        'Failed to load events.',
        ToastificationType.error,
        context,
      );
    } finally {
      setState(() => _loading = false);
      _refreshController.refreshCompleted();
    }
  }

  Future<void> _onRefresh() async {
    await _fetchEvents();
    _refreshController.refreshCompleted();
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
                          onTap: () async {
                            final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EventDetailScreen(
                                    event: event, tag: event.id),
                              ),
                            );

                            if (result == true) {
                              _fetchEvents();
                            }
                          },
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
                                event.eventName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              subtitle: Text(
                                '${formatDate(event.date)}\n'
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
