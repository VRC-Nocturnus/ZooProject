//
//  MenuScene.swift
//  ZooProject
//
//  Created by Bira on 25/08/15.
//  Copyright (c) 2015 Kalim. All rights reserved.
//

import SpriteKit
import AVFoundation

class MenuScene: SKScene {
    
    var playGame: SKSpriteNode = SKSpriteNode()
//    var eaterGame: SKSpriteNode = SKSpriteNode()
//    var stringGame: SKSpriteNode = SKSpriteNode()
    
    
    //ARMAZENA AS TEXTURAS/FRAMES DAS ANIMACOES
//    var note1Animation: [SKTexture] = [SKTexture]()
    
    
    
    
    
    
    
    
    let defaults = NSUserDefaults.standardUserDefaults()
    //    var score: Int = Int()
    //    var showScore: SKLabelNode = (SKLabelNode (fontNamed: "Bariol-Regular"))
    //    var scoreTextLabel: SKLabelNode = (SKLabelNode (fontNamed: "Bariol-Regular"))
    var musicLoaded: Bool = Bool()
    var secondLaunch: Bool = Bool()
    
    var start: SKSpriteNode = SKSpriteNode()
    var options: SKSpriteNode = SKSpriteNode()
    var tutorial: SKSpriteNode = SKSpriteNode()
    var credits: SKSpriteNode = SKSpriteNode()
    
    let blue: UIColor = UIColor.blueColor()
    let down: SKTransitionDirection = SKTransitionDirection.Down
    
    let transition1: SKTransition = SKTransition.crossFadeWithDuration(1.0)
    let transition2: SKTransition = SKTransition.doorsCloseHorizontalWithDuration(1.0)
    let transition3: SKTransition = SKTransition.doorsCloseVerticalWithDuration(1.0)
    let transition4: SKTransition = SKTransition.doorsOpenVerticalWithDuration(1.0)
    let transition5: SKTransition = SKTransition.doorsOpenHorizontalWithDuration(1.0)
    let transition6: SKTransition = SKTransition.doorwayWithDuration(1.0)
    var transition7: SKTransition = SKTransition()
    let transition8: SKTransition = SKTransition.fadeWithDuration(1.0)
    let transition9: SKTransition = SKTransition.flipHorizontalWithDuration(1.0)
    let transition10: SKTransition = SKTransition.flipVerticalWithDuration(1.0)
    var transition11: SKTransition = SKTransition()
    var transition12: SKTransition = SKTransition()
    var transition13: SKTransition = SKTransition()
    
    
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        playGame = childNodeWithName("playGame") as! SKSpriteNode
//        eaterGame = childNodeWithName("eaterGame") as! SKSpriteNode
//        stringGame = childNodeWithName("stringGame") as! SKSpriteNode
        
        //CRIA ANIMACAO DAS NOTAS
       // var note1AnimatedAtlas = SKTextureAtlas (named: "Note1")
        //self.prepareFrames(note1AnimatedAtlas)
        //self.activeAnimation(playGame, animation: note1Animation, key: "note1Anim")
        
        
        
        
        
        
        
        
        
        
        //CRIA UM BOOLEANO PARA ARMAZENAS O STATUS DA MUSICA
        var musicGame = defaults.boolForKey("musicGame")
        
        //CRIA UM BOOLEANO PARA ARMAZENAR O STATUS DO SOM
        var soundGame = defaults.boolForKey("soundGame")
        
        //VERIFICA CARREGAMENTO DA MUSICA
        var musicLoaded = defaults.boolForKey("musicLoaded")
        
        //        defaults.setBool(false, forKey: "musicLoaded")
        
        //        println("Musica\(soundGame)")
        //        println("Carregada\(musicLoaded)")
        
