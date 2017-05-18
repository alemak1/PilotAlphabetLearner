//
//  SavedGameDetailViewController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/13/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit


class SavedGameDetailViewController: UIViewController{
    
    
    
    //MARK: ******** Scene Name
    
    @IBOutlet weak var sceneNameLabel: UILabel!
   
    
    //MARK: ******* Date Saved Info
    
    @IBOutlet weak var datePicker: UIDatePicker!
   
    
    //MARK: ******** Plane Type
    
    @IBOutlet weak var planeColorSegmentedControl: UISegmentedControl!
    
    
    //MARK: ****** Player Coin Count Information
    
    @IBOutlet weak var bronzeCountLabel: UILabel!
    
    @IBOutlet weak var silverCountLabel: UILabel!
    
    @IBOutlet weak var goldCountLabel: UILabel!
    
    //MARK: ****** Player Health State Information
    
  
    @IBOutlet weak var damageStatusSwitch: UISwitch!
    
    
    @IBOutlet weak var healthSegmentedControl: UISegmentedControl!
    
    
    //MARK: ****** Player Position Information
    
    @IBOutlet weak var xPositionLabel: UILabel!
 
    @IBOutlet weak var yPositionLabel: UILabel!
    
    @IBAction func loadSavedGame(_ sender: UIBarButtonItem) {
        
        let currentVerticalSizeClass = traitCollection.verticalSizeClass
        
        let longSide = currentVerticalSizeClass == .compact ? view.bounds.size.width : view.bounds.size.height
        
        let shortSide = currentVerticalSizeClass == .compact ? view.bounds.size.height : view.bounds.size.height
        
        let aspectRatio = shortSide/longSide
        
        let itemWidth = longSide*0.50
        let itemHeight = itemWidth*aspectRatio*1.5
        
        let levelViewLayout = UICollectionViewFlowLayout()
        levelViewLayout.scrollDirection = .horizontal
        levelViewLayout.sectionInset = UIEdgeInsets(top: 0.00, left: 20.00, bottom: 0.00, right: 20.00)
        levelViewLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        
        ///Initialize LevelViewController
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let levelViewController = LevelViewController(collectionViewLayout: levelViewLayout)
        
        levelViewController.view.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
        
        levelViewController.managedContext = managedContext
        levelViewController.collectionView?.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
        
        let reloadData = ReloadData(letterScene: .LetterA_Scene, planeColor: .Blue, playerXPos: 4000.00, playerYPos: -200.0, playerXVelocity: 50.0, playerYVelocity: 12.0, playerHealth: 3, playerGoldCoins: 1, playerSilverCoins: 1, playerBronzeCoins: 1, isDamaged: false)
        
        present(levelViewController, animated: true, completion: {
            
            
            levelViewController.reloadSavedGame(reloadData: reloadData)
            
        })
        
       /**
        if let goldCoinCount = goldCoinCount, let silverCoinCount = silverCoinCount, let bronzeCoinCount = bronzeCoinCount, let xVelocity = xVelocityValue, let yVelocity = yVelocityValue, let xPos = xPosValue, let yPos = yPosValue, let sceneLabelText = sceneLabelText,  let letterScene = LetterScene(rawValue: sceneLabelText), let planeColorString = planeColor, let playerPlaneColor = Player.PlaneColor(rawValue: planeColorString), let healthLevel = healthLevel{
            
            
            let reloadData = ReloadData(letterScene: letterScene, planeColor: playerPlaneColor, playerXPos: xPos, playerYPos: yPos, playerXVelocity: xVelocity, playerYVelocity: yVelocity, playerHealth: healthLevel, playerGoldCoins: goldCoinCount, playerSilverCoins: silverCoinCount, playerBronzeCoins: bronzeCoinCount)
            
            present(levelViewController, animated: true, completion: {
                
                
                levelViewController.reloadSavedGame(reloadData: reloadData)
                
                })
            
        }
        **/
     
        
    }
    
    //MARK: ******* Player Velocity Information
    
    @IBOutlet weak var xVelocity: UILabel!
 
    @IBOutlet weak var yVelocity: UILabel!
    
    
    //Optional variables for storing data used to populate corresponding UIElements on the storyboard file
    
    
    var reloadData: ReloadData?
    
    var saveDate: Date?
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadSavedGameInformation()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        
    }
    
    
    func loadSavedGameInformation(){
        
        
        if let reloadData = reloadData, let saveDate = saveDate{
            sceneNameLabel.text = reloadData.letterScene.rawValue
            
            
            bronzeCountLabel.text = "Bronze: \(reloadData.playerBronzeCoins)"
            silverCountLabel.text = "Silver: \(reloadData.playerSilverCoins)"
            goldCountLabel.text = "Gold: \(reloadData.playerGoldCoins)"
            
            
            let formattedXVelocityText = getFormattedNumberString(forDataItem: reloadData.playerXVelocity)
            let formattedYVelocityText = getFormattedNumberString(forDataItem: reloadData.playerYVelocity)
            
            xVelocity.text = formattedXVelocityText
            yVelocity.text = formattedYVelocityText
            
            
            let formattedYPositionText = getFormattedNumberString(forDataItem: reloadData.playerYVelocity)
            let formattedXPositionText = getFormattedNumberString(forDataItem: reloadData.playerXVelocity)
            
            yPositionLabel.text = formattedYPositionText
            xPositionLabel.text = formattedXPositionText
            
            damageStatusSwitch.isOn = reloadData.isDamaged
            
            healthSegmentedControl.selectedSegmentIndex = reloadData.playerHealth

            datePicker.date = saveDate

            for index in 0..<planeColorSegmentedControl.numberOfSegments{
                
                if planeColorSegmentedControl.titleForSegment(at: index) == reloadData.planeColor.rawValue{
                    planeColorSegmentedControl.selectedSegmentIndex = index
                    
                }
            }
            
        }
     
        
    
       
        
        
    }
    
    
    func getFormattedNumberString(forDataItem dataItem: Double) -> String{
        
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        
        let wrappedNumber = NSNumber(value: dataItem)
        
        guard let formattedNumberString = numberFormatter.string(from: wrappedNumber) else {
            return "\(dataItem)"
        }
        
        return formattedNumberString
    }
    
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .portrait
    }
    
   
    
}
