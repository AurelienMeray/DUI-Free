

import SpriteKit
import CoreMotion
import CoreGraphics

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    let manager = CMMotionManager()
    var startNode = SKSpriteNode()
    var endNode = SKSpriteNode()
    var textLabel = SKLabelNode()
    var printTime = SKLabelNode()
    var resultsLabel = SKLabelNode()
    var resultsLabel2 = SKLabelNode()
    
    var startCount = true
    var setTime = 0
    var myTime = 0
    
    
    var countCollison = 1
    var pathObject = SKSpriteNode()
    var points = [(0, 0), (100, 100), (200, -50), (300, 30), (400, 20)]
    var numPoints = 5

    
    override func didMove(to view: SKView) {
        
        
        self.addChild(self.printTime)
        self.physicsWorld.contactDelegate = self
        
        startNode = self.childNode(withName: "startNode") as! SKSpriteNode
        endNode = self.childNode(withName: "endNode") as! SKSpriteNode
        textLabel = self.childNode(withName: "textLabel") as! SKLabelNode
        printTime = self.childNode(withName: "printTime") as! SKLabelNode
        resultsLabel = self.childNode(withName: "resultsLabel") as! SKLabelNode
        resultsLabel2 = self.childNode(withName: "resultsLabel2") as! SKLabelNode
        
        //borderSquare = self.childNode(withName: "borderSquare") as! SKSpriteNode

        
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * 20, dy: CGFloat((data?.acceleration.y)!) * 20)
        }
        
      //Circling
//        let circle: CGPath = CGPath(rect: CGRect(x: CGFloat(-161), y: CGFloat(-160), width: CGFloat(322), height: CGFloat(322)), transform: nil)
//        let followTrack = SKAction.follow(circle, asOffset: false, orientToPath: true, duration: 0.3)
//        let forever = SKAction.repeatForever(followTrack)
//        endNode.run(forever)
        
//        let bez = UIBezierPath(cgPath: circle)
//        UIColor.blue.setFill()
//        bez.fill()
//        bez.fill(with: CGBlendMode.lighten, alpha: 1)
//        var progressCircle = CAShapeLayer()
//        progressCircle = CAShapeLayer ()
//        progressCircle.path = bez.cgPath
//        progressCircle.strokeColor = UIColor.white.cgColor
//        progressCircle.fillColor = UIColor.blue.cgColor
//        progressCircle.lineWidth = 10.0
       
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.frame = CGRect(x: 0.0, y: 0.0, width: 300, height: 300)
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.fillRule = kCAFillRuleNonZero
        
        let outerPath = UIBezierPath(rect: shapeLayer.bounds.insetBy(dx: 20.0, dy: 20.0))
        let innerPath = UIBezierPath(rect: shapeLayer.bounds.insetBy(dx: 50.0, dy: 50.0))
        
        let shapeLayerPath = UIBezierPath()
        shapeLayerPath.append(outerPath)
        shapeLayerPath.append(innerPath)
        
        shapeLayer.path = shapeLayerPath.cgPath
        
      /*  let border = SKPhysicsBody(edgeLoopFrom: CGPath(rect: CGRect(x: CGFloat(-161), y: CGFloat(-161), width: CGFloat(322), height: CGFloat(322)), transform: nil))
        
        border.friction = 0
        border.restitution = 0.2
        
        self.physicsBody = border*/


        
        
    }
    
    
    

    
    func didBegin(_ contact: SKPhysicsContact) {
         if (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1){
            textLabel.text = String("Count: \(countCollison)")
            print("Registered")
            countCollison += 1
        }
         else if (contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2){
            textLabel.text = String("Count: \(countCollison)")
            print("Registered")
            countCollison += 1
        }
        
        

        
    }
    override func update(_ currentTime: TimeInterval) {
        if (self.myTime <= 15){
            if self.startCount == true {
                self.setTime = Int(currentTime)
                self.startCount = false
            }
            self.myTime = Int(currentTime) - self.setTime
            printTime.text = ("\(self.myTime)")
        }
        else{
            printTime.text = ("15")
        }
        
//        let y = 5
//        if (self.myTime == y ){
//            let gameSceneTemp = ResultsScene(fileNamed: "ResultsScene")
//            self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fade(withDuration: 1.0))
//            
//        }
        
        let y = 15
        if (self.myTime == y ){
            if (countCollison <= 10){
            resultsLabel.text = String("You are safe to drive.")
                resultsLabel2.text = String("")
                let colorize = SKAction.colorize(with: .green, colorBlendFactor: 1, duration: 1)
                startNode.run(colorize)
                resultsLabel.run(colorize)
            }
            else if (countCollison <= 18)&&(countCollison > 10){
                resultsLabel.text = String("Risky... ")
                resultsLabel2.text = String("Would not recommend driving.")
                let colorize2 = SKAction.colorize(with: .yellow, colorBlendFactor: 1, duration: 1)
                startNode.run(colorize2)
                resultsLabel.run(colorize2)
                resultsLabel2.run(colorize2)
            }
            else{
                resultsLabel.text = String("Do Not Drive! Not Safe!")
                resultsLabel2.text = String("")
                let colorize3 = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 1)
                startNode.run(colorize3)
                resultsLabel.run(colorize3)
            }
            
        }
        
    }
    

}
