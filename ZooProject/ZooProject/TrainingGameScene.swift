//
//  TrainingGameScene.swift
//  ZooProject
//
//  Created by Bira on 26/08/15.
//  Copyright (c) 2015 Kalim. All rights reserved.
//

import SpriteKit
import AVFoundation

//CATEGORIAS DA FISICA
let FishCategory       : UInt32 = 0x1 << 1 // 00000000000000000000000000000001
let EaterCategory      : UInt32 = 0x1 << 2 // 00000000000000000000000000000010
let BottomCategory     : UInt32 = 0x1 << 3 // 00000000000000000000000000000100
let InvisibleCategory  : UInt32 = 0x1 << 5 // 00000000000000000000010000000000

class TrainingGameScene: SKScene, SKPhysicsContactDelegate {
    
    var back: SKSpriteNode = SKSpriteNode()
    var bola: SKSpriteNode = SKSpriteNode()
    var background: SKSpriteNode = SKSpriteNode()
    var leftTap: SKSpriteNode = SKSpriteNode()
    var rightTap: SKSpriteNode = SKSpriteNode()
    var eaterLeft: SKSpriteNode = SKSpriteNode()
    var eaterRight: SKSpriteNode = SKSpriteNode()
    var bottom: SKSpriteNode = SKSpriteNode()
    
    var eatLeft = false
    var eatRight = false

    var ariranha: SKTexture = SKTexture()
    var ariranhaNode: SKSpriteNode = SKSpriteNode()

    
    //ARMAZENA AS TEXTURAS/FRAMES DAS ANIMACOES
    var ariranhaAnimation: [SKTexture] = [SKTexture]()
    
    
    var timer: NSTimer = NSTimer()
    
    
    var countFishLost = 0;
    
    
    var pause: SKSpriteNode = SKSpriteNode()
    var musicOn: SKSpriteNode = SKSpriteNode()
    var soundOn: SKSpriteNode = SKSpriteNode()
    var colorBlindOn: SKSpriteNode = SKSpriteNode()
    
    
    var pausePopUp: SKSpriteNode = SKSpriteNode()
    var pauseButton = false
   
    
    var soundGame: Bool = Bool()
    var musicGame: Bool = Bool()
    var colorBlind: Bool = Bool()
    var daltonicoMode: Bool = Bool()
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var audioPlayer = AVAudioPlayer()
    
    var layerBackground: CGFloat = 0.0
    var layerBeforeBackground: CGFloat = -1
    var layerAfterBackground: CGFloat = 1
    
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        //INICIA O CONTADOR DOS TIMER
        startTimer()
        
        back = childNodeWithName("back") as! SKSpriteNode
        background = childNodeWithName("background") as! SKSpriteNode
        eaterLeft = childNodeWithName("eaterLeft") as! SKSpriteNode
        eaterRight = childNodeWithName("eaterRight") as! SKSpriteNode
        
        eaterLeft.physicsBody = SKPhysicsBody (circleOfRadius: eaterLeft.size.height/2)
        eaterLeft.physicsBody?.categoryBitMask = 0
        eaterLeft.physicsBody?.contactTestBitMask = FishCategory
        eaterLeft.physicsBody?.collisionBitMask = EaterCategory
        eaterLeft.physicsBody?.dynamic = false
        eaterLeft.physicsBody?.affectedByGravity = false
        
