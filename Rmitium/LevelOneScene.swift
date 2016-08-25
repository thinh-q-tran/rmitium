//
//  LevelOneScene.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/8/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import SpriteKit

class LevelOneScene: SKScene {
    var answers: [CustomSKSpriteNode] = []
    var questions: [CustomSKSpriteNode] = []
    var answeredQuestions: [CustomSKSpriteNode] = []
    var positions = [Position]()
    var currentAnswerPostions: [CGPoint] = []
    var chosenAnswer: CustomSKSpriteNode!
    var resultImage, factOverlay: SKSpriteNode!
    var factOverlayText: SKMultilineLabel!
    var show, tick, redo, share, back: SKSpriteNode!
    var score, factLabel: SKLabelNode!
    
    var lvlOneQuestion: LevelOneQuestion!
    var state: Int!
    
    override func didMoveToView(view: SKView) {
        setupScene()
    }
    
    func setupScene() {
        
        self.removeAllChildren()
        positions.removeAll()
        questions.removeAll()
        answeredQuestions.removeAll()
        
        lvlOneQuestion = LevelOneModel.sharedInstance.currentQuestion
        state = UtilitiesPortal.stateAnswer
        
        setupImage()
        
        setupItems()
        
        setupDragLabel()
        setupTargets()
        setupFactLabel("Morphine has a high potential for addiction; during the American Civil War, around 400 000 soldiers became addicted to morphine.")
        
    }
    func setupItems() {
        let levelLabel = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        levelLabel.zPosition = 0.1
        levelLabel.text = UtilitiesPortal.levelLabelTexts[0]
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
        
        // Tick button
        tick = SKSpriteNode(imageNamed: "tick-grey")
        tick.name = UtilitiesPortal.tickButtonName
        tick.zPosition = 0.1
        tick.alpha = 0.9
        tick.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        tick.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize,
                                y: UtilitiesPortal.navImgSize/2)
        addChild(tick)
        
