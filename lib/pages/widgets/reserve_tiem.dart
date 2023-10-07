import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/helper/ulti.dart';
import 'package:findingmotels/models/history_model.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:findingmotels/config_app/sizeScreen.dart' as app;
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/widgets/circle_checkbox.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';

import 'loadingWidget/loading_widget.dart';

class ReserveModal extends StatefulWidget {
  final MotelModel motelModel;
  final DetailBooking detailBooking;
  final ScrollController scrollController;
  const ReserveModal(
      {Key key, this.scrollController, this.motelModel, this.detailBooking})
      : super(key: key);
  @override
  _ReserveModalState createState() => _ReserveModalState();
}

class _ReserveModalState extends State<ReserveModal> {
  bool isTravelForWork;
  bool isMyBooking;
  List<Availability> listAvailability = [];
  TextEditingController gustBookingController;
  String timeStart;
  DetailBooking detailBooking;
  String timeEnd;
  int dateBooking;
  bool isLoading = false;

  void initState() {
    super.initState();
    detailBooking = widget.detailBooking;
    isTravelForWork = false;
    isMyBooking = true;
    timeStart = 'Select time Check-in';
    timeEnd = 'Select time Check-out';
    gustBookingController = TextEditingController();
    listAvailability = getListAvailabiity(widget.motelModel);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
            controller: ScrollController(),
            physics: ScrollPhysics(parent: PageScrollPhysics()),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[headerSliver(context)];
            },
            body: body()),
      );

  Widget body() => Ink(
      color: app.AppColor.backgroundColor,
      child: Stack(
        children: <Widget>[
          ListView(
              controller: widget.scrollController,
              padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 15),
              children: <Widget>[
                _title('Are you traveling for work?'),
                _checkboxWork(),
                _title('What are you looking for?'),
                _checkboxLooking(),
                !isMyBooking
                    ? _bookingForUser(
                        title: 'Guest Name', controller: gustBookingController)
                    : SizedBox(),
                _title('Check-in date'),
                _timeSelect(
                    onTap: () async {
                      await DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime: DateTime.now().add(new Duration(days: 360)),
                        onChanged: (date) {},
                        onConfirm: (date) {
                          if (timeEnd == 'Select time Check-out') {
                            setState(() => timeStart =
                                DateFormat('dd-MM-yyyy').format(date));
                          } else {
                            if (DateFormat('dd-MM-yyyy')
                                    .parse(timeEnd)
                                    .difference(date)
                                    .inDays <
                                0) {
                              setState(() {
                                timeEnd = 'Select time Check-out';
                              });
                            }
                            setState(() => timeStart =
                                DateFormat('dd-MM-yyyy').format(date));
                          }
                        },
                        currentTime: timeEnd == 'Select time Check-out'
                            ? DateTime.now()
                            : DateFormat('dd-MM-yyyy').parse(timeStart),
                        locale: LocaleType.en,
                      );
                    },
                    timeSelect: timeStart),
                _title('Check-out date'),
                _timeSelect(
                    onTap: () async {
                      if (timeStart == 'Select time Check-in') {
                        showToast('Please select time check-in before');
                      } else {
                        await DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateFormat('dd-MM-yyyy')
                                .parse(timeStart)
                                .add(new Duration(days: 1)),
                            maxTime: DateFormat('dd-MM-yyyy')
                                .parse(timeStart)
                                .add(new Duration(days: 60)),
                            onChanged: (date) {},
                            onConfirm: (date) => setState(() => timeEnd =
                                DateFormat('dd-MM-yyyy').format(date)),
                            currentTime: timeEnd != 'Select time Check-out'
                                ? DateFormat('dd-MM-yyyy').parse(timeEnd)
                                : DateFormat('dd-MM-yyyy')
                                    .parse(timeStart)
                                    .add(new Duration(days: 1)),
                            locale: LocaleType.en);

                        dateBooking = DateFormat('dd-MM-yyyy')
                            .parse(timeEnd)
                            .difference(
                                DateFormat('dd-MM-yyyy').parse(timeStart))
                            .inDays;
                        print(dateBooking);
                      }
                    },
                    timeSelect: timeEnd),
                _title('Availability'),
                _listAvailability(),
                GestureDetector(
                  onTap: () async {
                    if (!isMyBooking) if (gustBookingController.text.trim() ==
                        "") {
                      showToast('Please input Gust name');
                      return;
                    }
                    setState(() => isLoading = true);
                    if (timeStart != 'Select time Check-in') {
                      if (timeEnd != 'Select time Check-out') {
                        double sum =
                            Helper.getTotalPriceHistory(listAvailability);
                        if (sum != 0) {
                          detailBooking = DetailBooking(
                            availability: listAvailability,
                            checkIn: timeStart,
                            checkOut: timeEnd,
                            lookingFor: isMyBooking,
                            travelWork: isTravelForWork,
                            totalPrice:
                                Helper.getTotalPriceHistory(listAvailability),
                            gustName: gustBookingController.text.trim(),
                          );
                          print(detailBooking.toString());
                          await ConfigApp.oneSignalService
                              .sendNotifyToManagerHotel(widget.motelModel);
                          await ConfigApp.fbCloudStorage.updateHistoryToClound(
                              widget.motelModel, detailBooking);
                          setState(() => isLoading = false);
                          Navigator.of(context).pop(detailBooking);
                        } else {
                          showToast('Please Select Room');
                          setState(() => isLoading = false);
                        }
                      } else {
                        showToast('Please Select time Check-out');
                        setState(() => isLoading = false);
                      }
                    } else {
                      showToast('Please Select time Check-in');
                      setState(() => isLoading = false);
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 30, 10),
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColor.colorClipPath),
                      child: Center(
                        child: Text('I\'ll Reserve',
                            style: StyleText.header20Whitew500),
                      )),
                )
              ]),
          isLoading
              ? Positioned.fill(
                  child: Container(
                      color: Colors.grey.withOpacity(0.5),
                      child: Center(child: LoadingWidget())))
              : SizedBox(),
        ],
      ));

  Widget headerSliver(BuildContext context) => SliverList(
        delegate: SliverChildListDelegate(
          [
            Material(
              color: Colors.transparent,
              child: Container(
                height: 50,
                margin: EdgeInsets.only(
                    top: app.Size.getHeight * 0.24 - app.Size.statusBar),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: app.AppColor.colorClipPath,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(LineIcons.times_circle,
                            size: 30.0, color: Colors.transparent),
                        onPressed: () {}),
                    Text(
                      'Enter your details',
                      style: app.StyleText.header24BWhite,
                    ),
                    IconButton(
                        icon: Icon(LineIcons.times_circle,
                            size: 30.0, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget _listAvailability() => ListView.builder(
      shrinkWrap: true,
      itemCount: listAvailability.length,
      itemBuilder: (context, index) => __itemAvailability(index));

  Widget __itemAvailability(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ___nameIcon(index),
        SizedBox(height: 8.0),
        ___priceSelect(index)
      ],
    );
  }

  Widget ___priceSelect(int index) => Row(
        children: <Widget>[
          Text('Today\'s Price: ', style: StyleText.subhead18Black87w400),
          Text(
            listAvailability[index].price.toString().length > 5
                ? listAvailability[index].price.toString().substring(0, 5)
                : listAvailability[index].price.toString(),
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18.0 * Size.scaleTxt,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(' \$', style: StyleText.subhead18Red87w400),
          Spacer(),
          DropdownButton(
              value: listAvailability[index].total,
              items: [
                DropdownMenuItem(
                    child: Text(listAvailability[index].listDropbox[0]),
                    value: 0),
                DropdownMenuItem(
                    child: Text(listAvailability[index].listDropbox[1]),
                    value: 1),
                DropdownMenuItem(
                    child: Text(listAvailability[index].listDropbox[2]),
                    value: 2),
                DropdownMenuItem(
                    child: Text(listAvailability[index].listDropbox[3]),
                    value: 3),
                DropdownMenuItem(
                    child: Text(listAvailability[index].listDropbox[4]),
                    value: 4),
                DropdownMenuItem(
                    child: Text(listAvailability[index].listDropbox[5]),
                    value: 5)
              ],
              onChanged: (value) => setState(() {
                    listAvailability[index].total = value;
                    listAvailability[index].totalPrice =
                        listAvailability[index].total.toDouble() *
                            listAvailability[index].price;
                  })),
        ],
      );

  Widget ___nameIcon(int index) {
    return Row(
      children: <Widget>[
        Text(
          listAvailability[index].typeRoom,
          style: StyleText.subhead18GreenMixBlue,
        ),
        Spacer(),
        Icon(Icons.supervisor_account, size: 24.0),
        index == 2 ? Icon(Icons.supervisor_account, size: 24.0) : SizedBox(),
      ],
    );
  }

  Widget _timeSelect({Function onTap, String timeSelect}) => InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 30.0,
                  width: 30.0,
                  child: SvgPicture.asset(AppSetting.eventIcon)),
              SizedBox(width: 8.0),
              Text(
                timeSelect,
                style: StyleText.subhead16Black500,
              )
            ],
          ),
        ),
      );

  Widget _bookingForUser({String title, TextEditingController controller}) =>
      Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: TextField(
          maxLines: 1,
          controller: controller,
          autofocus: true,
          style: app.StyleText.subhead18Black87w400,
          decoration: InputDecoration(
              prefix: Container(
                width: app.Size.getWidth * 0.3,
                padding: EdgeInsets.only(left: 5, right: 15.0),
                child: Text(title, style: app.StyleText.subhead16GreenMixBlue),
              ),
              hintText: 'Input Name',
              hintStyle: StyleText.subhead18Black87w400,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              contentPadding: EdgeInsets.all(16.0)),
        ),
      );

  Widget _checkboxWork() => Padding(
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
        child: Row(children: <Widget>[
          RoundCheckBox(
              isChecked: isTravelForWork,
              title: 'Yes',
              onTap: () => setState(() => isTravelForWork = !isTravelForWork)),
          SizedBox(width: 16.0),
          RoundCheckBox(
            isChecked: !isTravelForWork,
            title: 'No',
            onTap: () => setState(() => isTravelForWork = !isTravelForWork),
          ),
        ]),
      );

  Widget _checkboxLooking() => Padding(
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
        child: Column(children: <Widget>[
          RoundCheckBox(
              isChecked: isMyBooking,
              title: 'I\'m the main guest',
              onTap: () => setState(() => isMyBooking = !isMyBooking)),
          SizedBox(height: 10.0),
          RoundCheckBox(
            isChecked: !isMyBooking,
            title: ' I\'m booking for someone else',
            onTap: () => setState(() => isMyBooking = !isMyBooking),
          ),
        ]),
      );

  Widget _title(String title) =>
      Text(title, style: StyleText.header20BlackNormal);
}
