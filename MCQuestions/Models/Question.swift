//
//  Question.swift
//  MCQuestions
//
//  Created by Snehal Mulchandani on 2/22/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import Foundation

// MARK: - WelcomeElement
struct Question: Codable {
    var id : String
    var correctAnswerID : String
    var questionText: String
    var category: String
    var answers: [Answer]

    enum CodingKeys: String, CodingKey {
        case id
        case correctAnswerID = "correct_answer_id"
        case questionText = "question_text"
        case category, answers
    }
}

