import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Slidesshow extends StatelessWidget {


  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;
  final double tamPuntoSeleccionado;
  final double tamPunto;

  Slidesshow({
    @required this.slides, 
    this.puntosArriba = false, 
    this.colorPrimario = Colors.blue, 
    this.colorSecundario = Colors.grey, 
    this.tamPuntoSeleccionado = 12, 
    this.tamPunto = 12
    });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> new _SlideshowModel(),
      child: Center(
    child: Builder(builder: (BuildContext context) { 

      Provider.of<_SlideshowModel>(context).colorPrimario = this.colorPrimario;
      Provider.of<_SlideshowModel>(context).colorSecundario = this.colorSecundario;
      Provider.of<_SlideshowModel>(context).tamPuntoSeleccinado = this.tamPuntoSeleccionado;
      Provider.of<_SlideshowModel>(context).tamPunto = this.tamPunto;

      return _CrearEstructuraSlides(puntosArriba: puntosArriba, slides: slides);
     },)
  ),
      );
    
  }
}

class _CrearEstructuraSlides extends StatelessWidget {
  const _CrearEstructuraSlides({
    Key key,
    @required this.puntosArriba,
    @required this.slides,
  }) : super(key: key);

  final bool puntosArriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(this.puntosArriba) _Dots( this.slides.length ),
        Expanded(child: _Slides( this.slides)),
        if(!this.puntosArriba) _Dots( this.slides.length ),

      ],
    );
  }
}



class _Dots extends StatelessWidget {

  final int cantidadPuntos;

  _Dots(this.cantidadPuntos);

  //const _Dots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(this.cantidadPuntos, (index) => _Dot(index))
      ),
    );
  }
}

class _Dot extends StatelessWidget {

  final int index;

  _Dot(this.index);


  @override
  Widget build(BuildContext context) {

final ssModel = Provider.of<_SlideshowModel>(context);
double tamano;
Color color;

if ( ssModel.currentPage >= index - 0.5 && ssModel.currentPage < index + 0.5){
   tamano = ssModel.tamPuntoSeleccinado;
   color = ssModel.colorPrimario;
}
else{
   tamano = ssModel.tamPunto;
   color = ssModel.colorSecundario;
}

    return Container(
      width: tamano,
      height: tamano,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color
      ),
    );
  }
}


class _Slides extends StatefulWidget {

    final List<Widget> slides;

  _Slides(this.slides);



  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {

  final pageviewController = new PageController();

  @override
  void dispose() {
    pageviewController.dispose();
  }

  @override
  void initState() {
    super.initState();

    pageviewController.addListener(() {
      Provider.of<_SlideshowModel>(context, listen: false).currentPage = pageviewController.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageviewController,
        children: widget.slides.map((child) => _Slide(child)).toList()
      ),
    );
  }
}

class _Slide extends StatelessWidget {

final Widget slide;

  _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(10),
      child: slide);
  }
}



class _SlideshowModel with ChangeNotifier{

  double _currentPage = 0;
  Color _colorPrimario = Colors.blue;
  Color _colorSercundario = Colors.grey;
  double _tamPuntoSelec = 12;
  double _tamPunto = 12;

  double get currentPage => this._currentPage;
  Color get colorPrimario => this._colorPrimario;
  Color get colorSecundario => this._colorSercundario;
  double get tamPuntoSeleccinado => this._tamPuntoSelec;
  double get tamPunto => this._tamPunto;

  set currentPage(double currentPage ){
    this._currentPage = currentPage;
    notifyListeners();
  }

    set colorPrimario(Color color ){
    this._colorPrimario = color;
  }

    set colorSecundario(Color color ){
    this._colorSercundario = color;
  }

    set tamPuntoSeleccinado(double tamano) { 
      this._tamPuntoSelec = tamano;
    }
    set tamPunto(double tamano) { 
      this._tamPunto = tamano;
    }

}