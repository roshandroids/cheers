import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheers/data/model/beer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BeerDetails extends StatelessWidget {
  final BeerModel beers;
  BeerDetails({@required this.beers});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(beers.name),
      ),
      body: ListView(
        padding: EdgeInsets.all(5.0),
        children: <Widget>[
          Hero(
            tag: beers.imageUrl,
            child: CachedNetworkImage(
              imageUrl: (beers.imageUrl != null)
                  ? beers.imageUrl
                  : "https://previews.123rf.com/images/yopinco/yopinco1706/yopinco170600150/80392742-cheers-beer.jpg",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              placeholder: (context, url) => const SpinKitPulse(
                color: Colors.green,
                size: 40.0,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: Text(
              beers.name,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.all(5.0),
            child: Text(beers.description),
          ),
          Text(beers.tagline),
        ],
      ),
    );
  }
}
