//
//  ViewController.swift
//  Animals
//
//  Created by Konstantin Simusev on 30.06.2022.
//

import UIKit

class IntroductionViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var animalsImagesView: [UIImageView]!
    @IBOutlet var startButton: UIButton!
    
    // MARK: - Private Properties
    private let animals = AnimalType.allCases
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        setImageView()
    }
    // MARK: - IB Actions
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {}
}

// MARK: - Private Methods
extension IntroductionViewController {
    private func setupUI() {
        view.addVerticalGradientLayr(
            topColor: Color.steelBlue,
            bottomColor: Color.mediumSeaGreen
        )
        
        setStartButton()
    }
    
    private func setImageView() {
        for (imageView, animal) in zip(animalsImagesView, animals) {
            imageView.layer.borderWidth = 1.5
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.cornerRadius = imageView.frame.height / 2
            imageView.image = UIImage(named: animal.rawValue)
        }
    }
    
    private func setStartButton() {
        startButton.backgroundColor = .white.withAlphaComponent(0.3)
        startButton.layer.cornerRadius = 10
        startButton.contentVerticalAlignment = .bottom
    }
}



