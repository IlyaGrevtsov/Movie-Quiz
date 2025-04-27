//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Илья on 23.04.2025.
//

import Foundation

final class StatisticService: StatisticServiceProtocol {
    private let storage: UserDefaults = .standard
    private enum Keys: String {
        case correct
        case total
        case date
        case gamesCount
        case correctAnswer
    }
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: Keys.correct.rawValue)
            let total = storage.integer(forKey: Keys.total.rawValue)
            let date = storage.object(forKey: Keys.date.rawValue) as? Date ?? Date()
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            storage.set(newValue.correct, forKey: Keys.correct.rawValue)
            storage.set(newValue.total, forKey: Keys.total.rawValue)
            storage.set(newValue.date, forKey: Keys.date.rawValue)
        }
    }
    private var correctAnswers: Int {
        get {
            storage.integer(forKey: Keys.correctAnswer.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.correctAnswer.rawValue)
        }
    }
    var totalAccuracy: Double {
        let denominator = 10 * Double(gamesCount)
        return denominator != 0 ? (Double(correctAnswers) / denominator) * 100 : 0
    }
    func store(correct count: Int, total amount: Int) {
        correctAnswers += count
        gamesCount += 1
        let currentGameResult = GameResult(correct: count, total: amount, date: Date())
        if currentGameResult.isBetterThan(bestGame) {
            bestGame = currentGameResult
        }
    }
}
