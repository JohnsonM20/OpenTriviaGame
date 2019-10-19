//
//  QuestionViewController.swift
//  FirstQuizGame
//
//  Created by Matthew Johnson on 9/24/19.
//  Copyright © 2019 Matthew Johnson. All rights reserved.
//

import UIKit
import JavaScriptCore

struct Question{
    
    var Question: String!
    var Answers: [String]!
    var Answer: Int!
    
}

struct TriviaQuestion{
    
    var Category: String!
    var numAnswers: String!
    var Difficuty: String!
    var Question: String!
    var correctAnswer: String!
    var incorrectAnswers: [String]!
    
}

class QuestionViewController: UIViewController {
    @IBOutlet var QuestionLabel: UILabel!
    @IBOutlet var Buttons: [UIButton]!
    
    var Questions = [Question]()
    var QNumber = Int()
    var AnswerNumber = Int()
    var sliderValue = Int()
    var numRoundQuestions = Int()
    @IBOutlet var progressBar: UIProgressView!
    var questionsAnswered = Int(0)
    var wrongAnswers = Int(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //let myURL = URL(string: "https://opentdb.com/api.php?amount=10")

        
        
        
        /*
        Questions = [
            Question(Question: "What is the fear of getting tickled by feathers?", Answers: ["TickledByFeatherPhobia","Pteronophobia","Knetrophobia","Photinthopia"], Answer: 1),
            Question(Question: "What is a baby spider called?", Answers: ["Arachnophobian","Smelling","Movling","Spiderling"], Answer: 3),
            Question(Question: "Heart attacks happen most on what day of the week?", Answers: ["Sunday","Monday","Friday","Weekends"], Answer: 1),
            Question(Question: "Which of these is banned in China?", Answers: ["Facebook","Skype","Twitter","All"], Answer: 3),
            Question(Question: "How many noses do Marine Worms have?", Answers: ["0","1","2","3"], Answer: 1),
            Question(Question: "How many stomachs do cows have?", Answers: ["0","1","2","4"], Answer: 3),
            Question(Question: "What is the most common goldfish name?", Answers: ["Fishy","Jaws","Jumper","Gilbert"], Answer: 1),
            Question(Question: "When was the first iPad released?", Answers: ["2008","2010","2012","2014"], Answer: 1),
            Question(Question: "How many dogs survived the Titanic sinking?", Answers: ["0","1","2","7"], Answer: 2),
            Question(Question: "Which country has the most dogs?", Answers: ["China","Russia","United States","Japan"], Answer: 2),
            Question(Question: "What is a group of frogs called?", Answers: ["Froglet","Army","Stampede","Frogger"], Answer: 1),
            Question(Question: "How deep is the world's largest swimming pool in feet?", Answers: ["50","92","108","361"], Answer: 1),
            Question(Question: "How many bites does it take the average person to eat a hot dog?", Answers: ["4","6","9","13"], Answer: 1),
            Question(Question: "In which state is it illegal to fish from the back of a horse?", Answers: ["Utah","Florida","Massachusetts","Every state"], Answer: 0),
            Question(Question: "How many human body parts are three letters long?", Answers: ["6","10","15","23"], Answer: 1),
            ]
        */
        
        removeQuestions()
        
        chooseQuestion()
    }
    
    func chooseQuestion(){
        if Questions.count > 0{
            progressBar.progress = Float(questionsAnswered)/Float(numRoundQuestions)
            print(questionsAnswered/numRoundQuestions)
            QNumber = Int(arc4random()) % Questions.count
            QuestionLabel.text = Questions[QNumber].Question
            AnswerNumber = Questions[QNumber].Answer
            
            for i in 0..<Buttons.count{
                Buttons[i].setTitle(Questions[QNumber].Answers[i], for: UIControl.State.normal)
            }
            Questions.remove(at: QNumber)
            questionsAnswered += 1
            resetButtons()
        } else {
            var file = "rightAnswers.txt"
            var text = String(questionsAnswered)

            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = dir.appendingPathComponent(file)
                do {
                    try text.write(to: fileURL, atomically: false, encoding: .utf8)
                }
                catch {}
            }
            
            file = "totalClicks.txt"
            text = String(wrongAnswers + questionsAnswered)
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = dir.appendingPathComponent(file)
                do {
                    try text.write(to: fileURL, atomically: false, encoding: .utf8)
                }
                catch {}
            }
            
            
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "Endgame")
            self.present(controller, animated: true, completion: nil)
        }
        
    }
    
    func removeQuestions(){
        
        let file = "quizData.txt"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                let selectedQuestions = try String(contentsOf: fileURL, encoding: .utf8)
                numRoundQuestions = Int(selectedQuestions) ?? 10
                print(Questions.count - (Int(selectedQuestions) ?? 10))
                while Questions.count > Int(selectedQuestions) ?? 10 {
                    QNumber = Int(arc4random()) % Questions.count
                    Questions.remove(at: QNumber)
                }
            }
            catch {}
        }
    }
    
    func resetButtons(){
        for i in 0...3{
            Buttons[i].backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func Button1(_ sender: UIButton) {
        if AnswerNumber == 0{
            sender.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.chooseQuestion()
            }
        } else{
            wrongAnswers += 1
            sender.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        }
    }
    @IBAction func Button2(_ sender: UIButton) {
        if AnswerNumber == 1{
            sender.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.chooseQuestion()
            }
        }else{
            wrongAnswers += 1
            sender.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        }
    }
    @IBAction func Button3(_ sender: UIButton) {
        if AnswerNumber == 2{
            sender.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.chooseQuestion()
            }
        }else{
            wrongAnswers += 1
            sender.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        }
    }
    @IBAction func Button4(_ sender: UIButton) {
        if AnswerNumber == 3{
            sender.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.chooseQuestion()
            }
        }else{
            wrongAnswers += 1
            sender.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        }
    }
}