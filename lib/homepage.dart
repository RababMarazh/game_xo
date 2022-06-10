
import 'package:flutter/material.dart';

import 'game_logic.dart';

class HomePage extends StatefulWidget {
 

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer ='X';
  bool gameOver = false;
  int turn =0;
  String result ='';
  Game game =Game();
  bool isSwitched =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child:
        Column(
          children: [
            SizedBox(height: 20,),
            SwitchListTile.adaptive(
              activeColor: Color.fromARGB(255, 99, 170, 101),
              //tileColor: Colors.black,
              title:const Padding(
                padding:  EdgeInsets.all(12.0),
                child: Center(
                  child: Text('Turn on/off tow player',
                  style:TextStyle(color: Colors.white,fontSize: 20) ,
                  
                  ),
                ),
              ),
              value: isSwitched, 
              onChanged: (bool newValue){
                setState(() {
                  isSwitched=newValue;
                });
              }
              ),
              SizedBox(height: 20,),
              Text('its $activePlayer turn',
              style:const TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
              ),
              
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(16),
                   mainAxisSpacing : 8.0,
                   crossAxisSpacing : 8.0,
                   childAspectRatio : 1.0,
                  crossAxisCount: 3,
                  children: 
                    List.generate(9,(index)=>
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap:gameOver?null:()=>_onTap(index),
                      child: Container(
                        decoration:
                        BoxDecoration(color:Theme.of(context).shadowColor,
                        borderRadius: BorderRadius.circular(16)
                         ) ,



                        child: Center(
                          child: Text(player.playerX.contains(index)?'X':
                                      player.playerO.contains(index)?'O':'',
                          style: TextStyle(
                            color: player.playerX.contains(index)?Colors.lightBlueAccent:Colors.white,
                            fontSize: 52

                          ),
                          ),
                        ) ,),
                      
                    )
                    )
                  ,
                  )),
                   Text(result,
              style:const TextStyle(
                color: Colors.yellow,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
              ),
              SizedBox(height: 50,),

              ElevatedButton.icon(
               
                icon:const Icon(Icons.replay), 
                label: const Text('Repeat the game'),
                 onPressed: (){
                   setState(() {
                     player.playerO=[];
                     player.playerX=[];
                        activePlayer ='X';
                        gameOver = false;
                        turn =0;
                        result ='';
                   });
                 },
                 style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all(Theme.of(context).shadowColor)
                  
                ), )

          ],
        ) ,),
    );
  }


  

  _onTap(int index)async {
  
   if ((player.playerX.isEmpty||!player.playerX.contains(index))&&
       (player.playerO.isEmpty||!player.playerO.contains(index))) 
   {
      game.playGame(index,activePlayer);
      updateState();


      if (!isSwitched &&!gameOver&&turn!=9) {
       await game. autoPlay(activePlayer);
       updateState();
      }
   }
  
    
  }

  void updateState(){
    setState(() {
      activePlayer=(activePlayer=='X')?'O':'X';
      turn++;
      String winnerPlayer=game.checkWinner();
      
      if (winnerPlayer!='') {
        gameOver=true;
        result='$winnerPlayer is the winner';
        
        
                
      }
      else if(!gameOver && turn==9){
        result="it's Draw";
      }

    });
  }
}