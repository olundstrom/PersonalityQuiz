//
//  QuestionData.swift
//  P02_Quiz-Lundstrom
//
//  Created by Olivia Lundstrom on 4/29/19.
//  Copyright © 2019 Olivia Lundstrom. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: dogBreed
}

enum dogBreed: String {
    case goldenRetriever = "Golden Retriever", germanShepherd = "German Shepherd", bullDog = "Bull Dog", siberianHusky = "Siberian Husky"
    
    var definition: String {
        switch self {
        case .goldenRetriever:
            return "You are playful and outgoing. You love to spend time your family and friends, and you know just how to lift people's spirits when they are feeling down."
        case .germanShepherd:
            return "You are loyal and fierce. You never back away from a challenge and would do anything for the people you love."
        case .bullDog:
            return "You are observant and levelheaded. You approach problems by thoroughly observing and analyzing them before making a logical decision."
        case .siberianHusky:
            return "You are adventurous and spirited. You are always eager to try new things and put youself out of your comfort zone."
        }
        
    }
}