        //        if musicGame && !musicLoaded{
        //            MusicSetUp = musicGame
        //            AudioNode!.playMusic(RummyAudio.MusicsEnum.Title)
        //            defaults.setBool(true, forKey: "musicLoaded")
        //            //            println("hsuahsuahsu")
        //        }
        //
        //        if soundGame && !musicLoaded{
        //            //        if soundGame{
        //            AudioSetUp = soundGame
        //        }
        
        transition7 = SKTransition.fadeWithColor(blue, duration: 1.0)
        transition11 = SKTransition.moveInWithDirection(down, duration: 1.0)
        transition12 = SKTransition.pushWithDirection(down, duration: 1.0)
        transition13 = SKTransition.revealWithDirection(down, duration: 1.0)
        
        //        start = childNodeWithName("start") as! SKSpriteNode
        //        options = childNodeWithName("options") as! SKSpriteNode
        //        tutorial = childNodeWithName("tutorial") as! SKSpriteNode
        //        credits = childNodeWithName("creditos") as! SKSpriteNode
        
        //        start.setScale(0.75)
        //        options.setScale(0.75)
        //        tutorial.setScale(0.75)
        //        credits.setScale(0.75)
        
        //        showScore = childNodeWithName("scoreLabel") as! SKLabelNode
        //        scoreTextLabel = childNodeWithName("scoreTextLabel") as! SKLabelNode
        //        scoreTextLabel.text = "Score"
        
        
        //CRIA UM OBJETO PARA ARMAZENAS AS INFORMACOES DO NIVEL DE DIFICULDADE
        defaults.objectForKey("level")
        //CRIA UM INTEIRO PARA ARMAZENAS A FASE QUE SERA JOGADA
        defaults.integerForKey("levelNumber")
        //CRIA UM ARRAY PARA ARMAZENAS AS INFORMACOES DOS DESAFIOS
        defaults.arrayForKey("challenge")
        //CRIA UM ARRAY PARA ARMAZENAR O TIPO DE CHECAGEM
        defaults.arrayForKey("checking")
        //CRIA UM ARRAY PARA ARMAZENAR OS SEGUIMENTOS PARA A CHECAGEM
        defaults.arrayForKey("segments")
        //CRIA UM ARRAY PARA ARMAZENAR A ORDEM ATUAL DAS PEDRAS
        defaults.arrayForKey("stonesOrder")
        
        //CRIA UM ARRAY PARA CONFIGURAR OS BLOQUEIOS DE TELA DO NIVEL FACIL
        defaults.arrayForKey("easyLevels")
        //CRIA UM ARRAY PARA CONFIGURAR OS BLOQUEIOS DE TELA DO NIVEL NORMAL
        defaults.arrayForKey("normalLevels")
        //CRIA UM ARRAY PARA CONFIGURAR OS BLOQUEIOS DE TELA DO NIVEL DIFICIL
        defaults.arrayForKey("hardLevels")
        //CRIA UM ARRAY PARA CONFIGURAR OS BLOQUEIOS DE TELA DO NIVEL MUITO DIFICIL
        defaults.arrayForKey("toughLevels")
        
        //CRIA UM BOOLEANO PARA CONFIGURAR AS MUSICAS
        defaults.boolForKey("musicGame")
        //CRIA UM BOOLEANO PARA CONFIGURAR O SOM
        defaults.boolForKey("soundGame")
        
        //CRIA UM BOOLEANO PARA ARMAZENAR O STATUS DO PRIMEIRO LAUNCH DO JOGO
        secondLaunch = defaults.boolForKey("secondLaunch")
        
