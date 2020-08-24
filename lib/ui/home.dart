import 'package:cheers/Services/di.dart';
import 'package:cheers/bloc/beer_bloc/beer_bloc.dart';
import 'package:cheers/bloc/theme_bloc/theme_bloc.dart';
import 'package:cheers/bloc/theme_bloc/theme_event.dart';
import 'package:cheers/data/model/beer_model.dart';
import 'package:cheers/data/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    getQuotes(page);
  }

  void getQuotes(int page) async {
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
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select a Page",
                      style: GoogleFonts.lato(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Page:" + page.toString(),
                      style: GoogleFonts.lato(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
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

                        getQuotes(item + 1);
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
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
        ],
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
              "Loading Quotes...",
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ],
          ),
          child: ListTile(
            onTap: () {},
            title: Text(beerList[item].name),
          ),
        );
      },
    );
  }
}
