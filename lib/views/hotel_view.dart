import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:module_9/models/hotel.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HotelView extends StatefulWidget {
  static const routeName = '/hotel';
  const HotelView({super.key, this.uuid});
  final String? uuid;

  @override
  State<HotelView> createState() => _HotelViewState();
}

class _HotelViewState extends State<HotelView> {
  bool isLoading = true;
  bool hasError = false;
  String title = '';
  late String errorMessage;
  final _dio = Dio();
  late HotelPreview hotel;

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
      if (widget.uuid == null) throw DioError;
      final response = await _dio.get('https://run.mocky.io/v3/${widget.uuid}');
      var data = response.data;
      hotel = HotelPreview.fromJson(data);
      setState(() {
        title = hotel.name;
      });
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
          title: Text(title),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : hasError
                ? Center(
                    child: Text(errorMessage ?? '404'),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                        ),
                        itemCount: hotel.photos?.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Image.asset(
                            'assets/images/${hotel.photos?[itemIndex]}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Страна: ${hotel.address?.country}'),
                            Text('Город: ${hotel.address?.city}'),
                            Text('Улица: ${hotel.address?.street}'),
                            Text('Рейтинг: ${hotel.rating}'),
                            const SizedBox(height: 20),
                            const Text(
                              'Сервисы',
                              style: TextStyle(fontSize: 28),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        'Платные',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      ...?hotel.services?.paid
                                          .map((e) => Text(e)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Бесплатные',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      ...?hotel.services?.free
                                          .map((e) => Text(e)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));
  }
}
