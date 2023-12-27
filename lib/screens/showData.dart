import 'package:flutter/material.dart';
import 'package:flutter_assignment/data/Storedata.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "About Loan ",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
        ),
        body: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: Storedata.qustions!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${index + 1}. ${Storedata.qustions![index]}",
                          style: GoogleFonts.poppins(
                              textStyle:
                                  const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          "Answer :-${Storedata.asnwer![index]}",  style: GoogleFonts.poppins(
                              textStyle:
                                  const TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
