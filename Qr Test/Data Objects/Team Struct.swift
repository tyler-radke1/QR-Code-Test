//
//  Team Struct.swift
//  Qr Test
//
//  Created by Tyler Radke on 6/7/23.
//

import Foundation

struct Team: Codable {
    var name: String
    var id: UUID = UUID()
    
    
    static var dummyTeams: [Team] = [
        Team(name: "The Broncos"),
        Team(name: "The Packers"),
        Team(name: "The Patriots"),
        Team(name: "The Buccannners")
    ]
}