        // Show button
        show = SKSpriteNode(imageNamed: "show")
        show.name = UtilitiesPortal.showButtonName
        show.zPosition = 0.1
        show.alpha = 0.9
        show.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        show.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*2,
                                y: UtilitiesPortal.navImgSize/2)
        addChild(show)
        
        // Help button
        let help = SKSpriteNode(imageNamed: "help2")
        help.zPosition = 0.1
        help.alpha = 0.9
        help.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        help.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
                                y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(help)
        
        // Score label
        score = SKLabelNode(fontNamed:UtilitiesPortal.factFont)
        score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        score.zPosition = 0.1
        score.text = "\(UtilitiesPortal.scoreText) \(UtilitiesPortal.score)"
        score.fontSize = UtilitiesPortal.factSize
        score.position = CGPointMake(UtilitiesPortal.borderSize/4, UtilitiesPortal.borderSize/4)
        self.addChild(score)
    }
    func setupImage(){
        // Image
        let image = SKSpriteNode(imageNamed: lvlOneQuestion.imageName)
        image.zPosition = 0.1
        image.alpha = 0.9
        image.position = CGPoint(x:UtilitiesPortal.borderSize+UtilitiesPortal.imageWidth/2,
                                 y:UtilitiesPortal.screenHeight/2 )
        image.size = CGSize(width: UtilitiesPortal.imageWidth, height: UtilitiesPortal.imageHeight)
        addChild(image)
        
    }
    
    func setupDragLabel() {
        for count in 0...UtilitiesPortal.levelOneAnswers.count-1 {
            let answer = CustomSKSpriteNode(imageNamed: UtilitiesPortal.levelOneAnswers[count])
            answer.name = UtilitiesPortal.levelOneAnswers[count]
            answer.value = UtilitiesPortal.levelOneAnswers[count]
            answer.zPosition = 0.3
            answer.alpha = 0.9
            answer.size = CGSize(width: UtilitiesPortal.screenWidth*0.15,
                                 height: UtilitiesPortal.screenHeight*0.1)
            
            if count < 5 {
                answer.position = CGPoint(x:UtilitiesPortal.screenWidth*0.75,
                                          y:UtilitiesPortal.screenHeight*(0.8-0.1*CGFloat(count)))
            }
            else if count < 10 {
                answer.position = CGPoint(x:UtilitiesPortal.screenWidth*0.90,
                                          y:UtilitiesPortal.screenHeight*(0.8-0.1*CGFloat(count-5)))
            }
            else {
                answer.position = CGPoint(x:UtilitiesPortal.screenWidth*0.85,
                                          y:UtilitiesPortal.screenHeight*(0.8-0.1*CGFloat(count-5)))
            }
            
            addChild(answer)
            answers.append(answer)
            currentAnswerPostions.append(answer.position)
        }
    }
    
    func setupTargets() {
        for x in 0...lvlOneQuestion.positions.count-1 {
            positions.append(lvlOneQuestion.positions[x])
        }
        
        for count in 0...positions.count-1 {
            let sprite = CustomSKSpriteNode()
            sprite.color = UIColor.blueColor()
            sprite.alpha = 0
            sprite.name = "question\(count)"
            sprite.size = CGSizeMake(UtilitiesPortal.screenWidth*0.25, UtilitiesPortal.screenHeight*0.15)
            sprite.zPosition = 0.2
            sprite.position = CGPoint(x:UtilitiesPortal.screenWidth * positions[count].x,
                                      y:UtilitiesPortal.screenHeight * positions[count].y)
            addChild(sprite)
            questions.append(sprite)
            
            let answeredQuestion = CustomSKSpriteNode(imageNamed: UtilitiesPortal.levelOneAnswers[0])
            answeredQuestion.name = UtilitiesPortal.emptyString
            answeredQuestion.value = UtilitiesPortal.emptyString
            answeredQuestion.zPosition = 0.2
            answeredQuestion.alpha = 1
            answeredQuestion.hidden = true
            answeredQuestion.position = sprite.position
            answeredQuestion.size = CGSize(width: UtilitiesPortal.screenWidth*0.15,
                                           height: UtilitiesPortal.screenHeight*0.1)
            addChild(answeredQuestion)
            answeredQuestions.append(answeredQuestion)
        }
    }
    
    // Adding Fact label
    func setupFactLabel(fact: String){
        //let randomIndex = Int(arc4random_uniform(UInt32(array.)))
        //print(array[randomIndex])
        let fact = fact
        let index = fact.startIndex.advancedBy(8)
        let shortenFact = fact.substringToIndex(index)
        
        factLabel = SKLabelNode(fontNamed: UtilitiesPortal.navLabelFont)
        factLabel.name = UtilitiesPortal.factLabelName
        factLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        factLabel.fontSize = UtilitiesPortal.factSize
        factLabel.text = "Did you know: " + shortenFact + "...(see more)"
        factLabel.hidden = true
        factLabel.zPosition = 0.3
        factLabel.position = CGPoint(x: UtilitiesPortal.screenWidth*0.20, y: UtilitiesPortal.borderSize/4)
        addChild(factLabel)
        
        factOverlayText = SKMultilineLabel(text: fact, labelWidth: UtilitiesPortal.screenWidth,
                                           pos: CGPoint(x: 0, y: 0),fontName: UtilitiesPortal.navLabelFont,
                                           fontSize: UtilitiesPortal.navLabelSize,
                                           leading: Int(UtilitiesPortal.navLabelSize))
        factOverlayText.name = UtilitiesPortal.factMultiLine
        factOverlayText.zPosition = 1
        
        factOverlay = SKSpriteNode()
        factOverlay.name = UtilitiesPortal.factOverlayName
        factOverlay.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        factOverlay.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        factOverlay.color = SKColor.blackColor()
        factOverlay.alpha = 0.7
        factOverlay.zPosition = 0.9
        factOverlay.hidden = true
        factOverlay.addChild(factOverlayText)
        addChild(factOverlay)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        if chosenAnswer == nil {
            return
        }
        
        chosenAnswer.position = touch!.locationInNode(self)
        //print("+++++++++++++++++++++++++")
        
        let xPostion = chosenAnswer.position.x
        let yPostion = chosenAnswer.position.y
        let x = xPostion / UtilitiesPortal.screenWidth
        let y = yPostion / UtilitiesPortal.screenHeight
        print("x=\(x)")
        print("y=\(y)")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(chosenAnswer == nil) {
            return
        }
        print(chosenAnswer.value)
        
        for x in 0...questions.count-1 {
            if CGRectContainsPoint(questions[x].frame, chosenAnswer.position) {
                answeredQuestions[x].hidden = false
                answeredQuestions[x].texture = SKTexture(imageNamed: chosenAnswer.value)
                answeredQuestions[x].value = chosenAnswer.value
                print(answeredQuestions[x].value)
                break
            }
        }
        
        chosenAnswer.removeFromParent()
        self.chosenAnswer = nil
        
        if checkResult() {
            tick.texture = SKTexture(imageNamed: "tick-green")
        }
        else {
            tick.texture = SKTexture(imageNamed: "tick-grey")
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let point = touch!.previousLocationInNode(self)
        
        if state == UtilitiesPortal.stateFact {
            factOverlay.hidden = true
            state = UtilitiesPortal.stateResult
            return
        }
        
        if state == UtilitiesPortal.stateAnswer {
            // Labels selected
            for x in 0...answers.count-1 {
                if CGRectContainsPoint(answers[x].frame, point) {
                    chosenAnswer = CustomSKSpriteNode(imageNamed: answers[x].name!)
                    chosenAnswer.value = answers[x].name!
                    chosenAnswer.zPosition = 0.4
                    chosenAnswer.alpha = 0.9
                    chosenAnswer.size = CGSize(width: UtilitiesPortal.screenWidth*0.15,
                                               height: UtilitiesPortal.screenHeight*0.1)
                    chosenAnswer.zPosition = 1
                    chosenAnswer.position = answers[x].position
                    addChild(chosenAnswer)
                    return
                }
            }
            
            // Targets node selected
            for x in 0...questions.count-1 {
                if CGRectContainsPoint(questions[x].frame, point) {
                    if answeredQuestions[x].hidden {
                        return
                    }
                    answeredQuestions[x].hidden = true
                    
                    chosenAnswer = CustomSKSpriteNode(imageNamed: answeredQuestions[x].value)
                    chosenAnswer.value = answeredQuestions[x].value
                    chosenAnswer.zPosition = 0.4
                    chosenAnswer.alpha = 0.9
                    chosenAnswer.size = CGSize(width: UtilitiesPortal.screenWidth*0.15,
                                               height: UtilitiesPortal.screenHeight*0.1)
                    chosenAnswer.zPosition = 1
                    chosenAnswer.position = questions[x].position
                    addChild(chosenAnswer)
                    
                    answeredQuestions[x].value = UtilitiesPortal.emptyString
                    return
                }
            }
            
        }
        
        // Home button selected
        let location = touch!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if node.name == UtilitiesPortal.homeButtonName {
            
            
            backHomePage()
            
            //test last page here
            //lastPage()
            
        }
        
        // Tick button selected
        if node.name == UtilitiesPortal.tickButtonName {
            print("Tick")
            if state == UtilitiesPortal.stateAnswer && checkResult() {
                print("tick and state answer")
                //if resultImage == nil {
                    print("tick display result")
                    displayResult()
                //}
                return
            }
            
            if state == UtilitiesPortal.stateResult {
                print("tick state result")
                setupScene()
                return
            }
            return
        }
        
        //share button selected
        if node.name == UtilitiesPortal.shareButtonName {
            print("share")
            let shareContent = "hello"
            displayShareSheet(shareContent)
            return
        }
        
        //redo button selected
        if node.name == UtilitiesPortal.redoButtonName {
            print("redo")
            setupScene()
            return
        }
        //back button selected
        if node.name == UtilitiesPortal.backButtonName {
            print("back")
            backHomePage()
            return
        }
        
        // Show button selected
        if node.name == UtilitiesPortal.showButtonName {
            if state == UtilitiesPortal.stateResult {
                if resultImage == nil {
                    displayAnswers(true)
                    resultImage = SKSpriteNode(imageNamed: lvlOneQuestion.imageSol)
                    resultImage.zPosition = 0.5
                    resultImage.alpha = 1
                    resultImage.position = CGPoint(x:UtilitiesPortal.borderSize + UtilitiesPortal.imageWidth/2,
                                                   y:UtilitiesPortal.screenHeight/2 )
                    resultImage.position = CGPoint(x:UtilitiesPortal.borderSize + UtilitiesPortal.imageWidth/2,
                                                   y:UtilitiesPortal.screenHeight/2 )
                    resultImage.size = CGSize(width: UtilitiesPortal.imageWidth, height: UtilitiesPortal.imageHeight)
                    addChild(resultImage)
                }
                else {
                    displayAnswers(false)
                    resultImage.removeFromParent()
                    self.resultImage = nil
                }
            }
            return
        }
        
        //Fact label selected
        if node.name == UtilitiesPortal.factLabelName {
            state = UtilitiesPortal.stateFact
            factOverlay.hidden = false
            return
        }
    }
    
    func checkResult() -> Bool {
        if questions.count != 0 {
            for x in 0...questions.count-1 {
                if answeredQuestions[x].value == UtilitiesPortal.emptyString {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    func displayResult() {
        if state == UtilitiesPortal.stateAnswer {
            for x in 0...lvlOneQuestion.solutions.count-1 {
                if answeredQuestions[x].value != UtilitiesPortal.emptyString {
                    if answeredQuestions[x].value == lvlOneQuestion.solutions[x] {
                        answeredQuestions[x].texture = SKTexture(imageNamed:
                            "\(answeredQuestions[x].value)-green")
                        UtilitiesPortal.score = UtilitiesPortal.score + 1
                    }
                    else {
                        answeredQuestions[x].texture = SKTexture(imageNamed:
                            "\(answeredQuestions[x].value)-red")
                    }
                }
            }
        }
        factLabel.hidden = false
        score.text = "\(UtilitiesPortal.scoreText) \(UtilitiesPortal.score)"
        
        tick.texture = SKTexture(imageNamed: "next")
        
        state = UtilitiesPortal.stateResult
    }
    
    func displayAnswers(value: Bool) {
        if value {
            for x in 0...questions.count-1 {
                questions[x].hidden = true
                answeredQuestions[x].hidden = true
            }
        }
        else {
            for x in 0...questions.count-1 {
                questions[x].hidden = false
                answeredQuestions[x].hidden = false
            }
        }
    }
    func lastPage(){
        
        self.removeAllChildren()
        setupItems()
        tick.removeFromParent()
        tick = nil
        show.removeFromParent()
        show = nil
        
        // back button
        back = SKSpriteNode(imageNamed: "next ")
        back.name = UtilitiesPortal.backButtonName
        back.zPosition = 0.1
        back.alpha = 0.9
        back.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        back.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize,
                                y: UtilitiesPortal.navImgSize/2)
        addChild(back)
        
        // redo button
        redo = SKSpriteNode(imageNamed: "replay")
        redo.name = UtilitiesPortal.redoButtonName
        redo.zPosition = 0.1
        redo.alpha = 0.9
        redo.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        redo.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*2,
                                y: UtilitiesPortal.navImgSize/2)
        addChild(redo)
        
        // share button
        share = SKSpriteNode(imageNamed: "share")
        share.name = UtilitiesPortal.shareButtonName
        share.zPosition = 0.1
        share.alpha = 0.9
        share.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        share.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*3,
                                 y: UtilitiesPortal.navImgSize/2)
        addChild(share)
        
        
        let award = SKSpriteNode(imageNamed: "gold")
        award.name = "award"
        award.zPosition = 10
        award.position = CGPoint(x:UtilitiesPortal.screenWidth/2,
                                 y: UtilitiesPortal.screenHeight/2)
        award.size = CGSize(width: UtilitiesPortal.imageWidth, height: UtilitiesPortal.imageHeight)
        addChild(award)
        
        
    }
    // Share the score to any social media!
    func displayShareSheet(shareContent:String) {
        
        let myShare = "My best is \(shareContent)"
        let controller = self.view?.window?.rootViewController as! GameViewController
        
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [myShare], applicationActivities: nil)
        
        controller.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    //back to the home page,
    func backHomePage(){
        let secondScene = GameScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
