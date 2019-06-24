import 'package:flutter/material.dart';
import 'package:qrcodeapp/src/bloc/scans_bloc.dart';
import 'package:qrcodeapp/src/models/scan_model.dart';
import 'package:qrcodeapp/src/utils/utils.dart' as utils;

class MapasPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(
            child: Text('No hay información'),
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (BuildContext context, int index) => Dismissible(
            key: UniqueKey(),
            background: Container(
              padding:  EdgeInsets.only(left: 10.0),
              alignment: Alignment(-1.0, 0.1),
              child: Icon(Icons.delete_outline, color: Colors.white, size: 30.0,),
              color: Colors.red
            ),
            onDismissed: (direction) => scansBloc.borrarScan(scans[index].id),
            child: ListTile(
              leading: Icon(Icons.map, color: Theme.of(context).primaryColor),
              title: Text(scans[index].valor),
              subtitle: Text('ID: ${scans[index].id}'),
              trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).primaryColor),
              onTap: () => utils.abrirScan(context, scans[index]),
            ),
          ),
        );
      },
    );
  }
}
