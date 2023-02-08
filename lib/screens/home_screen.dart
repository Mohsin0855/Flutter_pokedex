import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    if (mounted) {
      fetchPokemonData();
    }
  }

  var pokeApi =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
  // ignore: unused_field
  List pokedex = [''];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            height: 185,
            width: 160,
            right: -40,
            top: -20,
            child: Image.asset(
              'assets/images/pokeball.png',
            )),
        Positioned(
            height: 185,
            width: 160,
            left: 20,
            top: 75,
            child: Text(
              'Pokedex',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
            )),
        Positioned(
          height: 450,
          bottom: 0,
          width: width,
          child: Column(
            children: [
              pokedex != null
                  ? Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1.4),
                        itemCount: pokedex.length,
                        itemBuilder: (context, index) {
                          var type = pokedex[index]['type'][0];
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: type == 'Grass'
                                      ? Colors.greenAccent
                                      : type == 'Fire'
                                          ? Colors.red
                                          : type == 'Water'
                                              ? Colors.blue
                                              : type == 'Electric'
                                                  ? Colors.yellow
                                                  : type == 'Poison'
                                                      ? Colors.deepPurpleAccent
                                                      : type == 'Rock'
                                                          ? Colors.grey
                                                          : type == "Ground"
                                                              ? Colors.brown
                                                              : type ==
                                                                      "Psychic"
                                                                  ? Colors
                                                                      .indigo
                                                                  : type ==
                                                                          "Fighting"
                                                                      ? Colors
                                                                          .orange
                                                                      : type ==
                                                                              "Bug"
                                                                          ? Colors
                                                                              .lightGreenAccent
                                                                          : type == "Ghost"
                                                                              ? Colors.deepPurple
                                                                              : type == "Normal"
                                                                                  ? Colors.black26
                                                                                  : Colors.pink,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child: Image.asset(
                                          'assets/images/pokeball.png',
                                          height: 100,
                                          fit: BoxFit.fitHeight,
                                        )),
                                    Positioned(
                                      top: 25,
                                      left: 35,
                                      child: Text(
                                        pokedex[index]['name'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Positioned(
                                      top: 55,
                                      left: 35,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4,
                                              left: 8,
                                              right: 8,
                                              top: 4),
                                          child: Text(
                                            type.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(300)),
                                            color: Colors.black26),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: CachedNetworkImage(
                                        imageUrl: pokedex[index]['img'],
                                        height: 100,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              //Navigate to Detail Screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DetailScreen(
                                            herotag: index,
                                            pokemondetail: pokedex[index],
                                            color: type == 'Grass'
                                                ? Colors.greenAccent
                                                : type == 'Fire'
                                                    ? Colors.red
                                                    : type == 'Water'
                                                        ? Colors.blue
                                                        : type == 'Electric'
                                                            ? Colors.yellow
                                                            : type == 'Poison'
                                                                ? Colors
                                                                    .deepPurpleAccent
                                                                : type == 'Rock'
                                                                    ? Colors
                                                                        .grey
                                                                    : type ==
                                                                            "Ground"
                                                                        ? Colors
                                                                            .brown
                                                                        : type ==
                                                                                "Psychic"
                                                                            ? Colors.indigo
                                                                            : type == "Fighting"
                                                                                ? Colors.orange
                                                                                : type == "Bug"
                                                                                    ? Colors.lightGreenAccent
                                                                                    : type == "Ghost"
                                                                                        ? Colors.deepPurple
                                                                                        : type == "Normal"
                                                                                            ? Colors.black26
                                                                                            : Colors.pink,
                                          )));
                            },
                          );
                        },
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          ),
        ),
      ],
    ));
  }

  void fetchPokemonData() {
    var url = Uri.https('raw.githubusercontent.com',
        '/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var data = jsonDecode(value.body);
        pokedex = data['pokemon'];

        setState(() {});
      }
    });
  }
}
