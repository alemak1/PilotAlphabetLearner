//
//  HealthComponent.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class HealthComponent: GKComponent{
    
    
    let startingHealth: Int
    var currentHealth: Int
    
    
    init(startingHealth: Int){
        self.startingHealth = startingHealth
        self.currentHealth = startingHealth
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func decreasePlayerHealth(amount: Int){
        currentHealth -= amount
    }
    
    func increasePlayerHealth(amount: Int){
        currentHealth += amount
    }
    
    func restoreFullPlayerHealth(){
        currentHealth = startingHealth
    }
}
