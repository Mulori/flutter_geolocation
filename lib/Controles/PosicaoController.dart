import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PosicaoController extends ChangeNotifier {
  Future<Position> posicaoAtual() async {
    LocationPermission permissao;
    bool ativado = await Geolocator.isLocationServiceEnabled();

    if (!ativado) {
      return Future.error(
          "Por favor, ative nas configurações do dispositivo a geolocalização");
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error(
            "É necessário autorizar o acesso a geolocalização.");
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error("É necessário autorizar o acesso a geolocalização.");
    }

    return await Geolocator.getCurrentPosition();
  }
}
