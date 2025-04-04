import UIKit


final class MovieQuizViewController: UIViewController {
    // MARK: - Button Action

    @IBAction private func noButtonClicked(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnsver = false
        
        showAnswerResult(isCorrect: givenAnsver == currentQuestion.correctAnswer)
        
        
        sender.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            sender.isEnabled = true
        }
    }
    
    @IBAction private func yesButtonClicket(_ sender: UIButton)  {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = true
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        
        sender.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            sender.isEnabled = true
        }
    }
    
    @IBOutlet private weak var counterLabel: UILabel!
    
    @IBOutlet private weak var textLabel: UILabel!
    
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Lifecycle
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image: "The Godfather",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Dark Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Kill Bill",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Avengers",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Deadpool",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Green Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Old",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Tesla",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Vivarium",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
    
    ]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        show(quiz: convert(model: questions[currentQuestionIndex]))
    }
    private var currentQuestionIndex = 0
    private var correctAnswer = 0
 
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
      let questionStep = QuizStepViewModel(
        image: UIImage(named: model.image) ?? UIImage(),
        question: model.text,
        questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestionOrResults()
            self.imageView.layer.borderWidth = 0
       }

    }
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questions.count - 1 {
            show(quiz: QuizResultViewModel(title: "Этот раунд окончен!",
                                           text: "Ваш результат: \(correctAnswer)/\(currentQuestionIndex + 1)",
                                           buttonText: "Сыграть еще раз"))
        } else {
            currentQuestionIndex += 1
            
            let nextQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: nextQuestion)
            show(quiz: viewModel)
        }
    }
    func show (quiz result: QuizResultViewModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            self.currentQuestionIndex = 0
            self.correctAnswer = 0
            
            let firstQuestion = self.questions[self.currentQuestionIndex]
            let viewModel = self.convert(model: firstQuestion)
            self.show(quiz: viewModel)
        }
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
 
}

