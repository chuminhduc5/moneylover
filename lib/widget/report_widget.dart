import 'package:flutter/material.dart';

class ReportWidget extends StatefulWidget {
  const ReportWidget({Key? key}) : super(key: key);

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  bool isWeeklyMode = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 500,
          child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isWeeklyMode = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 150,
                                decoration: BoxDecoration(
                                    color: isWeeklyMode
                                        ? Colors.white
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'Tuần',
                                    style: TextStyle(
                                        color: isWeeklyMode
                                            ? Colors.black
                                            : Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isWeeklyMode = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 150,
                                decoration: BoxDecoration(
                                  color: isWeeklyMode
                                      ? Colors.grey[300]
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Tháng',
                                    style: TextStyle(
                                        color: isWeeklyMode
                                            ? Colors.grey
                                            : Colors.black
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: isWeeklyMode
                          ? buildWeeklyActivities()
                          : buildMonthlyActivities(),
                    ),
                ),
              ],
            ),
        ),
      ),
    );
  }
  Widget buildWeeklyActivities(){
    return ListView(
      children: [
            Text('0 đ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text('Tổng chi tháng này')
      ],
    );
  }
  Widget buildMonthlyActivities(){
    return ListView(
      children: [
        Text('0 đ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        Text('Tổng chi tháng này')
      ],
    );
  }
}
