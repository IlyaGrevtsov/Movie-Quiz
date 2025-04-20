import UIKit


final class MovieQuizViewController: UIViewController {
    
    // MARK: - Button Action
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else { return }
        let givenAnsver = false
        
        showAnswerResult(isCorrect: givenAnsver == currentQuestion.correctAnswer)
        disableButton(in: noButtonOutlet)
    }
    
    @IBAction private func yesButtonClicket(_ sender: UIButton)  {
        guard let currentQuestion = currentQuestion else { return }
        let givenAnswer = true
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        disableButton(in: yesButtonOutlet)
    }
    
    @IBOutlet weak var noButtonOutlet: UIButton!
    
    @IBOutlet weak var yesButtonOutlet: UIButton!
    
    
    @IBOutlet private weak var counterLabel: UILabel!
    
    @IBOutlet private weak var textLabel: UILabel!
    
    @IBOutlet private weak var imageView: UIImageView!
    // MARK: -Variables
     var currentQuestionIndex = 0
     var correctAnswer = 0
    
    private let questionsAmount: Int = 10
    var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?
    private var alertPresenter: AlertPresenter?
  
    
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let questionFactory = QuestionFactory()
        questionFactory.delegate = self
        self.questionFactory = questionFactory
        questionFactory.requestNextQuestion()
        
        alertPresenter = AlertPresenter(viewController: self)
            }
    // MARK: - Function
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
        return questionStep
    }
    private func show(quiz step: QuizStepViewModel) {
        counterLabel.text = step.questionNumber
        imageView.image = step.image
        textLabel.text = step.question
    }
    private func showAnswerResult(isCorrect: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        correctAnswer = isCorrect ? correctAnswer + 1 : correctAnswer
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self else { return }
            self.showNextQuestionOrResults()
            self.imageView.layer.borderWidth = 0
        }
        
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 {
            guard let alertPresenter else { return }
            alertPresenter.show(data: AlertModel(title: "Этот раунд окончен!",
                                                 message: "Ваш результат: \(correctAnswer)/\(currentQuestionIndex + 1)",
                                                 buttonText: "Сыграть еще раз") { [weak self] in
                guard let self else { return }
                self.currentQuestionIndex = 0
                self.correctAnswer = 0
                self.questionFactory?.requestNextQuestion()
            }
        )} else {
            currentQuestionIndex += 1
            self.questionFactory?.requestNextQuestion()
            
        }
    }
 
    private func disableButton(in button: UIButton) {
        button.alpha = 0.5
        noButtonOutlet.isEnabled = false
        yesButtonOutlet.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.noButtonOutlet.isEnabled = true
            self.yesButtonOutlet.isEnabled = true
            button.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            button.alpha = 1
        }
    }
}

    // MARK: -Question Factory Delegate

extension MovieQuizViewController: QuestionFactoryDelegate {
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        currentQuestion = question
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async {[weak self] in
            self?.show(quiz: viewModel)
        }
    }
}