        //DEFINE A CONFIGURACAO DO SOM NO PRIMEIRO LAUNCH
        //        if !secondLaunch {
        //            //HABILITA MUSICA
        //
        //            MusicSetUp = true
        //            AudioNode!.playMusic(RummyAudio.MusicsEnum.Title)
        //            defaults.setBool(true, forKey: "secondLaunch")
        //            defaults.setBool(true, forKey: "musicLoaded")
        //            defaults.setBool(true, forKey: "musicGame")
        //            //HABILITA SOM
        //            AudioSetUp = true
        //
        //            defaults.boolForKey("soundGame")
        //            defaults.setBool(true, forKey: "soundGame")
        //            defaults.synchronize()
        //        }
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var touch = touches.first as! UITouch
        var touchLocation = touch.locationInNode(self)
        var node = self.nodeAtPoint(touchLocation)
        
        
        if playGame.containsPoint(touchLocation){
            animationScene(playGame, function: "play")
        }
        
//        if eaterGame.containsPoint(touchLocation){
//            animationScene(attackGame, function: "eater")
//        }
//        
//        if stringGame.containsPoint(touchLocation){
//            animationScene(attackGame, function: "string")
//        }
        
        
        
        
        
        
        
        
        
        
        
        
        //        if start.containsPoint(touchLocation){
        //            AudioNode!.playSound(RummyAudio.SoundsEnum.SelectButton)
        //            animationScene(start, function: "start")
        //        }
        //
        //        if options.containsPoint(touchLocation){
        //            AudioNode!.playSound(RummyAudio.SoundsEnum.SelectButton)
        //            animationScene(options, function: "options")
        //        }
        //
        //        if tutorial.containsPoint(touchLocation){
        //            AudioNode!.playSound(RummyAudio.SoundsEnum.SelectButton)
        //            animationScene(tutorial, function: "tutorial")
        //        }
        //
        //        if credits.containsPoint(touchLocation){
        //            AudioNode!.playSound(RummyAudio.SoundsEnum.SelectButton)
        //            animationScene(credits, function: "credits")
        //        }
        
    }
    
    //CHAMA CENA DOS LEVELS
    func callPlayGame(){
        var playGame = ZooMapScene.unarchiveFromFile("ZooMapScene") as! ZooMapScene
        view!.presentScene(playGame, transition: transition1)
    }
    
//    //CHAMA CENA DAS CONFIGURACOES
//    func callEaterGame(){
//        var eaterScene = EaterGameScene.unarchiveFromFile("EaterGameScene") as! EaterGameScene
//        view!.presentScene(eaterScene, transition: transition2)
//    }
//    
//    //CHAMA CENA DO TUTORIAL
//    func callStringGame(){
//        var stringGame = StringGameScene.unarchiveFromFile("StringGameScene") as! StringGameScene
//        view!.presentScene(stringGame, transition: transition1)
//    }
    
    
    //ANIMACAO DOS BOTOES
    func animationScene(button: SKNode, function: String) -> Void{
        
        var gameScene: SKAction = SKAction()
        
        switch(function){
        case "play":
            gameScene = SKAction.runBlock({ self.callPlayGame() })
            break
//        case "eater":
//            gameScene = SKAction.runBlock({ self.callEaterGame() })
//            break
//        case "string":
//            gameScene = SKAction.runBlock({ self.callStringGame() })
//            break
        default:
            println("A cena: \(function) nao existe!")
            break
        }
        
        var resizeButton = Array<SKAction>()
        resizeButton.append(SKAction.scaleTo(1.0, duration: 0.2))
        resizeButton.append(SKAction.scaleTo(0.75, duration: 0.2))
        resizeButton.append(gameScene)
        
        button.runAction(SKAction.sequence(resizeButton))
    }
    
    //PREPARA AS IMAGENS DO PACOTE ATLAS
//    func prepareFrames(atlas: SKTextureAtlas){
//        for (var i = 0; i < atlas.textureNames.count; i++){
//            var textureName = NSString(format: "Nota%d", i)
//            var textureTemp = atlas.textureNamed(textureName as String)
//            note1Animation.append(textureTemp)
//        }
//    }
//    
//    //EXECUTA A ANIMACAO
//    func activeAnimation(node: SKSpriteNode, animation: [SKTexture], key: String){
//        node.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(animation, timePerFrame: 0.1, resize: false, restore: true)), withKey: key)
//    }
    
}