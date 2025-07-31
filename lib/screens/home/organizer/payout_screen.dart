import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/widgets/amount_text.dart';
import 'package:project/widgets/auth_button.dart';
import 'package:provider/provider.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/services/database_service.dart';
import 'package:toastification/toastification.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:project/utils/show_toast.dart';

class PayoutScreen extends StatefulWidget {
  const PayoutScreen({super.key});

  @override
  State<PayoutScreen> createState() => _PayoutScreenState();
}

class _PayoutScreenState extends State<PayoutScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  double totalCommission = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBalance();
  }

  Future<void> _fetchBalance() async {
    try {
      setState(() => isLoading = true);

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final uid = userProvider.user!.uid;

      final stats = await _databaseService.fetchOrganizerStats(uid);
      setState(() {
        totalCommission = (stats['totalCommission'] as num).toDouble();
      });
    } catch (e) {
      String errorMessage = 'Failed to load balance. Please try again.';
      if (e.toString().contains('SocketException')) {
        errorMessage = 'No internet connection.';
      }

      if (mounted) {
        showToast(errorMessage, ToastificationType.error, context);
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
        _refreshController.refreshCompleted();
      }
    }
  }

  void _onRefresh() async {
    await _fetchBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SmartRefresher(
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(15.h),
                Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.all(8.w),
                  child: isLoading
                      ? Text('Loading balance...')
                      : AmountText(
                          title: 'Your Total Earning',
                          value:
                              '₦${NumberFormat("#,##0.00").format(totalCommission)}',
                        ),
                ),
                Gap(20.h),
                Text(
                  'History',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                Gap(10.h),
                Text('No recent payout history available.'),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AuthButton(
          text: 'Request',
          onPressed: () => showToast(
            'Payout request not available yet.',
            ToastificationType.info,
            context,
          ),
        ),
      ),
    );
  }
}
