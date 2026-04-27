//
//  Snack.swift
//  ESSI
//
//  Created by Jim Walejko on 4/22/26.
//

import Foundation
import SwiftData

@Model 
class Snack{
    var name: String
    var onHand: Int
    var notes: String
    var comfortLevel: Int
    
    init(name: String = "", onHand: Int = 0, notes: String = "", comfortLevel: Int = 1) {
        self.name = name
        self.onHand = onHand
        self.notes = notes
        self.comfortLevel = comfortLevel
    }
}

extension Snack{
    static var preview: ModelContainer{
        let container = try! ModelContainer(for: Snack.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        Task{ @MainActor in
            container.mainContext.insert(Snack(
                name: "Cheddar Goldfish",
                onHand: 3,
                notes: "Best eaten by the handful while doomscrolling.",
                comfortLevel: 1
            ))
            container.mainContext.insert(Snack(
                name: "Spicy Takis",
                onHand: 1,
                notes: "Left lips numb last time. No regrets.",
                comfortLevel: 2
            ))
            container.mainContext.insert(Snack(
                name: "Frozen Thin Mints",
                onHand: 3,
                notes: "A classy cold snack. Seasonal, like depression.",
                comfortLevel: 1
            ))
            container.mainContext.insert(Snack(
                name: "Trader Joe’s Scandinavian Swimmers",
                onHand: 2,
                notes: "Pretends to be healthy. Not fooling anyone.",
                comfortLevel: 3
            ))
            container.mainContext.insert(Snack(
                name: "Mom's Cookies",
                onHand: 1,
                notes: "Nothing better. Like a warm blanket",
                comfortLevel: 5
            ))
        }
        
        return container
    }
}
