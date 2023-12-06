import 'package:cartazrapido/AdMob/AdHelper.dart';
import 'package:cartazrapido/DesignSystem/Components/EditValorPopUp.dart';
import 'package:cartazrapido/DesignSystem/Components/NavigationBackButton.dart';
import 'package:cartazrapido/Model/Product.dart';
import 'package:cartazrapido/Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class AllProductsList extends StatefulWidget {
  AllProductsList();

  @override
  _AllProductsListState createState() => _AllProductsListState();
}

class _AllProductsListState extends State<AllProductsList> {

  String _searchQuery = '';
  BannerAd? _bannerAd;

  @override
  void initState() {

    BannerAd(
      adUnitId: AdHelper.productListBanner,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  editValor(ProductModel produto) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return EditValorPopUp(produto);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<Service>(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Escolha um produto'),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                    child: CupertinoSearchTextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase().trim();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              final produto = productViewModel.products[index];

                              // Filtrar a lista de produtos com base na consulta de pesquisa
                              if (_searchQuery.isNotEmpty &&
                                  !produto.name.toLowerCase().contains(_searchQuery)) {
                                return SizedBox.shrink();
                              }
                              return GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Container(
                                      width: 120,
                                      // height: 70,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(1, 8, 0, 9),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(padding: EdgeInsets.all(4)),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: width*0.6,
                                                        child: Text(
                                                          "${produto.name}",
                                                          maxLines: null,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  color: Colors.transparent,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  produto.value = "";
                                  editValor(produto);
                                },
                              );
                            },
                            childCount: productViewModel.products.length,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              if (_bannerAd != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
