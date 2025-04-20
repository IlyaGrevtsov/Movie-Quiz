//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Илья on 17.04.2025.
//
import Foundation
import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (() -> Void)?
}

