import 'package:flutter/material.dart';
import 'package:ipop_tracker/config/colors.dart';
import 'package:ipop_tracker/model/leave.dart';
import 'package:ipop_tracker/services/api_clint.dart';

import '../../widgets/circuler.dart';

class PastLeave extends StatefulWidget {
  const PastLeave({super.key});

  @override
  State<PastLeave> createState() => _PastLeaveState();
}

class _PastLeaveState extends State<PastLeave> {
  late Future<LeaveModel> leaveData;
  final String leaveType = 'Past';

  @override
  void initState() {
    super.initState();
    leaveData = ApiClient().getLeaveData(leaveType);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LeaveModel>(
      future: leaveData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: MyCircularIndicator(
            color: tsecondaryColor,
          ));
        } else if (snapshot.hasError) {
          debugPrint('Error: ${snapshot.error}');
          return const Center(child: Text('Something went wrong'));
        } else if (snapshot.hasData && snapshot.data!.data.isNotEmpty) {
          final leaveModel = snapshot.data!;
          return ListView.builder(
            itemCount: leaveModel.data.length,
            itemBuilder: (context, index) {
              final leave = leaveModel.data[index];
              final isApproved = leave.leaveStatus == "Approved";
              final isRejected = leave.leaveStatus == "Rejected";

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xFFE3EBF5), width: 1.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Date'),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 8),
                          decoration: BoxDecoration(
                            color: isApproved
                                ? const Color(0xFFF0F9FF)
                                : isRejected
                                    ? const Color(0xFFFEF8F8)
                                    : const Color(0xFFF0F9FF),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            leave.leaveStatus ?? '',
                            style: TextStyle(
                              color: isApproved
                                  ? tBorderGreenColor
                                  : isRejected
                                      ? tBorRedColor
                                      : tBorBlueColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${leave.startDate?.replaceAll('-', '/')} : ${leave.endDate?.replaceAll('-', '/')}',
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Apply Days'),
                        Text('Leave Balance'),
                        Text('Approved By'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leave.applyDay.toString(),
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          '0',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          leave.approvedBy ?? '--:--',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (isRejected) ...[
                      const Center(
                        child: SizedBox(
                          width: 120,
                          child: Divider(
                            color: tContainerColor,
                            thickness: 1.5,
                          ),
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Reason :',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: tsecondaryColor,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            leave.cancelReason ?? '',
                            maxLines: 2,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}
