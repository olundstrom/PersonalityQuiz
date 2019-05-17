//
//  ResultsViewController.swift
//  P02_Quiz-Lundstrom
//
//  Created by Olivia Lundstrom on 4/29/19.
//  Copyright © 2019 Olivia Lundstrom. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    var responses: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func calculatePersonalityResult() {
        var frequencyOfAnswers: [dogBreed: Int] = [:]
        let responseTypes = responses.map { $0.type }
        
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response]
                ?? 0) + 1
        }
        
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by:
        {(pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 >
            $1.1 }.first!.key
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }
}
