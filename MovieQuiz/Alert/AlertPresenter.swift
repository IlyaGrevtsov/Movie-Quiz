//
//  Untitled.swift
//  MovieQuiz
//
//  Created by Илья on 17.04.2025.
//
import UIKit

class AlertPresenter {
    
    private weak var viewController:  UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    func show (data: AlertModel) {
        guard let viewController = viewController else { return }
        let alert = UIAlertController(
            title: data.title,
            message: data.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: data.buttonText, style: .default) {_ in data.completion?()}
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }

}
