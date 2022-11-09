//
//  QuizApiViewController.swift
//  QuizPrjct
//
//  Created by Bimal@AppStation on 07/06/22.

import UIKit

class QuizApiViewController: UIViewController {
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelFirstOption: UILabel!
    @IBOutlet weak var labelSecondOption: UILabel!
    @IBOutlet weak var labelThirdOption: UILabel!
    @IBOutlet weak var labelFourthOption: UILabel!
    @IBOutlet weak var viewFirstOption: UIView!
    @IBOutlet weak var viewSecondOption: UIView!
    @IBOutlet weak var viewThirdOption: UIView!
    @IBOutlet weak var viewFourthOption: UIView!
    @IBOutlet weak var buttonNext: UIButton!
    var arraySports = [SportsQuiz]()
    var arrayAnswers: [String] = []
    var arrayFirstAnswer: [String] = []
    var selectedAnswer: String!
    var currentQuestionIndex = 0;
    var currentIndex = -1;
    var selectedOption: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setapi()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    func setGradientBackground() {

        let colorTop =  UIColor(red: 250.0/255.0, green: 5.0/255.0, blue: 27.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 34.0/255.0, green: 25.0/255.0, blue: 34.0/255.0, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    func setapi() {
        let str = "https://opentdb.com/api.php?amount=10&category=21"
        let networkController = APINetworkController()
        networkController.callRequest(urlStr: str) { arrResult, val in
            print("Result Array: \(arrResult)")
            for dict in arrResult {
                let model = SportsQuiz(dict: dict)
                self.arraySports.append(model)
            }
            let model = self.arraySports[self.currentQuestionIndex]
                self.arrayFirstAnswer = [model.correct_answer]
                self.arrayFirstAnswer.insert(contentsOf:model.incorrect_answers, at:1)
                self.arrayFirstAnswer.shuffle()
                self.labelQuestion.text = model.question
                print("First Answer: \(self.arrayFirstAnswer)")
                self.labelFirstOption.text = self.arrayFirstAnswer[0]
                self.labelSecondOption.text = self.arrayFirstAnswer[1]
                self.labelThirdOption.text = self.arrayFirstAnswer[2]
                self.labelFourthOption.text = self.arrayFirstAnswer[3]
//                print(model)
            
            print("ArraySports: \(self.arraySports)")
        }
    }
    
    func setStyle() {
        buttonNext.layer.cornerRadius = 16
        buttonNext.layer.borderWidth = 1
        buttonNext.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        buttonNext.layer.shadowOpacity = 3.0
        buttonNext.layer.shadowOffset = CGSize(width: 30.0, height: 30.0)

    }
    @IBAction func buttonActionNext(sender: UIButton) {
        currentQuestionIndex += 1
       let model = arraySports[currentQuestionIndex]
        arrayAnswers = [model.correct_answer]
        arrayAnswers.insert(contentsOf:model.incorrect_answers, at:1)
        print(arrayAnswers)
        arrayAnswers.shuffle()
        print(arrayAnswers)
        self.labelQuestion.text = model.question
        self.labelFirstOption.text = arrayAnswers[0]
        self.labelSecondOption.text = arrayAnswers[1]
        self.labelThirdOption.text = arrayAnswers[2]
        self.labelFourthOption.text = arrayAnswers[3]
       
        
        self.viewFirstOption.backgroundColor = .white
        self.viewSecondOption.backgroundColor = .white
        self.viewThirdOption.backgroundColor = .white
        self.viewFourthOption.backgroundColor = .white
        self.labelFirstOption.textColor = UIColor.black
        self.labelSecondOption.textColor = UIColor.black
        self.labelThirdOption.textColor = UIColor.black
        self.labelFourthOption.textColor = UIColor.black
//        selectedAnswer = model.correct_answer
        
//        let buttonTitle = sender.titleLabel?.text
//        print(buttonTitle)
        
    }
    @IBAction func buttonActionFirstOption(sender: UIButton) {
        selectedOption = 1
        buttonSlected(value: selectedOption)
        
        if viewFirstOption.backgroundColor == .green {
            self.labelFirstOption.textColor = .white
        }
        else {
            self.labelFirstOption.textColor = .black
        }
        
    }
    @IBAction func buttonActionSecondOption(sender: UIButton) {
        selectedOption = 2
        buttonSlected(value: selectedOption)
        self.labelSecondOption.textColor = .black
    }
    @IBAction func buttonActionThirdOption(sender: UIButton) {
        selectedOption = 3
        buttonSlected(value: selectedOption)
        self.labelThirdOption.textColor = .black
    }
    @IBAction func buttonActionFourthOption(sender: UIButton) {
        selectedOption = 4
        buttonSlected(value: selectedOption)
        self.labelFourthOption.textColor = .black
    }
    
    func buttonSlected(value: Int) {
        switch value {
        case 1:
            let model = arraySports[currentQuestionIndex]
            if self.labelFirstOption.text == model.correct_answer {
                self.viewFirstOption.backgroundColor = .green
                self.viewSecondOption.backgroundColor = .white
                self.viewThirdOption.backgroundColor = .white
                self.viewFourthOption.backgroundColor = .white
            }
            else {
                self.viewFirstOption.backgroundColor = .red
                self.viewSecondOption.backgroundColor = .white
                self.viewThirdOption.backgroundColor = .white
                self.viewFourthOption.backgroundColor = .white
            }
            break
        case 2:
            let model = arraySports[currentQuestionIndex]
            if self.labelSecondOption.text == model.correct_answer {
                self.viewSecondOption.backgroundColor = .green
                self.viewFirstOption.backgroundColor = .white
                self.viewThirdOption.backgroundColor = .white
                self.viewFourthOption.backgroundColor = .white
            }
            else {
                self.viewFirstOption.backgroundColor = .white
                self.viewSecondOption.backgroundColor = .red
                self.viewThirdOption.backgroundColor = .white
                self.viewFourthOption.backgroundColor = .white
            }
            break
        case 3:
            let model = arraySports[currentQuestionIndex]
            if self.labelThirdOption.text == model.correct_answer {
                self.viewThirdOption.backgroundColor = .green
                self.viewFirstOption.backgroundColor = .white
                self.viewSecondOption.backgroundColor = .white
                self.viewFourthOption.backgroundColor = .white
            }
            else {
                self.viewFirstOption.backgroundColor = .white
                self.viewSecondOption.backgroundColor = .white
                self.viewThirdOption.backgroundColor = .red
                self.viewFourthOption.backgroundColor = .white
            }
            break
        case 4:
            let model = arraySports[currentQuestionIndex]
            if self.labelFourthOption.text == model.correct_answer {
                self.viewFourthOption.backgroundColor = .green
                self.viewFirstOption.backgroundColor = .white
                self.viewSecondOption.backgroundColor = .white
                self.viewThirdOption.backgroundColor = .white
            }
            else {
                self.viewFirstOption.backgroundColor = .white
                self.viewSecondOption.backgroundColor = .white
                self.viewThirdOption.backgroundColor = .white
                self.viewFourthOption.backgroundColor = .red
            }
            break
        default:
            print("default")
        }
    }
    
    
    
    
//    @IBAction func buttonActionFirstOption(sender: UIButton) {
//        let models = arraySports[0]
//        if self.labelFirstOption.text == models.correct_answer {
//            self.viewFirstOption.backgroundColor = .green
//
//        }
//        else {
//            self.viewFirstOption.backgroundColor = .red
//            self.viewSecondOption.backgroundColor = .white
//            self.viewThirdOption.backgroundColor = .white
//            self.viewFourthOption.backgroundColor = .white
//
//        }
////        for models in arraySports {
////            if self.labelFirstOption.text == models.correct_answer {
////                self.viewFirstOption.backgroundColor = .green
////            }
////            else {
////                self.viewFirstOption.backgroundColor = .red
////                self.viewSecondOption.backgroundColor = .white
////                self.viewThirdOption.backgroundColor = .white
////                self.viewFourthOption.backgroundColor = .white
////            }
////        }
//    }
//    @IBAction func buttonActionSecondOption(sender: UIButton) {
//        let models = arraySports[1]
//        if self.labelFirstOption.text == models.correct_answer {
//            self.viewSecondOption.backgroundColor = .green
//        }
//        else {
//            self.viewFirstOption.backgroundColor = .white
//            self.viewSecondOption.backgroundColor = .red
//            self.viewThirdOption.backgroundColor = .white
//            self.viewFourthOption.backgroundColor = .white
//        }
//
////        for models in arraySports {
////            if self.labelSecondOption.text == models.correct_answer {
////                self.viewSecondOption.backgroundColor = .green
////            }
////            else {
////                self.viewFirstOption.backgroundColor = .white
////                self.viewSecondOption.backgroundColor = .red
////                self.viewThirdOption.backgroundColor = .white
////                self.viewFourthOption.backgroundColor = .white
////            }
////        }
//    }
//    @IBAction func buttonActionThirdOption(sender: UIButton) {
//        let models = arraySports[2]
//        if self.labelThirdOption.text == models.correct_answer {
//            self.viewThirdOption.backgroundColor = .green
//        }
//        else {
//            self.viewFirstOption.backgroundColor = .white
//            self.viewSecondOption.backgroundColor = .white
//            self.viewThirdOption.backgroundColor = .red
//            self.viewFourthOption.backgroundColor = .white
//        }
////        for models in arraySports {
////            if self.labelThirdOption.text == models.correct_answer {
////                self.viewThirdOption.backgroundColor = .green
////            }
////            else {
////                self.viewFirstOption.backgroundColor = .white
////                self.viewSecondOption.backgroundColor = .white
////                self.viewThirdOption.backgroundColor = .red
////                self.viewFourthOption.backgroundColor = .white
////            }
////        }
//    }
//    @IBAction func buttonActionFourthOption(sender: UIButton) {
//
//        let models = arraySports[3]
//        if self.labelFourthOption.text == models.correct_answer {
//            self.viewFourthOption.backgroundColor = .green
//        }
//        else {
//            self.viewFirstOption.backgroundColor = .white
//            self.viewSecondOption.backgroundColor = .white
//            self.viewThirdOption.backgroundColor = .white
//            self.viewFourthOption.backgroundColor = .red
//        }
////        for models in arraySports {
////            if self.labelFourthOption.text == models.correct_answer {
////                self.viewFourthOption.backgroundColor = .green
////            }
////            else {
////                self.viewFirstOption.backgroundColor = .white
////                self.viewSecondOption.backgroundColor = .white
////                self.viewThirdOption.backgroundColor = .white
////                self.viewFourthOption.backgroundColor = .red
////
////            }
////        }
//    }
    
}
class SportsQuiz {
    var category: String = ""
    var type: String = ""
    var difficulty: String = ""
    var question: String = ""
    var correct_answer: String = ""
    var isSelected: Bool = true
    var incorrect_answers: [String] = [String]()
    
    init(dict: Dictionary<String, Any>) {
        if let val = dict["category"] as? String {
            self.category = val
        }
        
        if let val = dict["type"] as? String {
            self.type = val
        }
        
        if let val = dict["difficulty"] as? String {
            self.difficulty = val
        }
        if let val = dict["question"] as? String {
            self.question = val
        }
        if let val = dict["correct_answer"] as? String {
            self.correct_answer = val
        }
        if let val = dict["incorrect_answers"]  as? Array<String> {
            self.incorrect_answers = val
        }
    }
}
