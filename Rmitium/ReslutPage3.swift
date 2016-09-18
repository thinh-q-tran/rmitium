//
//  ReslutPage3.swift
//  Rmitium
//
//  Created by Max on 13/09/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

/*

w/h=x/y = 2.483

355/145
w/355=



*/

import SpriteKit
import Social

class ResultPage3: SKScene{
    var facebook, twitter, redo, next: CustomButton!
    var homeDialogue,homeView :SKSpriteNode!
    var text :SKMultilineLabel!
    override func didMoveToView(view: SKView) {
     
        
        setupItem()
        setupCusterButton()
        setupMedal()
        createHomeDialogue()
        
    }
    func setupItem(){
        
        let levelLabel = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        levelLabel.zPosition = 0.1
        levelLabel.text = UtilitiesPortal.levelLabelTexts[2]
        levelLabel.fontSize = UtilitiesPortal.navLabelSize
        levelLabel.position = CGPointMake(frame.midX, UtilitiesPortal.screenHeight*0.92)
        self.addChild(levelLabel)
        
        // Home button
        let home = SKSpriteNode(imageNamed: "home")
        home.name = UtilitiesPortal.homeButtonName
        home.zPosition = 0.1
        home.alpha = 1
        home.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        home.position = CGPoint(x:UtilitiesPortal.borderSize/2,
                                y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(home)
        
        // Info button
        let info = SKSpriteNode(imageNamed: "help2")
        info.name = UtilitiesPortal.infoButonName
        info.zPosition = 0.1
        info.alpha = 1
        info.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        info.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
                                y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(info)
        
     
    }
    func setupCusterButton(){
        
        facebook = CustomButton(defaultButtonImage: "facebookbutton", activeButtonImage: "facebookbutton1", buttonAction: facebookAction,scale: 0.2)
        facebook.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*3,
                                    y: UtilitiesPortal.screenHeight * 0.8)
        facebook.name = "facebook"
        facebook.frame.width
        
        twitter = CustomButton(defaultButtonImage: "twitterbutton", activeButtonImage: "twitterbutton1", buttonAction: twitterAction,scale: 0.2)
        twitter.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*3,
                                   y: UtilitiesPortal.screenHeight * 0.6)
        twitter.name = "twitter"
        
        
        redo = CustomButton(defaultButtonImage: "retrybutton", activeButtonImage: "retrybutton1", buttonAction: redoAction,scale: 0.2)
        redo.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*3,
                                y: UtilitiesPortal.screenHeight * 0.4)
        redo.name = "redo"
        
        
        next = CustomButton(defaultButtonImage: "nextbutton", activeButtonImage: "nextbutton1", buttonAction: nextAction, scale: 0.2)
        next.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*3,
                                y: UtilitiesPortal.screenHeight * 0.2)
        next.name = "next"
        //next.setScale(scale1)
        
        addChild(facebook)
        addChild(twitter)
        addChild(redo)
        addChild(next)
    }
    
    func setupMedal(){
        
        //medalNode.texture = SKTexture(imageNamed: "Medal5-Rust")
        let medalDic = medalClass().assignMedal()
        let medalName = medalDic.medalName
        let infomation = medalDic.information
        let medalNode = SKSpriteNode(imageNamed: medalName)
        medalNode.color = SKColor.blueColor()
        medalNode.name = "medal"
        medalNode.position = CGPoint(x: UtilitiesPortal.screenWidth / 3, y: UtilitiesPortal.screenHeight / 1.8)
        medalNode.size = CGSize(width: UtilitiesPortal.screenWidth/3*1.1, height: UtilitiesPortal.screenWidth / 3)
        medalNode.zPosition = 0.1
        
        let action = SKAction.rotateToAngle(CGFloat(M_PI/2), duration: 5)
        let action1 = SKAction.rotateToAngle(CGFloat(-M_PI/2), duration: 5)
        let sequen = SKAction.sequence([action,action1])
        let repeatAction = SKAction.repeatActionForever(sequen)
        addChild(medalNode)
        medalNode.runAction(repeatAction)
        
        let p = CGPoint(x: UtilitiesPortal.screenWidth*0.35, y: UtilitiesPortal.screenHeight*0.3)
        text = SKMultilineLabel(text: infomation, labelWidth: UtilitiesPortal.screenWidth*0.6, pos: p)
        text.alignment = .Left
        text.leading =  Int(UtilitiesPortal.screenHeight*0.1)
        text.fontSize = UtilitiesPortal.screenHeight*0.05
        addChild(text)
    }
    
    func facebookAction() {
        print("facebook")
        let controller = self.view?.window?.rootViewController as! GameViewController
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let facebookController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookController.setInitialText("My score is\(UtilitiesPortal.score)")
            // facebookController.addImage(UIImage(named: "next"))
            controller.presentViewController(facebookController, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Facebook Unavailable", message: "Be sure to go to Settings > Facebook to set up your account", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            controller.presentViewController(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func twitterAction() {
        print("twitter")
        let controller = self.view?.window?.rootViewController as! GameViewController
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            let facebookController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            facebookController.setInitialText("My score is\(UtilitiesPortal.score)")
            //facebookController.addImage(UIImage(named: "next"))
            controller.presentViewController(facebookController, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Twitter Unavailable", message: "Be sure to go to Settings > Twitter to set up your account", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            controller.presentViewController(alert, animated: true, completion: nil)
        }
    }
    func redoAction() {
        UtilitiesPortal.score = 0
        backLevel3()
    }
    func nextAction() {
        backHomePage()
    }
    
    // Share the score to any social media!
    func displayShareSheet(shareContent:String) {
        
        let myShare = "My best is \(shareContent)"
        let controller = self.view?.window?.rootViewController as! GameViewController
        
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [myShare], applicationActivities: nil)
        
        controller.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    //back to the home page,
    func backHomePage() {
        UtilitiesPortal.score = 0
        UtilitiesPortal.totalQuestions = 0
        cleanScene()
        
        let secondScene = GameScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    func backLevel3(){
        UtilitiesPortal.score = 0
        LevelThreeModel.reset()
        cleanScene()
        
        let secondScene = LevelThreeScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
        //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func willMoveFromView(view: SKView) {
        self.removeAllActions()
        self.removeAllChildren()
        print("Remove all nodes Lvl 3 Scene")
    }
    
    func cleanScene() {
        if let s = self.view?.scene {
            NSNotificationCenter.defaultCenter().removeObserver(self)
            self.enumerateChildNodesWithName("//") { node, _ in
                node.removeAllActions()
                node.removeAllChildren()
                node.removeFromParent()
            }
            s.removeAllActions()
            s.removeAllChildren()
            s.removeFromParent()
        }
        print("Clean Lvl 3 Scene")
    }
    func createHomeDialogue() {
        homeView  = SKSpriteNode()
        homeView.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        homeView.position = CGPoint(x: UtilitiesPortal.screenWidth/2.5, y: UtilitiesPortal.screenHeight/2)
        homeView.zPosition = 0.8
        // homeView.color = SKColor.redColor()
        homeView.alpha = 1
        homeView.hidden = true
        let yesBtn = SKSpriteNode()
        let noBtn = SKSpriteNode()
        
        let alertMessage = SKLabelNode(text: "Are you sure you want to quit?")
        alertMessage.position = CGPoint(x: 0, y: 0)
        alertMessage.zPosition = 0.9
        alertMessage.fontName = UtilitiesPortal.navLabelFont
        alertMessage.fontSize = 15
        homeDialogue = SKSpriteNode()
        homeDialogue.size = CGSize(width: UtilitiesPortal.screenWidth/2.5, height: UtilitiesPortal.screenHeight/2.5)
        homeDialogue.position = CGPoint(x: UtilitiesPortal.screenWidth/11, y: UtilitiesPortal.screenHeight/11)
        homeDialogue.color = SKColor.blackColor()
        homeDialogue.alpha = 0.9
        homeDialogue.zPosition = 0.9
        homeDialogue.hidden = false
        
        yesBtn.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        yesBtn.color = SKColor.grayColor()
        yesBtn.name = UtilitiesPortal.yesButtonName
        yesBtn.texture = SKTexture(imageNamed: "tick-white")
        yesBtn.position = CGPoint(x: (0 - yesBtn.size.width), y: (0 - yesBtn.size.height)*1.5)
        yesBtn.zPosition = 0.9
        
        noBtn.size = yesBtn.size
        noBtn.color = yesBtn.color
        noBtn.name = UtilitiesPortal.noButtonName
        noBtn.texture = SKTexture(imageNamed: "cross-white")
        noBtn.position = CGPoint(x: yesBtn.size.width, y: (0 - yesBtn.size.height)*1.5)
        noBtn.zPosition = 0.9
        
        homeDialogue.addChild(yesBtn)
        homeDialogue.addChild(noBtn)
        homeDialogue.addChild(alertMessage)
        homeView.addChild(homeDialogue)
        //addChild(homeDialogue)
        addChild(homeView)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        
        // Home button selected
        let location = touch!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if node.name == UtilitiesPortal.homeButtonName {
            print("Home!")
            homeView.hidden = false
            
            //homeDialogue.hidden = false
            
        }
        if node.name == UtilitiesPortal.yesButtonName {
            backHomePage()
            return
        }
        if node.name == UtilitiesPortal.noButtonName {
            //homeDialogue.hidden = true
            homeView.hidden = true
            
            return
        }
        
        
        
        
    }
}
