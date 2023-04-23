import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:module_9/models/hotel.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = false;
  bool hasError = false;
  bool isList = true;
  late String errorMessage;
  final _dio = Dio();
  late List<HotelPreview> hotels;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await _dio
          .get('https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301');
      var data = response.data;
      hotels = data
          .map<HotelPreview>((user) => HotelPreview.fromJson(user))
          .toList();
    } on DioError catch (e) {
      setState(() {
        errorMessage = e.response?.data['message'];
        hasError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isList = true;
              });
            },
            icon: const Icon(Icons.list),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isList = false;
              });
            },
            icon: const Icon(Icons.grid_view_sharp),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? Center(
                  child: Text(errorMessage ?? '404'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return isList
                          ? ListView(
                              children: <Widget>[
                                ...hotels
                                    .map((hotel) => HotelCard(
                                          hotel: hotel,
                                          isList: true,
                                        ))
                                    .toList(),
                              ],
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1,
                                      maxCrossAxisExtent: 200),
                              itemCount: hotels.length,
                              itemBuilder: (context, index) => HotelCard(
                                hotel: hotels[index],
                                isList: false,
                              ),
                            );
                    },
                  )),
    );
  }
}

class HotelCard extends StatelessWidget {
  const HotelCard({
    super.key,
    required this.hotel,
    required this.isList,
  });
  final HotelPreview hotel;
  final bool isList;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/${hotel.poster}',
            height: isList ? 160 : 90,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          if (isList)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(hotel.name),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/hotel/${hotel.uuid}');
                    },
                    child: const Text('Подробнее'),
                  ),
                ],
              ),
            ),
          if (!isList)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  hotel.name,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (!isList)
            Material(
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/hotel/${hotel.uuid}');
                },
                child: const SizedBox(
                  width: double.infinity,
                  height: 32,
                  child: Center(
                      child: Text(
                    'Подробнее',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
