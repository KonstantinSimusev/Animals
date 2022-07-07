//
//  Question.swift
//  Animals
//
//  Created by Konstantin Simusev on 30.06.2022.
//

import UIKit

struct Question {
    let title: String
    let type: ResponseType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [
            Question(
                title: "Какую пищу ты предпочитаешь?",
                type: .single,
                answers: [
                    Answer(title: "Мясо", type: .dog),
                    Answer(title: "Рыба", type: .cat),
                    Answer(title: "Морковь", type: .rabbit),
                    Answer(title: "Кукуруза", type: .turtle)
                ]
            ),
            Question(
                title: "Что тебе нравится больше?",
                type: .multiple,
                answers: [
                    Answer(title: "Плавать", type: .dog),
                    Answer(title: "Спать", type: .cat),
                    Answer(title: "Есть", type: .rabbit),
                    Answer(title: "Загорать", type: .turtle)
                ]
            ),
            Question(
                title: "Любишь ли ты поездки на машине?",
                type: .ranged,
                answers: [
                    Answer(title: "Гадость", type: .dog),
                    Answer(title: "Терпимо", type: .cat),
                    Answer(title: "Ровно", type: .rabbit),
                    Answer(title: "Полный улёт", type: .turtle)
                ]
            )
        ]
    }
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

struct Answer {
    let title: String
    let type: AnimalType
}

enum AnimalType: String, CaseIterable {
    case dog = "Dog"
    case cat = "Cat"
    case rabbit = "Rabbit"
    case turtle = "Turtle"
    
    var definition: String {
        switch self {
        case .dog:
            return """
                    ...тусишь с друзьями 🤪
                    ...липнешь к людям 😇
                    ...как Чип и Дейл спешишь на помощь 😊
                    """
        case .cat:
            return """
                    ...сам себе на уме 🤪
                    ...тусишь в одного 😇
                    ...торчишь от вкусняшек 😊
                    """
        case .rabbit:
            return """
                    ...любитель мягкого 🤪
                    ...здоров как бык 😇
                    ...энергия на максималках 😊
                    """
        case .turtle:
            return """
                    ...мудрый не по годам 🤪
                    ...медленный просто чума 😇
                    ...думаешь как пентиум 😊
                    """
        }
    }
}
