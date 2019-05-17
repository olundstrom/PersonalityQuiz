//
//  QuestionViewController.swift
//  P02_Quiz-Lundstrom
//
//  Created by Olivia Lundstrom on 4/29/19.
//  Copyright © 2019 Olivia Lundstrom. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multipleLabel1: UILabel!
    @IBOutlet weak var multipleLabel2: UILabel!
    @IBOutlet weak var multipleLabel3: UILabel!
    @IBOutlet weak var multipleLabel4: UILabel!
    @IBOutlet weak var multipleSwitch1: UISwitch!
    @IBOutlet weak var multipleSwitch2: UISwitch!
    @IBOutlet weak var multipleSwitch3: UISwitch!
    @IBOutlet weak var multipleSwitch4: UISwitch!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var questions: [Question] = [
        Question(text: "Which season do you prefer?",
                 type: .single,
                 answers: [
                    Answer(text: "Spring", type: .bullDog),
                    Answer(text: "Summer", type: .goldenRetriever),
                    Answer(text: "Fall", type: .germanShepherd),
                    Answer(text: "Winter", type: .siberianHusky)
            ]),
        
        Question(text: "What do you like to do in your free time?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Take a nap", type: .bullDog),
                    Answer(text: "Watch TV", type: .germanShepherd),
                    Answer(text: "Hang out with friends", type: .goldenRetriever),
                    Answer(text: "Play a sport", type: .siberianHusky)
            ]),
        
        Question(text: "How do you feel about meeting new people?",
                 type: .ranged,
                 answers: [
                    Answer(text: "I don't like strangers", type: .germanShepherd),
                    Answer(text: "I'd rather be with people I know", type: .bullDog),
                    Answer(text: "I don't mind it", type: .siberianHusky),
                    Answer(text: "I love new people", type: .goldenRetriever)
            ])
    ]
    
    
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multipleSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multipleSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
            }
        if multipleSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
            }
        if multipleSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
            }
        
        nextQuestion()
        }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value *
            Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) /
            Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated:
            true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multipleSwitch1.isOn = false
        multipleSwitch2.isOn = false
        multipleSwitch3.isOn = false
        multipleSwitch4.isOn = false
        multipleLabel1.text = answers[0].text
        multipleLabel2.text = answers[1].text
        multipleLabel3.text = answers[2].text
        multipleLabel4.text = answers[3].text
    }
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as!
                ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
}
