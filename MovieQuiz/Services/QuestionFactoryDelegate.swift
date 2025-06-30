//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Илья on 15.04.2025.
//
import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
