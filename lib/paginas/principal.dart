import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_geolocation/Controles/PosicaoController.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';

class PrincipalPagina extends StatefulWidget {
  const PrincipalPagina({super.key});

  @override
  State<PrincipalPagina> createState() => _PrincipalPaginaState();
}

class _PrincipalPaginaState extends State<PrincipalPagina> {
  double lat = 0.0;
  double long = 0.0;
  String mensagem = '';
  String dataHora = '';

  obterLocalizacao() async {
    PosicaoController posicao = PosicaoController();

    var pos = await posicao.posicaoAtual();

    DateTime now = DateTime.now();
    Duration tresHoras = const Duration(hours: 3);

    setState(() {
      lat = pos.latitude;
      long = pos.longitude;
      dataHora =
          DateFormat('dd/MM/yyyy HH:mm:ss').format(now.subtract(tresHoras));
    });
  }

  verNoMapa() async {
    final availableMaps = await MapLauncher.installedMaps;

    await MapLauncher.showMarker(
      mapType: MapType.google,
      coords: Coords(lat, long),
      title: "Minha posição",
      description: "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Minha Localização Atual"),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  obterLocalizacao();
                },
                child: const Text("Pegar minha posição atual")),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [Text("Sua Latitude: $lat")],
            ),
            Column(
              children: [Text("Sua Longitude: $long")],
            ),
            Column(
              children: [Text("Ultima atualização: $dataHora")],
            ),
            Column(
              children: [Text(mensagem)],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  verNoMapa();
                },
                child: const Text("Ver no mapa")),
          ],
        ),
      ),
    );
  }
}
