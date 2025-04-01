//
//  QuizQuestion.swift
//  MovieQuiz
//
//  Created by Илья on 31.03.2025.
//
import Foundation
import UIKit

struct QuizQuestion {
    let image: String
    let text: String
    let correctAnswer: Bool
}
struct QuizStepViewModel {
    let image: UIImage
    let question: String
    let questionNumber: String
}
struct QuizResultViewModel {
    let title: String
    let text: String
    let buttonText: String
}