        eaterRight.physicsBody = SKPhysicsBody (circleOfRadius: eaterRight.size.height/2)
        eaterRight.physicsBody?.categoryBitMask = 0
        eaterRight.physicsBody?.contactTestBitMask = FishCategory
        eaterRight.physicsBody?.collisionBitMask = EaterCategory
        eaterRight.physicsBody?.dynamic = false
        eaterRight.physicsBody?.affectedByGravity = false
        
        
        //CRIA FISICA DO JOGO
        self.physicsWorld.contactDelegate = self;
        var bound = SKPhysicsBody (edgeLoopFromRect: background.frame)
        self.physicsBody = bound
//        self.anchorPoint = CGPointMake(0.0, 0.01)
        
//        println(background.frame)
        
    
        
        
        //CRIA ANIMACAO DA ARIRANHA
        var ariranhaAnimatedAtlas = SKTextureAtlas (named: "Ariranha")
        self.prepareFrames(ariranhaAnimatedAtlas)
        self.setFrameAnimation(ariranhaNode, animation: ariranhaAnimation, frameAnimation: 2)
//        self.activeAnimation(selectionScene, animation: note1Animation, key: "ariranhaAnim")
//        println("\(ariranhaAnimation)")
//        println("Node: \(ariranhaNode.texture!)")
        
        //ADICIONA ARIRANHA NA CENA
        ariranhaNode = SKSpriteNode(imageNamed: "Ariranha0")
        ariranhaNode.position = CGPointMake(1050, 500)
        ariranhaNode.zPosition = 3
        ariranhaNode.physicsBody = SKPhysicsBody (texture: ariranhaNode.texture!, size: ariranhaNode.texture!.size())
        ariranhaNode.physicsBody?.dynamic = false
        ariranhaNode.physicsBody?.affectedByGravity = false
        ariranhaNode.setScale(3.0)
        
        //AREA DE TAP ESQUERDO
        leftTap = SKSpriteNode (imageNamed: "tap")
        leftTap.alpha = 0.2
        leftTap.zPosition = 1
        leftTap.position = CGPointMake(500, 650)
        leftTap.setScale(0.75)
        addChild(leftTap)
        
        //AREA DE TAP DIREITO
        rightTap = SKSpriteNode (imageNamed: "tap")
        rightTap.alpha = 0.2
        rightTap.zPosition = 1
        rightTap.position = CGPointMake(1500, 650)
        rightTap.setScale(0.75)
        addChild(rightTap)
        
        //FUNDO DA TELA
        let bottomRect = CGRectMake(frame.origin.x, frame.origin.y-100, frame.size.width, 100)
        bottom.physicsBody = SKPhysicsBody(edgeLoopFromRect: bottomRect)
        bottom.physicsBody?.categoryBitMask = BottomCategory
        bottom.physicsBody?.contactTestBitMask = FishCategory
        bottom.physicsBody?.collisionBitMask = BottomCategory
        addChild(bottom)
        
        //ORDEM EM QUE OS ELEMENTOS SÃO ADICIONADOS NA CENA
        addChild(ariranhaNode)

        
        //        //        defaults.setBool(true, forKey: "musicLoaded")
        //
        //        var back = childNodeWithName("back") as! SKSpriteNode
        //
        //        musicOn = childNodeWithName("musicOn") as! SKSpriteNode
        //        soundOn = childNodeWithName("soundOn") as! SKSpriteNode
        //        colorBlindOn = childNodeWithName("modeColorBlindOn") as! SKSpriteNode
        //
        //        musicGame = defaults.boolForKey("musicGame")
        //        soundGame = defaults.boolForKey("soundGame")
        //        daltonicoMode = defaults.boolForKey("daltonicoMode")
        //
        //        colorBlind = defaults.boolForKey("colorBlind")
        //
        //        //DEFINE MUSICA
        //        if musicGame{
        //            musicOn.alpha = 1
        //        }else{
        //            musicOn.alpha = 0
        //        }
        //
        //        //DEFINE SOM
        //        if soundGame{
        //            soundOn.alpha = 1
        //        }else{
        //            soundOn.alpha = 0
        //        }
        
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var touch = touches.first as! UITouch
        var touchLocation = touch.locationInNode(self)
        var node = self.nodeAtPoint(touchLocation)
        
        if back.containsPoint(touchLocation){
            var enclousureScene = EnclousureScene.unarchiveFromFile("EnclousureScene") as! EnclousureScene
            view!.presentScene(enclousureScene)
        }
        
