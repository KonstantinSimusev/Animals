//
//  ResultsViewController.swift
//  Animals
//
//  Created by Konstantin Simusev on 30.06.2022.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var animalImageView: UIImageView!
    @IBOutlet var definitionLabel: UILabel!
    
    // MARK: - Public Properties
    var answers: [Answer]!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateResult()
    }
    
    override func viewDidLayoutSubviews() {
        setImageView()
    }
}

// MARK: - Private Methods
extension ResultsViewController {
    private func updateResult() {
        var frequencyOfAnimals: [AnimalType: Int] = [:]
        let animals = answers.map { $0.type }
        
        for animal in animals {
            if let animalTypeCount = frequencyOfAnimals[animal] {
                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
            } else {
                frequencyOfAnimals[animal] = 1
            }
        }
        
        let sortedFrequensyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        guard let mostFrequencyAnimal = sortedFrequensyOfAnimals.first?.key else { return}
        
        updateUI(with: mostFrequencyAnimal)
    }
    
    private func setupUI() {
        view.addVerticalGradientLayr(
            topColor: Color.steelBlue,
            bottomColor: Color.mediumSeaGreen
        )
        
        navigationItem.hidesBackButton = true
        
    }
    
    private func setImageView() {
        animalImageView.layer.borderWidth = 1.5
        animalImageView.layer.borderColor = UIColor.white.cgColor
        animalImageView.layer.cornerRadius = animalImageView.frame.height / 2
    }
    
    private func updateUI(with animal: AnimalType?) {
        animalImageView.image = UIImage(named: animal?.rawValue ?? "👋")
        definitionLabel.text = animal?.definition ?? "👋"
        
    }
}
