//
//  GameScene.swift
//  TestODRWithSpriteAtlas Shared
//
//  Created by Payne Chu on 9/2/22.
//

import SpriteKit

class GameScene: SKScene {
    
    var resourceRequest: NSBundleResourceRequest?
    
    func setUpScene() {
        self.resourceRequest = NSBundleResourceRequest(tags: ["test"])
        self.resourceRequest?.conditionallyBeginAccessingResources(completionHandler: { available in
            if available {
                self.setUpNodes()
            } else {
                self.resourceRequest?.beginAccessingResources(completionHandler: { error in
                    if error != nil {
                        NSLog(error!.localizedDescription)
                    } else {
                        self.setUpNodes()
                    }
                })
            }
        })
    }
    
    func setUpNodes() {
        // PDF SpriteAtlas
        let atlasA = SKTextureAtlas(named: "Sprites-A")
        let texA = atlasA.textureNamed("PdfSprite")
        let nodeA = SKSpriteNode(texture: texA, size: texA.size())
        nodeA.position = CGPoint(x: 100.0, y: 100.0)
        self.addChild(nodeA)
        
        // PNG SpriteAtlas
        let atlasB = SKTextureAtlas(named: "Sprites-B")
        let texB = atlasB.textureNamed("PngSprite")
        let nodeB = SKSpriteNode(texture: texB, size: texB.size())
        nodeB.position = CGPoint(x: -100.0, y: -100.0)
        self.addChild(nodeB)
        
        // PDF ImageSet
        let texC = SKTexture(imageNamed: "Pdf")
        let nodeC = SKSpriteNode(texture: texC, size: texC.size())
        nodeC.position = CGPoint(x: 100.0, y: -100.0)
        self.addChild(nodeC)
        
        // PNG ImageSet
        let texD = SKTexture(imageNamed: "Png")
        let nodeD = SKSpriteNode(texture: texD, size: texD.size())
        nodeD.position = CGPoint(x: -100.0, y: 100.0)
        self.addChild(nodeD)
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
