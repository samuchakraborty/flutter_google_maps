import 'package:flutter/material.dart';
import 'package:flutter_google_maps_task/model/store_data_model.dart';
import 'package:flutter_google_maps_task/screens/MapScreen.dart';
import 'package:flutter_google_maps_task/services/database_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowData extends StatefulWidget {

  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  late Future<List<StoreData>?> listOfStoreData;

  @override
  void initState() {
    // TODO: implement initState
    listOfStoreData = DBHelper().getAllStoreData();

    super.initState();

  }

  Widget dataTable(List<StoreData> storeData, context) {
    return FittedBox(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width - 10),
        child: DataTable(
          columns: [
            // DataColumn(
            //   label: Container(child: Text('id')),
            // ),
            DataColumn(
              label: Container(
                  //  width: MediaQuery.of(context).size.width / 14,
                  child: Text('AddressFromMap')),
            ),
            DataColumn(
              label: Container(child: Text('Address Title')),
            ),
            DataColumn(
              label: Container(child: Text('Flat No')),
            ),
          ],
          rows: storeData
              .map(
                (element) => DataRow(cells: [
                  // DataCell(
                  //   Container(
                  //     child: Text(
                  //       element.id.toString(),
                  //     ),
                  //   ),
                  // ),
                  DataCell(
                    Container(
                      child: Text(
                        element.addressFromMap.toString(),
                        maxLines: 5,
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      child: Text(
                        element.addressTitle.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      child: Text(element.flatNo.toString()

                          //maxLines: 5,
                          ),
                    ),
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
    //  );
    //,
    // );
  }

  list() {
    return Container(
      child: FutureBuilder(
        future: listOfStoreData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data, context);
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Center(child: Text("No Data Found"));
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    //showData();
    return Scaffold(
      appBar: AppBar(
        title: Text("show data"),
      ),
      body: Consumer(builder: (BuildContext context, watch, child) {
       final dataStore = watch(dataStoreChangeNotifier);

       if (dataStore.dataRe.isEmpty) {
          return Container(
            child: list(),
          );
       }

          return dataTable(dataStore.dataRe, context);
      }
    ),);
  }
}
