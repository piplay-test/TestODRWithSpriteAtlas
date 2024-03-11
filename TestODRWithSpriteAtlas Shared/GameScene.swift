//
//  GameScene.swift
//  TestODRWithSpriteAtlas Shared
//
//  Created by Payne Chu on 9/2/22.
//

import SpriteKit

let FONT_NAME = "Helvetica-Bold"
let FONT_SIZE = 12.0
let LABEL_Y_OFFSET = UIDevice.current.userInterfaceIdiom == .phone ? 70.0 : 80.0
let X_DISTANCE = UIDevice.current.userInterfaceIdiom == .phone ? 100.0 : 200.0
let Y_DISTANCE = 200.0
let FRACTION_COMPLETED = "fractionCompleted"

class GameScene: SKScene {
    
    var resourceRequest: NSBundleResourceRequest?
    private let progressObservingContext: UnsafeMutableRawPointer? = nil
    let progressLabel = SKLabelNode(text: "0.00%")
    
    func setUpScene() {
        self.progressLabel.fontName = FONT_NAME
        self.addChild(progressLabel)
        self.resourceRequest = NSBundleResourceRequest(tags: ["test"])
        self.resourceRequest?.conditionallyBeginAccessingResources(completionHandler: { available in
            if available {
                self.setUpNodes()
            } else {
                self.resourceRequest?.beginAccessingResources(completionHandler: { error in
                    if error != nil {
                        self.progressLabel.text = error!.localizedDescription
                        NSLog(error!.localizedDescription)
                    } else {
                        self.setUpNodes()
                    }
                })
                self.resourceRequest?.progress.addObserver(self, forKeyPath: FRACTION_COMPLETED, context: self.progressObservingContext)
            }
        })
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == progressObservingContext && keyPath == FRACTION_COMPLETED {
            let progress = object as! Progress
            self.progressLabel.text = String(format: "%.2f%%", progress.fractionCompleted * 100.0)
            if progress.isFinished {
                progress.removeObserver(self, forKeyPath: FRACTION_COMPLETED, context: self.progressObservingContext)
            }
        }
    }
    
    func setUpNodes() {
        self.progressLabel.removeFromParent()
        
        // ODR/Assets/SpriteAtlas/PDF
        let atlasA = SKTextureAtlas(named: "Sprites-A")
        let texA = atlasA.textureNamed("PdfSprite")
        let nodeA = SKSpriteNode(texture: texA, size: texA.size())
        nodeA.position = CGPoint(x: -X_DISTANCE, y: Y_DISTANCE)
        self.addChild(nodeA)
        let labelA = SKLabelNode(text: "ODR/Assets/SpriteAtlas/A/PDF\n(\(texA.size().width),\(texA.size().height))")
        labelA.numberOfLines = 2
        labelA.fontName = FONT_NAME
        labelA.fontSize = FONT_SIZE
        labelA.position = CGPoint(x: nodeA.position.x, y: nodeA.position.y + LABEL_Y_OFFSET)
        self.addChild(labelA)
        
        // ODR/Assets/SpriteAtlas/PNG
        let atlasB = SKTextureAtlas(named: "Sprites-B")
        let texB = atlasB.textureNamed("PngSprite")
        let nodeB = SKSpriteNode(texture: texB, size: texB.size())
        nodeB.position = CGPoint(x: X_DISTANCE, y: Y_DISTANCE)
        self.addChild(nodeB)
        let labelB = SKLabelNode(text: "ODR/Assets/SpriteAtlas/B/PNG\n(\(texB.size().width),\(texB.size().height))")
        labelB.numberOfLines = 2
        labelB.fontName = FONT_NAME
        labelB.fontSize = FONT_SIZE
        labelB.position = CGPoint(x: nodeB.position.x, y: nodeB.position.y + LABEL_Y_OFFSET)
        self.addChild(labelB)
        
        // ODR/SpriteAtlas/PDF
        let atlasC = SKTextureAtlas(named: "Sprites-C")
        let texC = atlasC.textureNamed("PdfSprite")
        let nodeC = SKSpriteNode(texture: texC, size: texC.size())
        nodeC.position = CGPoint(x: -X_DISTANCE, y: 0.0)
        self.addChild(nodeC)
        let labelC = SKLabelNode(text: "ODR/SpriteAtlas/C/PDF\n(\(texC.size().width),\(texC.size().height))")
        labelC.numberOfLines = 2
        labelC.fontName = FONT_NAME
        labelC.fontSize = FONT_SIZE
        labelC.position = CGPoint(x: nodeC.position.x, y: nodeC.position.y + LABEL_Y_OFFSET)
        self.addChild(labelC)
        
        // ODR/SpriteAtlas/PNG
        let atlasD = SKTextureAtlas(named: "Sprites-D")
        let texD = atlasD.textureNamed("PngSprite")
        let nodeD = SKSpriteNode(texture: texD, size: texD.size())
        nodeD.position = CGPoint(x: X_DISTANCE, y: 0.0)
        self.addChild(nodeD)
        let labelD = SKLabelNode(text: "ODR/SpriteAtlas/D/PNG\n(\(texD.size().width),\(texD.size().height))")
        labelD.numberOfLines = 2
        labelD.fontName = FONT_NAME
        labelD.fontSize = FONT_SIZE
        labelD.position = CGPoint(x: nodeD.position.x, y: nodeD.position.y + LABEL_Y_OFFSET)
        self.addChild(labelD)

        // ODR/Assets/PDF
        let texE = SKTexture(imageNamed: "Pdf")
        let nodeE = SKSpriteNode(texture: texE, size: texE.size())
        nodeE.position = CGPoint(x: -X_DISTANCE, y: -Y_DISTANCE)
        self.addChild(nodeE)
        let labelE = SKLabelNode(text: "ODR/Assets/PDF\n(\(texE.size().width),\(texE.size().height))")
        labelE.numberOfLines = 2
        labelE.fontName = FONT_NAME
        labelE.fontSize = FONT_SIZE
        labelE.position = CGPoint(x: nodeE.position.x, y: nodeE.position.y + LABEL_Y_OFFSET)
        self.addChild(labelE)

        // ODR/Assets/PNG
        let texF = SKTexture(imageNamed: "Png")
        let nodeF = SKSpriteNode(texture: texF, size: texF.size())
        nodeF.position = CGPoint(x: X_DISTANCE, y: -Y_DISTANCE)
        self.addChild(nodeF)
        let labelF = SKLabelNode(text: "ODR/Assets/PNG\n(\(texF.size().width),\(texF.size().height))")
        labelF.numberOfLines = 2
        labelF.fontName = FONT_NAME
        labelF.fontSize = FONT_SIZE
        labelF.position = CGPoint(x: nodeF.position.x, y: nodeF.position.y + LABEL_Y_OFFSET)
        self.addChild(labelF)
    }
    
    #if os(watchOS)
    override func sceneDidLoad() {
        self.setUpScene()
    }
    #else
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    #endif
}
