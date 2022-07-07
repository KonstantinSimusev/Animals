//
//  QuestionsViewController.swift
//  Animals
//
//  Created by Konstantin Simusev on 30.06.2022.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var numberOfQuestionLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var questionProgressView: UIProgressView!
    
    @IBOutlet var imagesView: [UIImageView]!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    @IBOutlet var multipleButton: UIButton!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var rangedButton: UIButton!
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangedSlider.maximumValue = answerCount
            rangedSlider.value = answerCount / 2
        }
    }
    
    // MARK: - Private Properties
    private let animals = AnimalType.allCases
    
    // MARK: - Private Properties
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var choosenAnswers: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        setImageView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultsVC = segue.destination as? ResultsViewController else { return }
        resultsVC.answers = choosenAnswers
    }
    
    // MARK: - IB Actions
    @IBAction func singleButtonAnswerPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        choosenAnswers.append(currentAnswer)
        nextQuestion()
    }
    
    @IBAction func multipleAnswerPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                choosenAnswers.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedPressed() {
        let index = lrintf(rangedSlider.value)
        choosenAnswers.append(currentAnswers[index])
        nextQuestion()
    }
    
}

// MARK: - Private Methods
extension QuestionsViewController {
    private func setupUI() {
        // Set background color
        view.addVerticalGradientLayr(
            topColor: Color.mediumSeaGreen,
            bottomColor: Color.steelBlue
        )
        
        // Hide stacks
        for stack in [singleStackView, multipleStackView, rangedStackView] {
            stack?.isHidden = true
        }
        
        // Get current question
        let currentQuestion = questions[questionIndex]
        
        // Set current question for question label
        questionLabel.text = currentQuestion.title
        
        // Calculate progress
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        // Set progress for progress view
        questionProgressView.setProgress(totalProgress, animated: true)
        
        // Set number of Question
        numberOfQuestionLabel.text = "Вопрос: \(questionIndex + 1) из \(questions.count)"
        
        // Show stack corresponding to question type
        showCurrentAnswers(for: currentQuestion.type)
        
        // Set sinngle buttons
        setSingleButton()
        
        // Set multiple buttons
        multipleButton.backgroundColor = .white.withAlphaComponent(0.3)
        multipleButton.contentVerticalAlignment = .bottom
        
        // Set ranged buttons
        rangedButton.backgroundColor = .white.withAlphaComponent(0.3)
        rangedButton.contentVerticalAlignment = .bottom
        
    }
    
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single: showSingleStackView(with: currentAnswers)
        case .multiple: showMultipleStackView(with: currentAnswers)
        case .ranged: showRangedStackView(with: currentAnswers)
        }
    }
    
    private func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    private func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            setupUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
    
    private func setImageView() {
        for (imageView, animal) in zip(imagesView, animals) {
            imageView.layer.borderWidth = 1.5
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.cornerRadius = imageView.frame.height / 2
            imageView.image = UIImage(named: animal.rawValue)
        }
    }
    
    private func setSingleButton() {
        singleButtons.forEach { button in
            button.layer.cornerRadius = 10
            button.backgroundColor = .white.withAlphaComponent(0.3)
            button.contentVerticalAlignment = .bottom
        }
    }
}
