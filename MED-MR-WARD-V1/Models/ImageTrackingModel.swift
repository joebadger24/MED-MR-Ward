//
//  ImageTrackingModel.swift
//  MED-MR-WARD-V1
//
//  Created by Joe Badger on 16/07/2024.
//

import Foundation
import ARKit
import SwiftUI
import RealityKit
import Observation

// Code based on https://github.com/satoshi0212/visionOS_30Days

@Observable
@MainActor
class ImageTrackingModel 
{
    private let session = ARKitSession()

    private let imageTrackingProvider = ImageTrackingProvider(
        referenceImages: ReferenceImage.loadReferenceImages(inGroupNamed: "Target")
    )

    private var contentEntity1 = Entity()
    private var contentEntity2 = Entity()
    public var entityMap: [UUID: Entity] = [:]

    func setupContentEntity1() -> Entity
    {
        return contentEntity1
    }
    
    func setupContentEntity2() -> Entity
    {
        return contentEntity2
    }

    func runSession() async
    {
        do
        {
            if ImageTrackingProvider.isSupported
            {
                try await session.run([imageTrackingProvider])
                print("[\(type(of: self))] [\(#function)] session.run")
            }
        }
        catch
        {
            print(error)
        }
    }

    func processImageTrackingUpdates() async
    {
        print("[\(type(of: self))] [\(#function)] called")

        for await update in imageTrackingProvider.anchorUpdates
        {
            updateImage(update.anchor)
        }
    }

    func monitorSessionEvents() async
    {
        for await event in session.events
        {
            switch event {
            case .authorizationChanged(type: _, status: let status):
                print("Authorization changed to: \(status)")
                if status == .denied {
                    print("Authorization status: denied")
                }
            case .dataProviderStateChanged(dataProviders: let providers, newState: let state, error: let error):
                print("Data provider changed: \(providers), \(state)")
                if let error {
                    print("Data provider reached an error state: \(error)")
                }
            @unknown default:
                fatalError("Unhandled new event type \(event)")
            }
        }
    }

    private func updateImage(_ anchor: ImageAnchor) 
    {
        if entityMap[anchor.id] == nil 
        {
            let entity: Entity
            switch anchor.referenceImage.name
            {
            case "Cot1":
                entity = createCotEntity(withText: "Cot 1: Joe Bloggs")
                entityMap[anchor.id] = entity
                contentEntity1.addChild(entity)
                contentEntity1.position = [-0.2, 0.3, 0]
                contentEntity1.components.set(InputTargetComponent())
                contentEntity1.components.set(HoverEffectComponent())
                contentEntity1.generateCollisionShapes(recursive: true)
                
            case "Cot2":
                entity = createCotEntity(withText: "Cot 2: Jane Doe")
                entityMap[anchor.id] = entity
                contentEntity2.addChild(entity)
                contentEntity2.position = [0, 0.3, 0]
                contentEntity2.components.set(InputTargetComponent())
                contentEntity2.components.set(HoverEffectComponent())
                contentEntity2.generateCollisionShapes(recursive: true)
                
            default:
                entity = createCotEntity(withText: "Unknown Cot")
                entityMap[anchor.id] = entity
                contentEntity1.addChild(entity)
                contentEntity1.position = [0, 0.3, 0]
                contentEntity1.components.set(InputTargetComponent())
                contentEntity1.components.set(HoverEffectComponent())
                contentEntity1.generateCollisionShapes(recursive: true)
            }
        }

        if anchor.isTracked 
        {
            entityMap[anchor.id]?.transform = Transform(matrix: anchor.originFromAnchorTransform)
        }
    }
    
    public func createCotEntity(withText text: String) -> Entity
    {
        let textMesh = MeshResource.generateText(text, extrusionDepth: 0.01, font: .systemFont(ofSize: 0.05), containerFrame: .zero, alignment: .center, lineBreakMode: .byTruncatingTail)
        let textMaterial = UnlitMaterial(color: UIColor.black)
        let textEntity = ModelEntity(mesh: textMesh, materials: [textMaterial])
        textEntity.position = [0, 0, 0]
        
        let borderMesh = MeshResource.generateBox(width: 0.5, height: 0.1, depth: 0.01)
        let borderMaterial = UnlitMaterial(color: .gray)
        let borderEntity = ModelEntity(mesh: borderMesh, materials: [borderMaterial])
        borderEntity.position = [0.22, 0.03, -0.01]
        
        let parentEntity = Entity()
        parentEntity.addChild(textEntity)
        parentEntity.addChild(borderEntity)
        parentEntity.name = text
        
        return parentEntity
        
    }
}
