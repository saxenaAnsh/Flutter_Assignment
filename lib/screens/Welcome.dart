import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/data/Storedata.dart';
import 'package:flutter_assignment/data/api.dart';
import 'package:flutter_assignment/data/dataModel.dart';
import 'package:flutter_assignment/screens/showData.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_sliders/sliders.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? selectRadio0 = "New purchase";
  String? selectRadio1;
  String? selectRadio2;
  String? selectRadio3;
  String? selectRadio4;
  String? selectRadio5;
  double? valuebar = 2;
  Schema? schema;
  int page = 1;
  int page2 = 1;
  int counter = 4;
  List list = [0, 1, 2, 3, 4, 5, 6];
  List list2 = [0, 1, 2];
  bool isload = true;
  @override
  void initState() {
    getTreatmentPatientList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
      body: isload
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FlutterStepIndicator(
                      height: 25,
                      paddingLine: const EdgeInsets.symmetric(horizontal: 0),
                      positiveColor: const Color(0xFF00B551),
                      // progressColor: const Color(0xFFEA9C00),
                      negativeColor: const Color(0xFFD5D5D5),
                      padding: const EdgeInsets.all(4),
                      list: selectRadio0 == "New purchase" ? list : list2,
                      // division: valuebar!.toInt(),
                      onChange: (i) {},
                      page: selectRadio0 == "New purchase" ? page : page2,
                      onClickItem: (p0) {
                        setState(() {
                          selectRadio0 == "New purchase"
                              ? page = p0
                              : page2 = p0;
                        });
                      },
                    ),
                    // SfSlider(
                    //   dividerShape: SfDividerShape(),
                    //   showDividers: true,
                    //   stepSize: 10,
                    //   min: 2.0,
                    //   max: 10.0,
                    //   value: _value,
                    //   interval: 2,
                    //   showLabels: true,
                    //   onChanged: (dynamic newValue) {
                    //     setState(() {
                    //       _value = newValue;
                    //     });
                    //   },
                    // ),
                    // Slider(

                    //   value: flexorLeft,
                    //   max: 5,
                    //   divisions: 5,
                    //   activeColor: Colors.green,
                    //   label: flexorLeft.round().toString(),
                    //   onChanged: (double value) {
                    //     flexorLeft = value;
                    //   },
                    // ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (page == 1 && page2 != 2)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schema!.fields![0].schema!.label ?? "",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    if (page == 1 && page2 != 2)
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: schema!.fields![0].schema!.options!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                height: screenHeight * 0.08,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: schema!.fields![0].schema!
                                                    .options![index].value ==
                                                selectRadio0
                                            ? Colors.orange
                                            : Colors.black)),
                                child: Row(
                                  children: [
                                    Radio(
                                      value: schema!.fields![0].schema!
                                          .options![index].value,
                                      toggleable: false,
                                      groupValue: selectRadio0,
                                      activeColor: Colors.orange,
                                      onChanged: (val) {
                                        setState(() {
                                          // setState to update the UI
                                          selectRadio0 = val;
                                          debugPrint(selectRadio0);
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      schema!.fields![0].schema!.options![index]
                                              .key ??
                                          "",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600,
                                              color: schema!
                                                          .fields![0]
                                                          .schema!
                                                          .options![index]
                                                          .value ==
                                                      selectRadio0
                                                  ? Colors.orange
                                                  : Colors.black)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    if (page == 2)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schema!.fields![1].schema!.label ?? "",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    if (page == 2)
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: schema!.fields![1].schema!.options!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                height: screenHeight * 0.08,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: schema!.fields![1].schema!
                                                    .options![index].value ==
                                                selectRadio1
                                            ? Colors.orange
                                            : Colors.black)),
                                child: Row(
                                  children: [
                                    Radio(
                                      value: schema!.fields![1].schema!
                                          .options![index].value,
                                      toggleable: false,
                                      groupValue: selectRadio1,
                                      activeColor: Colors.orange,
                                      onChanged: (val) {
                                        setState(() {
                                          // setState to update the UI
                                          selectRadio1 = val;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 0,
                                    ),
                                    Container(
                                      width: screenWidth * 0.8,
                                      child: Text(
                                        schema!.fields![1].schema!
                                                .options![index].value ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600,
                                                color: schema!
                                                            .fields![1]
                                                            .schema!
                                                            .options![index]
                                                            .value ==
                                                        selectRadio1
                                                    ? Colors.orange
                                                    : Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    if (page == 3)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schema!.fields![2].schema!.label ?? "",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    if (page == 3)
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: schema!.fields![2].schema!.fields!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                height: screenHeight * 0.08,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: schema!
                                                    .fields![2]
                                                    .schema!
                                                    .fields![index]
                                                    .schema!
                                                    .label ==
                                                selectRadio2
                                            ? Colors.orange
                                            : Colors.black)),
                                child: Row(
                                  children: [
                                    Radio(
                                      value: schema!.fields![2].schema!
                                          .fields![index].schema!.label,
                                      toggleable: false,
                                      groupValue: selectRadio2,
                                      activeColor: Colors.orange,
                                      onChanged: (val) {
                                        setState(() {
                                          // setState to update the UI
                                          selectRadio2 = val;
                                          print(selectRadio2);
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 0,
                                    ),
                                    Container(
                                      width: screenWidth * 0.8,
                                      child: Text(
                                        schema!.fields![2].schema!
                                                .fields![index].schema!.label ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600,
                                                color: schema!
                                                            .fields![2]
                                                            .schema!
                                                            .fields![index]
                                                            .schema!
                                                            .label ==
                                                        selectRadio2
                                                    ? Colors.orange
                                                    : Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    if (page == 4)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schema!.fields![4].schema!.fields![0].schema!
                                    .label ??
                                "",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    if (page == 4)
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: schema!.fields![4].schema!.fields![0]
                              .schema!.options!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                height: screenHeight * 0.08,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: schema!
                                                    .fields![4]
                                                    .schema!
                                                    .fields![0]
                                                    .schema!
                                                    .options![index]
                                                    .value ==
                                                selectRadio4
                                            ? Colors.orange
                                            : Colors.black)),
                                child: Row(
                                  children: [
                                    Radio(
                                      value: schema!
                                          .fields![4]
                                          .schema!
                                          .fields![0]
                                          .schema!
                                          .options![index]
                                          .value,
                                      toggleable: false,
                                      groupValue: selectRadio4,
                                      activeColor: Colors.orange,
                                      onChanged: (val) {
                                        setState(() {
                                          // setState to update the UI
                                          selectRadio4 = val;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 0,
                                    ),
                                    Container(
                                      width: screenWidth * 0.8,
                                      child: Text(
                                        schema!
                                                .fields![4]
                                                .schema!
                                                .fields![0]
                                                .schema!
                                                .options![index]
                                                .value ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600,
                                                color: schema!
                                                            .fields![4]
                                                            .schema!
                                                            .fields![0]
                                                            .schema!
                                                            .options![index]
                                                            .value ==
                                                        selectRadio4
                                                    ? Colors.orange
                                                    : Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    if (page == 5)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schema!.fields![4].schema!.fields![1].schema!
                                    .label ??
                                "",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    if (page == 5)
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: schema!.fields![4].schema!.fields![1]
                              .schema!.options!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                height: screenHeight * 0.08,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: schema!
                                                    .fields![4]
                                                    .schema!
                                                    .fields![1]
                                                    .schema!
                                                    .options![index]
                                                    .value ==
                                                selectRadio5
                                            ? Colors.orange
                                            : Colors.black)),
                                child: Row(
                                  children: [
                                    Radio(
                                      value: schema!
                                          .fields![4]
                                          .schema!
                                          .fields![1]
                                          .schema!
                                          .options![index]
                                          .value,
                                      toggleable: false,
                                      groupValue: selectRadio5,
                                      activeColor: Colors.orange,
                                      onChanged: (val) {
                                        setState(() {
                                          // setState to update the UI
                                          selectRadio5 = val;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 0,
                                    ),
                                    Container(
                                      width: screenWidth * 0.8,
                                      child: Text(
                                        schema!
                                                .fields![4]
                                                .schema!
                                                .fields![1]
                                                .schema!
                                                .options![index]
                                                .value ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600,
                                                color: schema!
                                                            .fields![4]
                                                            .schema!
                                                            .fields![1]
                                                            .schema!
                                                            .options![index]
                                                            .value ==
                                                        selectRadio5
                                                    ? Colors.orange
                                                    : Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),

                    if (page2 == 2)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schema!.fields![3].schema!.label ?? "",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    if (page2 == 2)
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: schema!.fields![3].schema!.options!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                height: screenHeight * 0.08,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: schema!.fields![3].schema!
                                                    .options![index].value ==
                                                selectRadio3
                                            ? Colors.orange
                                            : Colors.black)),
                                child: Row(
                                  children: [
                                    Radio(
                                      value: schema!.fields![3].schema!
                                          .options![index].value,
                                      toggleable: false,
                                      groupValue: selectRadio3,
                                      activeColor: Colors.orange,
                                      onChanged: (val) {
                                        setState(() {
                                          // setState to update the UI
                                          selectRadio3 = val;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 0,
                                    ),
                                    Container(
                                      width: screenWidth * 0.8,
                                      child: Text(
                                        schema!.fields![3].schema!
                                                .options![index].value ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600,
                                                color: schema!
                                                            .fields![3]
                                                            .schema!
                                                            .options![index]
                                                            .value ==
                                                        selectRadio3
                                                    ? Colors.orange
                                                    : Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (selectRadio0 != "Balance transfer & Top-up" &&
                      valuebar! != 2)
                    page--;
                  else {
                    valuebar = valuebar! - 10;
                  }
                  // if (selectRadio0 == 'Balance transfer & Top-up')
                  //   valuebar = valuebar! - 6;
                  // if (valuebar! != 2) valuebar = valuebar! - 2;
                });
              },
              child: Row(
                children: [
                  if (page != 1)
                    Icon(
                      Icons.arrow_back_ios,
                      size: screenWidth * 0.07,
                    ),
                  if (page != 1)
                    Text(
                      "Back",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (selectRadio0 != "Balance transfer & Top-up") {
                    if (page == 1) {
                      if (selectRadio0 != null && selectRadio0 != '') {
                        setState(() {
                          Storedata.qustions!
                              .add(schema!.fields![0].schema!.label ?? "");
                          Storedata.asnwer!.add(selectRadio0.toString());
                          page++;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Select Any One")));
                      }
                    } else if (page == 2) {
                      if (selectRadio1 != null && selectRadio1 != '') {
                        setState(() {
                          Storedata.qustions!
                              .add(schema!.fields![1].schema!.label ?? "");
                          Storedata.asnwer!.add(selectRadio1.toString());
                          page++;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Select Any One")));
                      }
                    } else if (page == 3) {
                      if (selectRadio2 != null && selectRadio2 != '') {
                        setState(() {
                          Storedata.qustions!
                              .add(schema!.fields![2].schema!.label ?? "");
                          Storedata.asnwer!.add(selectRadio2.toString());
                          page++;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Select Any One")));
                      }
                    } else if (page == 4) {
                      if (selectRadio4 != null && selectRadio4 != '') {
                        setState(() {
                          Storedata.qustions!.add(schema!.fields![4].schema!
                                  .fields![0].schema!.label ??
                              "");
                          Storedata.asnwer!.add(selectRadio4.toString());
                          page++;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Select Any One")));
                      }
                    } else if (page == 5) {
                      if (selectRadio5 != null && selectRadio5 != '') {
                        setState(() {
                          Storedata.qustions!.add(schema!.fields![4].schema!
                                  .fields![1].schema!.label ??
                              "");
                          Storedata.asnwer!.add(selectRadio5.toString());
                          page++;
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ShowData();
                            },
                          ),
                          (route) => true,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Select Any One")));
                      }
                    } else if (page2 == 2) {
                      if (selectRadio3 != null && selectRadio3 != '') {
                        setState(() {
                          Storedata.qustions!
                              .add(schema!.fields![3].schema!.label ?? "");
                          Storedata.asnwer!.add(selectRadio3.toString());
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ShowData();
                            },
                          ),
                          (route) => true,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Select Any One")));
                      }
                    } else {
                      return;
                    }
                  } else {
                    if (page2 == 1) {
                      setState(() {
                        Storedata.qustions!
                            .add(schema!.fields![0].schema!.label ?? "");
                        Storedata.asnwer!.add(selectRadio0.toString());
                        page2++;
                      });
                    } else {
                      if (selectRadio3 != null && selectRadio3 != '') {
                        setState(() {
                          Storedata.qustions!
                              .add(schema!.fields![3].schema!.label ?? "");
                          Storedata.asnwer!.add(selectRadio3.toString());
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ShowData();
                            },
                          ),
                          (route) => true,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Select Any One")));
                      }
                    }
                  }
                  print(valuebar);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30)),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getTreatmentPatientList() async {
    final res = await http.get(
      Uri.parse("${ApiData.ApiUrl}"),
    );
    final int statuscode = res.statusCode;
    print(res.statusCode);
    if (statuscode >= 200 && statuscode <= 205) {
      Map<String, dynamic> decoded = json.decode(res.body);
      print(decoded);
      dataModel data = dataModel.fromJson(decoded);
      schema = data.schema;
      setState(() {
        isload = false;
      });
    }
  }
}
