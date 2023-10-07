import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/models/district_model.dart';
import 'package:findingmotels/pages/district/bloc/district_bloc.dart';
import 'package:findingmotels/pages/districtdetail/view/district_detail_page.dart';
import 'package:findingmotels/pages/widgets/district_item.dart';
import 'package:findingmotels/pages/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DistrictPage extends StatefulWidget {
  @override
  _DistrictPageState createState() => _DistrictPageState();
}

class _DistrictPageState extends State<DistrictPage> {
  GlobalKey globalKey;
  List<DistrictModel> listDistrict = [];
  @override
  void initState() {
    globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DistrictBloc()..add(FeatchDistrictEvent()),
        child: BlocListener<DistrictBloc, DistrictState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<DistrictBloc, DistrictState>(
                builder: (context, state) => _scaffold(state))));
  }

  void blocListener(DistrictState state, BuildContext context) {
    if (state is FeatchDistrictSucessState) {
      listDistrict = state.listDistrict;
    }
  }

  Widget _scaffold(DistrictState state) => Scaffold(
        key: globalKey,
        backgroundColor: AppColor.backgroundColor,
        body: _body(state),
      );

  Widget _body(DistrictState state) {
    return Column(
      children: <Widget>[_appBar(), _data(state)],
    );
  }

  Widget _data(DistrictState state) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          listDistrict.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  padding: EdgeInsets.all(0.0),
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: ((context, index) => DistrictItem(
                        name: listDistrict[index].name,
                        onTap: () {
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (context) {
                                return DistrictDetail(
                                  districtModel: listDistrict[index],
                                );
                              },
                            ),
                          );
                        },
                      )),
                )
              : SizedBox(),
          state is LoadingDistrictState ? LoadingWidget() : SizedBox(),
        ],
      ),
    );
  }

  Widget _appBar() => Container(
        padding: EdgeInsets.only(top: 32.0, left: 10, right: 10),
        height: Size.getHeight * 0.12,
        width: Size.getWidth,
        color: AppColor.colorClipPath,
        margin: EdgeInsets.only(bottom: Size.getHeight * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              child: Container(
                height: 30,
                width: 30,
                child: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Text('District Hotels',
                textAlign: TextAlign.center,
                style: GoogleFonts.vidaloka(
                    color: Colors.white, fontSize: 24 * Size.scaleTxt)),
            Container(
              height: 30,
              width: 30,
              child: Icon(Icons.arrow_back, color: Colors.transparent),
            ),
          ],
        ),
      );
}
