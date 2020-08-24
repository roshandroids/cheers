import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheers/Services/di.dart';
import 'package:cheers/Services/exitAppAlert.dart';
import 'package:cheers/bloc/beer_bloc/beer_bloc.dart';
import 'package:cheers/bloc/theme_bloc/theme_bloc.dart';
import 'package:cheers/bloc/theme_bloc/theme_event.dart';
import 'package:cheers/data/model/beer_model.dart';
import 'package:cheers/data/theme/app_themes.dart';
import 'package:cheers/ui/beerDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final ThemeData themeData;
  HomePage({@required this.themeData});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BeerBloc beerBloc = sl<BeerBloc>();
  int page = 1;
  @override
  void initState() {
    super.initState();
    getBeers(page);
  }

  void getBeers(int page) async {
    beerBloc.add(FetchBeerEvent(page: page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "𝐂𝐡𝐞𝐞𝐫𝐬 🍻",
          style: TextStyle(),
        ),
        actions: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 0),
                child: Text(widget.themeData.brightness == Brightness.dark
                    ? "🌒"
                    : "💡"),
              ),
              Expanded(
                child: Switch(
                  value: (widget.themeData.brightness == Brightness.dark)
                      ? true
                      : false,
                  onChanged: (value) {
                    setState(() {
                      (value)
                          ? BlocProvider.of<ThemeBloc>(context)
                              .add(ThemeChanged(theme: AppTheme.GreenDark))
                          : BlocProvider.of<ThemeBloc>(context)
                              .add(ThemeChanged(theme: AppTheme.GreenLight));
                    });
                  },
                  activeTrackColor: Colors.black54,
                  activeColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 0),
                child: Text(widget.themeData.brightness == Brightness.dark
                    ? "Dark "
                    : "Light"),
              ),
            ],
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () => ExitAppAlert().onBackPress(context: context),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Selected Page - - - >",
                    style: GoogleFonts.lato(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "- " + page.toString() + " -",
                    style: GoogleFonts.lato(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: BlocListener<BeerBloc, BeerState>(
                  cubit: this.beerBloc,
                  listener: (context, state) {
                    if (state is BeerLoadingErrorState) {
                      return showError(state.message);
                    }
                  },
                  child: BlocBuilder<BeerBloc, BeerState>(
                    cubit: this.beerBloc,
                    builder: (context, state) {
                      if (state is BeerInitialState) {
                        return buildLoading();
                      } else if (state is BeerLoadingState) {
                        return buildLoading();
                      } else if (state is BeerLoadedState) {
                        return loadArticles(state.beers);
                      } else if (state is BeerLoadingErrorState) {
                        return showError(state.message);
                      } else {
                        return Container(
                          child: Center(
                            child: Text("No data"),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1.0,
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 13,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, item) {
                  return InkWell(
                    splashColor: Colors.green,
                    onTap: () {
                      setState(() {
                        page = item + 1;
                      });

                      getBeers(item + 1);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Color.fromRGBO(0, 0, 0, 0.5))
                        ],
                      ),
                      child: Text(
                        (item + 1).toString(),
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Loading Beers...",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget showError(String message) {
    return Center(
      child: Text(message),
    );
  }

  Widget loadArticles(List<BeerModel> beerList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: beerList.length,
      itemBuilder: (context, item) {
        return Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ],
          ),
          child: ListTile(
            onTap: () {
              navigateToBeerDetailsPage(context, beerList[item]);
            },
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 44,
                minHeight: 44,
                maxWidth: 60,
                maxHeight: 60,
              ),
              child: CachedNetworkImage(
                imageUrl: (beerList[item].imageUrl != null)
                    ? beerList[item].imageUrl
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
            title: Text(
              beerList[item].name,
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            subtitle: Text(
              beerList[item].tagline,
              style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Volume",
                  style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  beerList[item].volume.value.toString() +
                      " " +
                      beerList[item].volume.unit,
                  style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void navigateToBeerDetailsPage(BuildContext context, BeerModel beerModel) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BeerDetails(
        beers: beerModel,
      );
    }));
  }
}
