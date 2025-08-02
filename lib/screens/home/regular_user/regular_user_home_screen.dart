import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/models/ticket.dart';
import 'package:project/providers/ticket_notifier.dart';
import 'package:project/screens/home/regular_user/ticket_details_screen.dart';
import 'package:project/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegularHomeScreen extends StatefulWidget {

  const RegularHomeScreen({super.key});

  @override
  State<RegularHomeScreen> createState() => _RegularHomeScreenState();
}

class _RegularHomeScreenState extends State<RegularHomeScreen>
    with AutomaticKeepAliveClientMixin {
  final DatabaseService _databaseService = DatabaseService();
  final RefreshController _refreshController = RefreshController();

  List<TicketModel> _tickets = [];
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _fetchTickets();
  }

  Future<void> _fetchTickets() async {
    setState(() => _loading = true);
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception('User not logged in');

      final tickets = await _databaseService.fetchUserTickets(uid);
      setState(() => _tickets = tickets);
    } catch (e) {
      
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _onRefresh() async {
    await _fetchTickets();
    _refreshController.refreshCompleted();
  }

  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  final ticketNotifier = Provider.of<TicketNotifier>(context);
  if (ticketNotifier.shouldRefresh) {
    _fetchTickets();
    ticketNotifier.resetRefreshFlag(); 
  }
}

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Tickets',
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
                builder: (context, mode) => Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black,
                    size: 30.sp,
                  ),
                ),
              ),
              child: _tickets.isEmpty
                  ? ListView(
                      children: [
                        SizedBox(height: 100.h),
                        Center(
                          child: Text(
                            "You don't have any tickets yet.",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: _tickets.length,
                      itemBuilder: (context, index) {
                        final ticket = _tickets[index];
                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TicketDetailsScreen(ticket: ticket),
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
                                    image: NetworkImage(ticket.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              title: Text(
                                '${ticket.eventName}\nLocation: ${ticket.location}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              trailing: Text('Ticket Type: \n${ticket.ticketType}'),
                              subtitle: Text(
                                'Date Purchased: ${DateFormat.yMEd().add_jms().format(ticket.datePurchased)}',
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
