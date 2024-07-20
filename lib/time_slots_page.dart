import 'package:flutter/material.dart';

class TimeSlotsPage extends StatefulWidget {
  final DateTime selectedDate;

  TimeSlotsPage({required this.selectedDate});

  @override
  _TimeSlotsPageState createState() => _TimeSlotsPageState();
}

class _TimeSlotsPageState extends State<TimeSlotsPage> {
  String? selectedSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        title: Text(
          'Time Slots',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a Time Slot',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            _buildTimeSlot('Morning (9:00 AM - 12:00 PM)'),
            SizedBox(height: 10),
            _buildTimeSlot('Afternoon (1:00 PM - 4:00 PM)'),
            SizedBox(height: 10),
            _buildTimeSlot('Evening (5:00 PM - 8:00 PM)'),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6C5DD4),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (selectedSlot != null) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _showConfirmationSnackbar(context);
                    });
                  }
                },
                child: Text(
                  'Proceed',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlot(String timeSlot) {
    final isSelected = selectedSlot == timeSlot;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSlot = timeSlot; // Update selected slot
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF6C5DD4) : Colors.white,
          border: Border.all(color: Color(0xFF6C5DD4)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(15),
        child: Center(
          child: Text(
            timeSlot,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

void _showConfirmationSnackbar(BuildContext context) {
  final snackBar = SnackBar(
    backgroundColor: Colors.white,
   shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20), // Set the top left corner radius
        topRight: Radius.circular(20), // Set the top right corner radius
      ),
    ), // Set the background color to white
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Text(
            'Your Appointment has been confirmed',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Set text color to black
          ),
        ),
        SizedBox(height: 15),
        DoctorListItem(),
        SizedBox(height: 25),
        Text(
          'Time Slot: $selectedSlot',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Set text color to black
        ),
      ],
    ),
    action: SnackBarAction(
      label: 'X',
      textColor: Colors.black, // Set action text color to black
      onPressed: () {
        // Dismiss the snackbar
      },
    ),
    duration: Duration(seconds: 10),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
}

class DoctorListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.049,
            backgroundImage: AssetImage('assets/avatar1.png'),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Dr. Aditi Sharma',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontFamily: 'Nunito',
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  'Wilora NT 082, Australia',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontFamily: 'Nunito',
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.015),
        
        ],
      ),
    );
  }
}