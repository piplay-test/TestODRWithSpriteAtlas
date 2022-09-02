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
        let atlasA = SKTextureAtlas(named: "Sprites-A")
        let texA = atlasA.textureNamed("PdfSprite")
        let pdfNode = SKSpriteNode(texture: texA, size: texA.size())
        pdfNode.position = CGPoint(x: 100.0, y: 100.0)
        self.addChild(pdfNode)
        
        let atlasB = SKTextureAtlas(named: "Sprites-B")
        let texB = atlasB.textureNamed("PngSprite")
        let pngNode = SKSpriteNode(texture: texB, size: texB.size())
        pngNode.position = CGPoint(x: -100.0, y: -100.0)
        self.addChild(pngNode)
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
