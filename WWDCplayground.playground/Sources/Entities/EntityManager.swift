import SpriteKit
import GameplayKit

public class EntityManager {
    var entities = Set<GKEntity>()
    let layer: SKNode?
    var toRemove = Set<GKEntity>()
    
    public init(layer: SKNode) {
        self.layer = layer
    }
    
    public func add(_ entity: GKEntity) {
        entities.insert(entity)
        for component in entity.components{
            if let spriteNode = (component as? SpriteComponent)?.node{
                layer?.addChild(spriteNode)
            }
        }
    }
    
    public func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        entities.remove(entity)
        toRemove.insert(entity)
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        toRemove.removeAll()
    }
    
}
