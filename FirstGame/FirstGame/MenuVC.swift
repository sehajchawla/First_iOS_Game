//
//  MenuVC.swift
//  FirstGame
//
//  Created by Sehaj Chawla on 31/03/18.
//  Copyright © 2018 Sehaj Chawla. All rights reserved.
//

import Foundation
import UIKit

//basically like a switch statement
enum gameType {
    case easy
    case medium
    case hard
    case player2
}

//remember to link the correct view controller to this class, make sure you're selecting the view controller and not the view (look for the blue outline)
class MenuVC: UIViewController {
    
    
    //these are the methods called when each of the buttons are pressed (connected using control drag)
    
    @IBAction func player2(_ sender: Any) {
        moveToGame(game: gameType.player2)
        print("player2")
    }
    
    @IBAction func hard(_ sender: Any) {
        moveToGame(game: gameType.hard)
        print("hard")
    }
    
    @IBAction func easy(_ sender: Any) {
        moveToGame(game: gameType.easy)
        print("easy")
    }
    @IBAction func medium(_ sender: Any) {
        moveToGame(game: gameType.medium)
        print("medium")
    }
    
    
    
    
    
    //function input is the enum on top
    func moveToGame(game: gameType) {
     
        //moves you to the game controller
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
    self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
