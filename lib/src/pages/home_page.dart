import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qrcodeapp/src/pages/direcciones_page.dart';
import 'mapas_page.dart';

import 'package:qrcodeapp/src/bloc/scans_bloc.dart';
import 'package:qrcodeapp/src/models/scan_model.dart';

import 'package:qrcodeapp/src/utils/utils.dart' as utils;

import 'package:qrcode_reader/qrcode_reader.dart';


class HomePate extends StatefulWidget {
  @override
  _HomePateState createState() => _HomePateState();
}

class _HomePateState extends State<HomePate> {

  final scansBloc = ScansBloc();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              scansBloc.borrarScansTodos();
            },
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQr(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQr(BuildContext context) async {

    // https://pub.dev/packages/qrcode_reader#-readme-tab-
    // geo:6.297381747078889,-75.54402723750002

    String futureString = '';
    // String futureString = 'https://pub.dev/packages/qrcode_reader#-readme-tab-';
    // String futureString2 = 'geo:6.297381747078889,-75.54402723750002';

    try {
      futureString = await new QRCodeReader().scan();
    } catch(e) {
      futureString = e.toString();
    }

    if(futureString != null) {

      final scan = ScanModel( valor: futureString);
      scansBloc.agregarScan(scan);

      if(Platform.isIOS){
        Future.delayed(Duration( milliseconds: 750), () {
          utils.abrirScan(context, scan);
        });
      } else {
        utils.abrirScan(context, scan);
      }

    }

  }

  Widget _crearBottomNavigationBar() {

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {

        setState(() {
          currentIndex = index;
        });

      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Maps')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('DIrecciones')
        ),
      ],
    );

  }

  Widget _callPage(int paginaActual) {

    switch( paginaActual ) {

      case 0: return MapasPage();
      case 1: return DireccionesPage();

      default:
        return MapasPage();

    }
  }
}