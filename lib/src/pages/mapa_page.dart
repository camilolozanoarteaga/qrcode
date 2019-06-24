import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:qrcodeapp/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapController map = new MapController();

  String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(center: scan.getLatLng(), zoom: 10),
      layers: [_crearMapa(), _crearMarcadores(scan)],
    );
  }

  TileLayerOptions _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
          '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken':
            'pk.eyJ1IjoiY2FtaWxvbG96YW5vYXJ0ZWFnYSIsImEiOiJjang3dmQ2ajIwZW5rM25sbWhsdWF3ZWVtIn0.7H7nY_Jtj-WcAN5fc3tJGg',
        'id': 'mapbox.$tipoMapa'
        // streets, dark, light, outdoors, stellite
      },
    );
  }

  MarkerLayerOptions _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 120.0,
          height: 120.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              size: 70.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        // streets, dark, light, outdoors, satellite

        if(tipoMapa == 'streets') {
          tipoMapa = 'dart';
        } else if(tipoMapa == 'dart') {
          tipoMapa = 'light';
        } else if(tipoMapa == 'light') {
          tipoMapa = 'outdoors';
        } else if(tipoMapa == 'outdoors') {
          tipoMapa = 'satellite';
        } else {
           tipoMapa = 'streets';
        }

        setState(() {});

      },
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor
    );
  }
}