        if leftTap.containsPoint(touchLocation){
//            println("leftTap")
            eatLeft = true
            eatRight = false
            //Setar a animacao
            
            eaterLeft.physicsBody?.categoryBitMask = EaterCategory
            eaterRight.physicsBody?.categoryBitMask = 0
            ariranhaNode.texture = ariranhaAnimation[0]
            
            return
        }
        
        if rightTap.containsPoint(touchLocation){
//            println("rightTap")
            eatRight = true
            eatLeft = false
            //Setar a animacao
            eaterRight.physicsBody?.categoryBitMask = EaterCategory
            eaterLeft.physicsBody?.categoryBitMask = 0

            ariranhaNode.texture = ariranhaAnimation[2]
            
            return
        }
        
        //        if feedingGame.containsPoint(touchLocation){
        //            var feedingGameScene = FeedingGameScene.unarchiveFromFile("FeedingGameScene") as! FeedingGameScene
        //            view!.presentScene(feedingGameScene)
        //        }
        
        
        
        
        
        
        
        
        //        if self.childNodeWithName("musicOn")!.containsPoint(touchLocation){
        //            if musicGame {
        //                AudioNode!.playSound(RummyAudio.SoundsEnum.SelectConfig)
        //                musicOn.alpha = 0
        //                musicGame = false
        //                defaults.setObject(false, forKey: "musicGame")
        //
        //                AudioNode?.stopMusic()
        //                MusicSetUp = musicGame
        //
        //
        //
        //            }else{
        //                AudioNode!.playSound(RummyAudio.SoundsEnum.SelectConfig)
        //                musicOn.alpha = 1
        //                musicGame = true
        //                defaults.setObject(true, forKey: "musicGame")
        //
        //                MusicSetUp = musicGame
        //                AudioNode!.playMusic(RummyAudio.MusicsEnum.Title)
        //
        //            }
        //            defaults.synchronize()
        //        }
        //
        //        if self.childNodeWithName("soundOn")!.containsPoint(touchLocation){
        //            if soundGame {
        //                soundOn.alpha = 0
        //                soundGame = false
        //                defaults.setObject(false, forKey: "soundGame")
        //
        //                AudioNode!.playSound(RummyAudio.SoundsEnum.SelectConfig)
        //                AudioSetUp = soundGame
        //
        //            }else{
        //                soundOn.alpha = 1
        //                soundGame = true
        //                defaults.setObject(true, forKey: "soundGame")
        //
        //                AudioSetUp = soundGame
        //                AudioNode!.playSound(RummyAudio.SoundsEnum.SelectConfig)
        //            }
        //            defaults.synchronize()
        //        }
        //
        //
        //        if self.childNodeWithName("modeColorBlindOn")!.containsPoint(touchLocation){
        //            if !colorBlind {
        //                AudioNode!.playSound(RummyAudio.SoundsEnum.SelectConfig)
        //                colorBlindOn.alpha = 1
        //                colorBlind = true
        //                defaults.setObject(colorBlind, forKey: "colorBlind")
        //                daltonicoMode = true
        //                defaults.setObject(true, forKey: "daltonicoMode")
        //            }else{
        //                AudioNode!.playSound(RummyAudio.SoundsEnum.SelectConfig)
        //                colorBlindOn.alpha = -1
        //                colorBlind = false
        //                defaults.setObject(colorBlind, forKey: "colorBlind")
        //                daltonicoMode = false
        //                defaults.setObject(false, forKey: "daltonicoMode")
        //            }
        //            defaults.synchronize()
        //        }
        //
        
    }
    
    //DETECTA A COLISAO ENTRE OS CORPOS
    func didBeginContact(contact: SKPhysicsContact) {

        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        //Determina a colisao entre o peixe e a ariranha
        if (firstBody.categoryBitMask == FishCategory && secondBody.categoryBitMask == EaterCategory) ||
            (firstBody.categoryBitMask == EaterCategory && secondBody.categoryBitMask == FishCategory){
                if eatLeft{
                    determinesAndDestroyFish(firstBody.node as! SKSpriteNode, objectTwo: secondBody.node as! SKSpriteNode)
                    return
                }
                else{
                    determinesAndDestroyFish(firstBody.node as! SKSpriteNode, objectTwo: secondBody.node as! SKSpriteNode)
                    return
                }
        }
        
        //Determina a colisao entre o chao e o peixe
        if (firstBody.categoryBitMask == FishCategory && secondBody.categoryBitMask == BottomCategory) ||
            (firstBody.categoryBitMask == BottomCategory && secondBody.categoryBitMask == FishCategory){
//                firstBody.dynamic = false
//                secondBody.dynamic = false
                determinesAndDestroyFishInGround(firstBody.node as! SKSpriteNode, objectTwo: secondBody.node as! SKSpriteNode)
//                println("CHAO")
                return
        }
    }
    
    //DETERMINA QUAL DOS CORPOS COLIDIDOS E O ALIMENTO E O DESTROI
    func determinesAndDestroyFish(objectOne: SKSpriteNode, objectTwo: SKSpriteNode){

        if objectOne.physicsBody?.categoryBitMask == FishCategory{
            objectOne.removeFromParent()
        }else{ objectTwo.removeFromParent()}
    }
    
    //DETERMINA QUAL O OBJETO QUE CAIU E O DESTROI
    func determinesAndDestroyFishInGround(objectOne: SKSpriteNode, objectTwo: SKSpriteNode){
        
        if objectOne.physicsBody?.categoryBitMask == FishCategory{
            objectOne.removeFromParent()
        }else{
            objectTwo.removeFromParent()
        }
//            objectOne.physicsBody?.collisionBitMask = BottomCategory
//        }else{ objectOne.physicsBody?.collisionBitMask = BottomCategory}
    }
    
    //PREPARA AS IMAGENS DO PACOTE ATLAS
    func prepareFrames(atlas: SKTextureAtlas){
        for (var i = 0; i < atlas.textureNames.count; i++){
            var textureName = NSString(format: "Ariranha%d", i)
            var textureTemp = atlas.textureNamed(textureName as String)
            ariranhaAnimation.append(textureTemp)
        }
    }
    
    //EXECUTA A ANIMACAO
    func activeAnimation(node: SKSpriteNode, animation: [SKTexture], key: String){
        node.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(animation, timePerFrame: 0.1, resize: false, restore: true)), withKey: key)
    }
    
    //DEFINE O FRAME INICIAL OU ESTÄTICA DA ANIMACAO
    func setFrameAnimation(node: SKSpriteNode, animation: [SKTexture], frameAnimation: Int){
        node.texture = animation[frameAnimation]
    }
    
    //EXECUTA A CADA "X" SEGUNDO (Atraves da chamada do startTimer)
    func addFish(){
        
        var rand = arc4random()&1
        var spawnFish: CGPoint = CGPoint()
        
        if rand == 0{
            spawnFish = CGPointMake(600, 1500)
        }else{ spawnFish = CGPointMake(1500, 1500) }
        
        var bola = SKSpriteNode (imageNamed: "bola")
        bola.zPosition = 3
        bola.setScale(0.25)
        bola.position = spawnFish
        bola.physicsBody = SKPhysicsBody (circleOfRadius: bola.size.height/2)
        bola.physicsBody?.categoryBitMask = FishCategory
        bola.physicsBody?.contactTestBitMask = BottomCategory | EaterCategory
        bola.physicsBody?.collisionBitMask = FishCategory
        addChild(bola)
    }
    
    //EXECUTA A CONTAGEM DOS TIMER
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("addFish"), userInfo: nil, repeats: true)
        
    }
    
    
}