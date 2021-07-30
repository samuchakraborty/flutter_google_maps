import 'package:flutter/material.dart';
import 'package:flutter_google_maps_task/model/store_data_model.dart';
import 'package:flutter_google_maps_task/services/database_helper.dart';

class ShowData extends StatelessWidget {
  late Future<List<StoreData>?> listOfStoreData;

  void showData() {
    listOfStoreData =  DBHelper().getAllStoreDataById();

    print(listOfStoreData);
  }



  Widget dataTable(List<StoreData> storeData, context) {
    return

      FittedBox(
             child: ConstrainedBox(
          constraints:
         BoxConstraints(minWidth: MediaQuery.of(context).size.width - 10),
          child: DataTable(
            columns: [
              DataColumn(
                label: Container(child: Text('id')),
              ),
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
            rows: storeData.reversed
                .map(
                  (element) => DataRow(cells: [
                DataCell(
                  Container(
                    child: Text(
                      element.id.toString(),
                    ),
                  ),
                ),
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
                    child: Text(
                      element.flatNo.toString()

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
            return dataTable(snapshot.data , context);
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
    showData();
    return Scaffold(
      appBar: AppBar(
        title: Text("show data"),
      ),
      body: Container(

        child:  list(),
      ),
    );
  }
}
