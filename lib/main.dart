import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()=> runApp(MyCalculator());

class MyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title:"",
      home:Calculator()
    );
  }
}
class Calculator extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Calculator();
  }
}
class _Calculator extends State<Calculator>{
  dynamic text ='0';
  dynamic numOne =0;
  dynamic numTwo =0;

  dynamic result = '0';
  dynamic finalResult ='0';
  dynamic opr = '';
  dynamic preOpr = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
       return Scaffold(
         appBar: null,
         backgroundColor: Colors.black,
         body: Container(
           margin: EdgeInsets.only(bottom: 20),
           child: Column(
             mainAxisAlignment:MainAxisAlignment.end,
             children:<Widget> [
               Row(
                 children:<Widget> [
                   Expanded(
                     child: Text(text,
                     style:TextStyle(
                       color: Colors.white,
                        fontSize: 60),
                       maxLines: 1,
                        textAlign : TextAlign.right,
                      ),
                   )
                 ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                children:<Widget> [
                  button('C',Color(0xffa5a5a5),1),
                  button('+/-',Color(0xffa5a5a5),1),
                  button('%',Color(0xffa5a5a5),1),
                  button('/',Color(0xffff9800),1),

                ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                 children:<Widget> [
                   button('7',Color(0xff323232),1),
                   button('8', Color(0xff323232),1),
                   button('9',Color(0xff323232),1),
                   button('x',Color(0xffff9800),1),

                 ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                 children:<Widget> [
                   button('4',Color(0xff323232),1),
                   button('5', Color(0xff323232),1),
                   button('6',Color(0xff323232),1),
                   button('-',Color(0xffff9800),1),

                 ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                 children:<Widget> [
                   button('1',Color(0xff323232),1),
                   button('2', Color(0xff323232),1),
                   button('3',Color(0xff323232),1),
                   button('+',Color(0xffff9800),1),

                 ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                 children:<Widget> [
                   button('0',Color(0xff323232),0),
                   button('.', Color(0xff323232),1),
                   button('=',Color(0xffff9800),1),

                 ],
               )

             ],
           ),
         ),
      );
   }


Widget button (String btnText, Color color , int num) {
  Container container;
  if (num == 0) {
    container = Container(
      padding: EdgeInsets.only(bottom: 10),
      child: RaisedButton(
        onPressed: () {
          calculate(btnText);
        },
        child: Text(btnText,
          style: TextStyle(
              fontSize: 30
          ),
        ),
        color: color,
        padding: EdgeInsets.only(left: 81,top: 20,right:81,bottom: 20),
        shape:StadiumBorder(),
      ),
    );
  }
  else {
    container=Container(
      padding: EdgeInsets.only(bottom: 10),
      child: RaisedButton(
        onPressed: () {
          calculate(btnText);
        },
        child: Text(btnText,
          style: TextStyle(
              fontSize: 30
          ),
        ),
        color: color,
        padding: EdgeInsets.all(20),
        shape: CircleBorder(),
      ),
    );
  }
  return container;
}
  void calculate (textBtn){
    if(textBtn=='C'){
      text='0';
      numOne =0;
      numTwo=0;
      result = '';
      finalResult= '0';
      opr = '';
      preOpr = '';
    }                    //تصفير الاله
    else if (textBtn == '%'){
      result = (numOne / 100).toString();
      finalResult = result;
    }            //في الميييه
    else if (textBtn == '.'){
       if(!result.contains('.'))
         result += '.';
       finalResult= result;
    }
    else if (textBtn == '+/-'){
      result.startsWith('-') ? result = result.substring(1):result ='-' +result;
      finalResult=result;
    }
    else if (opr == '=' && textBtn == '=' )
      {
        switch(preOpr){
          case '+':
            finalResult = add();


            break;
          case '-':
            finalResult = sub();

            break;
          case 'x':
            finalResult = mul();

            break;
          case '/':
            finalResult =  div();

            break;

        }


      }

    else if(textBtn== '+' ||textBtn== '-' ||textBtn== 'x' ||textBtn== '/' ||textBtn== '=' ) {

      if (numOne==0 ) {
        numOne = double.parse(result);
      } else
        {
          numTwo= double.parse(result);
        }
      switch(opr){
        case '+':
          finalResult = add();
          break;
        case '-':
           finalResult = sub();
          break;
        case 'x':
           finalResult = mul();
          break;
        case '/':
          finalResult =  div();
          break;

      }
      preOpr = opr;
      opr = textBtn;
      result = '';
    }
    else{
      if(result == '0' )
        result =textBtn;
      else
      result = result + textBtn;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });
  }

  String add(){
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return decimalRemove (result);
  }
  String sub(){
    result = (numOne - numTwo).toString();
    numOne = double.parse(finalResult);

    return decimalRemove (result) ;
  }
  String mul(){
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return decimalRemove (result);
  }
  String div(){
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    numTwo = double.parse(finalResult);
    return decimalRemove (result);
  }
  String decimalRemove(String _result){
    if (_result.contains('.')){
      List<String> split = _result.split('.');
      if(!(int.parse(split[1])>0))
        return split[0];
    }
    return _result;
  }
}