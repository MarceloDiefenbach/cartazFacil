import 'package:cartazfacil/DesignSystem/DesignTokens.dart';
import 'package:cartazfacil/Model/Product.dart';
import 'package:cartazfacil/Service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditValorPopUp extends StatefulWidget {
  Product produto;

  EditValorPopUp(this.produto);

  @override
  _EditValorPopUpState createState() => _EditValorPopUpState();
}

class _EditValorPopUpState extends State<EditValorPopUp> {

  late TextEditingController valorFieldController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valorFieldController = TextEditingController(text: widget.produto.valor);
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16), // valor do raio dos cantos arredondados
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Escolha o valor do produto",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                        child: Container(
                          width: width * 0.9,
                          height: height*0.08,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                          child: TextField(
                            controller: valorFieldController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            autofocus: false,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 20),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Digite o preço',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Container(
                              height: 50,
                              width: width*0.4,
                              decoration: BoxDecoration(
                                borderRadius: borderRadiusCircular(),
                                color: colorNeutralHighDark(),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Cancelar',
                                      style: TextStyle(
                                          color: colorNeutralLowPure(),
                                          fontSize: 16
                                      )
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: 8.0),
                          GestureDetector(
                            child: Container(
                              height: 50,
                              width: width*0.4,
                              decoration: BoxDecoration(
                                borderRadius: borderRadiusCircular(),
                                color: colorBrandPrimary(),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Salvar',
                                      style: TextStyle(
                                          color: colorNeutralHighPure(),
                                          fontSize: 16
                                      )
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              print(valorFieldController.text);
                              widget.produto.valor = valorFieldController.text;
                              if(widget.produto.valor.length > 3 && widget.produto.valor.length < 6){
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/cartaz',
                                  arguments: widget.produto,
                                );
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
