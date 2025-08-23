import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AwesomeTimeDate extends StatelessWidget {
  final DateTime now;
  const AwesomeTimeDate({Key? key, required this.now}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format time and date
    final String timeString = DateFormat('hh:mm a').format(now);
    final String dateString = DateFormat('EEEE, MMMM d, yyyy').format(now);

    // Pick icon depending on time
    final int hour = now.hour;
    final bool isDay = hour >= 6 && hour < 18;
    final IconData icon = isDay ? Icons.wb_sunny_rounded : Icons.nightlight_round_rounded;
    final Color iconColor = isDay ? Colors.amber.shade600 : Colors.blueGrey.shade300;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isDay ? Colors.orange.shade400 : Colors.blueGrey.shade400,
            width: 1,
          ),
          gradient: LinearGradient(
            colors: isDay
                ? [Colors.yellow.shade200, Colors.orange.shade200, Colors.white]
                : [Colors.indigo.shade900, Colors.blueGrey.shade900, Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDay ? Colors.yellow[50] : Colors.indigo[800],
                boxShadow: [
                  BoxShadow(
                    color: iconColor.withOpacity(0.18),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Icon(
                  icon,
                  size: 44,
                  color: iconColor,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Time',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    timeString,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 5,
                          offset: const Offset(1, 2),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    dateString,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}