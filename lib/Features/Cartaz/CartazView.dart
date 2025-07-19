import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cartazrapido/AdMob/AdHelper.dart';
import 'package:cartazrapido/DesignSystem/Components/AppButtonIconText.dart';
import 'package:cartazrapido/DesignSystem/DesingSystem.dart';
import 'package:cartazrapido/DesignSystem/Overlays/TextChangeOverlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';

import '../../ManagerCartazes.dart';
import 'CartazViewModal.dart';
import 'Components/Background/BackgroundCartaz.dart';
import 'Components/LineWidget.dart';

class CartazView extends StatefulWidget {
  const CartazView({Key? key}) : super(key: key);

  @override
  State<CartazView> createState() => _CartazViewState();
}

class _CartazViewState extends State<CartazView> {
  final GlobalKey _containerKey = GlobalKey();
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  void _loadBanner() {
    BannerAd(
      adUnitId: AdHelper.encarteBanner,
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

  Future<void> saveImageAndShowDialog(BuildContext context, Uint8List screenshot) async {
    final result = await ImageGallerySaver.saveImage(screenshot);
    if (result['isSuccess']) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text("Encarte salvo na galeria"),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text("Ok"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    } else {
      print('Falha ao salvar: ${result['errorMessage']}');
    }
  }

  Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text("Tem certeza?"),
              content: const Text("Você realmente deseja deletar este item?"),
              actions: [
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text("Deletar"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text("Cancelar"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<Uint8List> captureScreenshot() async {
    try {
      RenderRepaintBoundary boundary = _containerKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 5);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      return pngBytes!;
    } catch (e) {
      print('Error capturing screenshot: $e');
      return Uint8List(0);
    }
  }

  IconData getHorizontalAlignIcon(Alignment align) {
    if (align.x == -1.0) {
      return Icons.format_align_left;
    } else if (align.x == 0.0) {
      return Icons.format_align_center;
    } else {
      return Icons.format_align_right;
    }
  }

  IconData getVerticalAlignIcon(Alignment align) {
    if (align.y == -1.0) {
      return Icons.vertical_align_top;
    } else if (align.y == 0.0) {
      return Icons.vertical_align_center;
    } else {
      return Icons.vertical_align_bottom;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CartazViewModel>();
    final managerCatazes = context.watch<ManageCartazes>();

    final screenSize = MediaQuery.of(context).size;
    final cartazSize = viewModel.calculateCartazSize(screenSize);

    final cartazWidth = cartazSize.width;
    final cartazHeight = cartazSize.height;

    return Material(
      child: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              viewModel.resetAll();
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
            child: Center(
              child: Container(
                child: Column(
                  children: [
                    NavigatorBar(
                      onBack: () {
                        managerCatazes.saveCartaz(viewModel.model);
                      },
                        onExport: () {
                      captureScreenshot().then((screenshot) {
                        saveImageAndShowDialog(context, screenshot);
                      });
                    }),

                    // if (_bannerAd != null)
                    //   Container(
                    //     width: _bannerAd!.size.width.toDouble(),
                    //     height: _bannerAd!.size.height.toDouble(),
                    //     child: AdWidget(ad: _bannerAd!),
                    //   ),

                    Spacer(),

                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.backgroundToolbar,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(100), // sombra leve
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: RepaintBoundary(
                        key: _containerKey,
                        child: Container(
                          width: cartazWidth,
                          height: cartazHeight,
                          color: viewModel.backgroundColor,
                          child: Stack(
                            children: [
                              BackgroundCartaz(
                                layers: viewModel.layers,
                                width: cartazWidth,
                                height: cartazHeight,
                                selectedLayer: viewModel.selectedLayerIndex,
                                showLines: viewModel.isModeEqual(EditMode.editBackground),
                                onConfirm: (values) {
                                  viewModel.setProportionRules(values);
                                },
                                onSelectedLayer: (index) {
                                  viewModel.layerSelected(index);
                                },
                              ),
                              if (!viewModel.isModeEqual(EditMode.editBackground))
                                Column(
                                  children: [
                                    ...viewModel.content
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      final index = entry.key;
                                      final line = entry.value;

                                      return GestureDetector(
                                        onTap: () {
                                          viewModel.setSelectedLineIndex(index);
                                        },
                                        onLongPress: () async {
                                          if (viewModel.isTextLayerSelected()) {
                                            final confirmed =
                                                await showDeleteConfirmationDialog(
                                                    context);

                                            if (confirmed) {
                                              viewModel.deleteLine();
                                            }
                                          }
                                        },
                                        child: LineWidget(
                                            line: line,
                                            isSelected:
                                                viewModel.selectedLineIndex ==
                                                    index),
                                      );
                                    }).toList(),
                                    // Price(moneySing: "R\$", name: "Banana", value: "4,30", valueOld: "10,30")
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    SizedBox(height: AppPadding.s8),
                  ],
                ),
              ),
            ),
          ),

          AnimatedSlide(
            offset: viewModel.menuBottomIsOpen()
                ? const Offset(0, 0)
                : const Offset(0, 0.3),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Horizontaltoolbar(
                buttons: [
                  if (viewModel.isModeEqual(EditMode.editProportion)) ...[
                    AppButtonIconText(
                        text: "1:1",
                        isSelected: viewModel.isSelected(1.0),
                        onPressed: () {
                          viewModel.setProportions(1);
                        }),
                    AppButtonIconText(
                        text: "3:4",
                        isSelected: viewModel.isSelected(3 / 4),
                        onPressed: () {
                          viewModel.setProportions(3 / 4);
                        }),
                    AppButtonIconText(
                        text: "9:16",
                        isSelected: viewModel.isSelected(9 / 16),
                        onPressed: () {
                          viewModel.setProportions(9 / 16);
                        }),
                    AppButtonIcon(
                        icon: Icons.close,
                        hasBackground: false,
                        onPressed: () {
                          viewModel.closeProportions();
                        }),
                  ] else if (viewModel.isModeEqual(EditMode.initial))...[
                    //MENU INICIAL
                    AppButtonIcon(
                        icon: Icons.add,
                        onPressed: () {
                          viewModel.addLine();
                        }),
                    AppButtonIcon(
                        icon: Icons.square_foot,
                        onPressed: () {
                          viewModel.showProportionsValues();
                        }),
                    AppButtonIcon(
                        icon: Icons.color_lens_outlined,
                        onPressed: () {
                          viewModel.setToEditBackground();
                        }),
                  ] else ...[
                    Text(''),
                  ]
                ],
              ),
            ),
          ),

          AnimatedSlide(
            offset: viewModel.menuRightIsOpen()
                ? const Offset(0, 0)
                : const Offset(0.3, 0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Align(
              alignment: Alignment.centerRight,
              child: VerticalToolbar(
                buttons: [
                  if (viewModel.isModeEqual(EditMode.editStyleText)) ...[
                    AppButtonIcon(
                        icon: Icons.edit,
                        onPressed: () {
                          viewModel.showTextChangeOverlay();
                        }),
                    AppButtonIcon(
                        icon: Icons.color_lens_outlined,
                        onPressed: () {
                          viewModel.showColorWheelPicker();
                        }),
                    AppButtonIcon(
                        icon: Icons.text_increase,
                        onPressed: () {
                          viewModel.increaseText();
                        }),
                    AppButtonIcon(
                        icon: Icons.text_decrease,
                        onPressed: () {
                          viewModel.decreaseText();
                        }),
                    AppButtonIcon(
                        icon: Icons.format_bold_rounded,
                        onPressed: () {
                          viewModel.changeBold();
                        }),
                    AppButtonIcon(
                        icon: getHorizontalAlignIcon(viewModel.getAlignment()),
                        onPressed: () {
                          viewModel.changeHorizontalAlign();
                        }),
                    AppButtonIcon(
                        icon: getVerticalAlignIcon(viewModel.getAlignment()),
                        onPressed: () {
                          viewModel.changeVerticalAlign();
                        }),
                    AppButtonIcon(
                        icon: Icons.expand,
                        onPressed: () {
                          viewModel.increaseHeight();
                        }),
                    AppButtonIcon(
                        icon: Icons.expand,
                        onPressed: () {
                          viewModel.decreaseHeight();
                        }),
                    AppButtonIcon(
                        icon: Icons.delete_outline,
                        color: AppColors.alert,
                        onPressed: () async {
                          if (viewModel.isTextLayerSelected()) {
                            final confirmed =
                                await showDeleteConfirmationDialog(context);
                            if (confirmed) {
                              viewModel.deleteLine();
                            }
                          }
                        }),
                    AppButtonIcon(
                        icon: Icons.close,
                        hasBackground: false,
                        onPressed: () {
                          viewModel.closeEditText();
                        }),
                  ] else if (viewModel.isModeEqual(EditMode.editBackground)) ...[
                    AppButtonIcon(
                        icon: Icons.color_lens_outlined,
                        disable: !viewModel.isLayerSelected(),
                        onPressed: () {
                          viewModel.showColorWheelPicker();
                        }),
                    AppButtonIcon(
                        icon: Icons.format_shapes,
                        disable: !viewModel.isLayerSelected(),
                        onPressed: () {
                          viewModel.changeShapeLayer();
                        }),
                    AppButtonIcon(
                        icon: Icons.close,
                        hasBackground: false,
                        onPressed: () {
                          viewModel.closeProportionRules();
                        }),
                  ] else ...[
                    Text(''),
                  ]
                ],
              ),
            ),
          ),

          if (viewModel.colorWheelIsOpen())
            ColorPickerOverlay(
                initialColor: viewModel.backgroundColor,
                onCancel: () {
                  viewModel.closeColorWheelPicker();
                },
                onColorChanged: (color) {
                  viewModel.setColor(color);
                  viewModel.closeColorWheelPicker();
                }),

          if (viewModel.editTextIsOpen())
            TextChangeOverlay(
                initialText: viewModel.getCurrentText(),
                onConfirm: (text) {
                  viewModel.setNewText(text);
                },
                onCancel: () {
                  viewModel.closeTextChangeOverlay();
                })
        ],
      ),
    );
  }
}
