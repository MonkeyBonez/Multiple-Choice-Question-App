//
//  Answer.swift
//  MCQuestions
//
//  Created by Snehal Mulchandani on 2/22/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import Foundation

struct Answer: Codable {
    var id: Int
    var chosenPercentage: Double
    var answerText: String

    enum CodingKeys: String, CodingKey {
        case id
        case chosenPercentage = "chosen_percentage"
        case answerText = "answer_text"
    }
}
