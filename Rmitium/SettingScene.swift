//
//  SettingScene.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/30/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
import SpriteKit

class SettingScene: SKScene {
    var settings: [SKSpriteNode] = []
    var values: [Bool] = [true, true, true]
    var state: Int!
    
    override func didMoveToView(view: SKView) {
        UtilitiesPortal.score = 0
        state = UtilitiesPortal.stateAnswer
        
        // Home button
        let home = SKSpriteNode(imageNamed: "home")
        home.name = UtilitiesPortal.homeButtonName
        home.zPosition = 0.1
        home.alpha = 1
        home.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        home.position = CGPoint(x:UtilitiesPortal.borderSize/2,
                                y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(home)
        
        // Setting label
        let levelLabel = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        levelLabel.zPosition = 0.1
        levelLabel.text = UtilitiesPortal.levelLabelTexts[3]
        levelLabel.fontSize = UtilitiesPortal.navLabelSize
        levelLabel.position = CGPointMake(frame.midX, UtilitiesPortal.screenHeight*0.92)
        self.addChild(levelLabel)
        
        // Generating level buttons
        for count in 0...2 {
            let levelLabel = SKLabelNode(fontNamed:UtilitiesPortal.levelLabelFont)
            levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
            levelLabel.zPosition = 0.2
            levelLabel.name = UtilitiesPortal.settingLabelNames[count]
            levelLabel.text = UtilitiesPortal.settingLabelTexts[count]
            levelLabel.fontSize = UtilitiesPortal.levelLabelSize
            levelLabel.position = CGPointMake(UtilitiesPortal.screenWidth*0.4,
                UtilitiesPortal.screenHeight*(0.60-CGFloat(count)*0.15))
            self.addChild(levelLabel)
            
            let levelButton = SKSpriteNode(imageNamed: "sound-on")
            levelButton.name = UtilitiesPortal.settingLabelButtons[count]
            levelButton.alpha = 0.9
            levelButton.zPosition = 0.1
            levelButton.position = CGPointMake(UtilitiesPortal.screenWidth*0.6,
                                               UtilitiesPortal.screenHeight*(0.62-CGFloat(count)*0.15))
            levelButton.size = CGSize(width: UtilitiesPortal.navImgSize,
                                      height: UtilitiesPortal.navImgSize)
            self.addChild(levelButton)
            settings.append(levelButton)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if node.name == UtilitiesPortal.homeButtonName {
            let secondScene = GameScene(size: self.size)
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
            //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
        }
        
        // Sound
        if (node.name == UtilitiesPortal.settingLabelNames[0] ||
            node.name == UtilitiesPortal.settingLabelButtons[0]) {
            if values[0] {
                values[0] = false
                settings[0].texture = SKTexture(imageNamed: "sound-off")
            }
            else {
                values[0] = true
                settings[0].texture = SKTexture(imageNamed: "sound-on")
            }
        }
        
        if (node.name == UtilitiesPortal.settingLabelNames[1] ||
            node.name == UtilitiesPortal.settingLabelButtons[1]) {
            if values[1] {
                values[1] = false
                settings[1].texture = SKTexture(imageNamed: "sound-off")
            }
            else {
                values[1] = true
                settings[1].texture = SKTexture(imageNamed: "sound-on")
            }
        }
        
        if (node.name == UtilitiesPortal.settingLabelNames[2] ||
            node.name == UtilitiesPortal.settingLabelButtons[2]) {
            if values[2] {
                values[2] = false
                settings[2].texture = SKTexture(imageNamed: "sound-off")
            }
            else {
                values[2] = true
                settings[2].texture = SKTexture(imageNamed: "sound-on")
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
