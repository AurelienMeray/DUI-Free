

import SpriteKit
import CoreMotion
import CoreGraphics

class ResultsScene: SKScene, SKPhysicsContactDelegate{
    
    
    override func didMove(to view: SKView) {
        
        
        
    }
    
    
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let gameSceneTemp = StartScene(fileNamed: "StartScene")
        self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.fade(withDuration: 1.0))
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }
}
