# osm_flutter_mapa

Projeto: OSMFlutterMapas

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## OSMFlutter
- MapController: necessário p inicializar o mapa
- útil p nosso app no MapController: initMapWithUserPosition
  * permite que o app já seja iniciado partindo da localizção do usuário e com isso acredito ser possível a obtenção apenas local das ruas, cruzamentos etc
- await mapController.currentLocation(); vai manter o mapa centralizado com a localização do usuário

## geoPoint
- te dá acesso a longitude e latitude de um determinado local
- a variável 'key' recebe uma string formatada com a latitude e longitude de geoPoint
- a lista 'points' recebe cada variável 'key' sempre que há um clique em um ponto qualquer
  * responsável pelo clique: onGeoPointClicked: (geoPoint) {}

## Pontos p reunião (20/06)
- De que forma podemos passar apenas dados locais utilizando o MapController?
- Como adicionar tais dados em um database (cruzamentos e suas informações relativas)?
- Os pontos no database deverão estar em que formato?
  * latitude e longitude? se sim:
    *  Os dados serão "traduzidos" só quando solicitados pelo usuário?
  * se não:
    * As informações referentes aos pontos devem conter que atributos no DB?
      * Ruas envolvidas no cruzamento?
      * Se possuem faixas de pedestre ou semáforo?
      * Se é rua sem saída?
      * Se está asfaltada ou não?
      * Essas informações serão expostas ao usuário de que forma?
- De que forma os dados serão dispostos a quem utilizar?
- Que funções além do mapa e do database a aplicação deve conter?
  * cadastro, pesquisa, quantos pontos o usuário pode selecionar ao utilizar o app p se locomover?
- Para usuários PNE/PCD, o trajeto será narrado por meio de TTS (text-to-speech)?
- A utilização da OverpassAPI se mantém necessária mesmo com o OSMFlutterPlugin?

## OBS:
# Sobre o app atual
- A homepage necessita ser um StatefulWidget, devido a constante atualização de estados durante a execução do app
- 'controller: mapController' inicializa o mapa utilizando o controlador criado anteriormente
- 'trackMyPosition: true' ativa a busca pela localização do usuário
# Importante (Ainda não implementado)
- É possível traçar um percurso utilizando geoPoint, onde o desenho é disposto no mapa a partir da seleção dos pontos
- Vi que um método de obter dados completos a respeito de um geoPoint com latitude e longitude, vi que é necessário uma API de geocodificação reversa, acredito que não seja possível a obtenção de tais dados sem esse processo, visto que o geoPoint só possui latitude e longitude como referências.
- 'double distancia = await distance2point(GeoPoint(longitude: 36.84612143139903,latitude: 11.099388684927824,),GeoPoint( longitude: 36.8388023164018, latitude: 11.096959785428027, ),);' para calcular a distância entre dois pontos (em metros)
