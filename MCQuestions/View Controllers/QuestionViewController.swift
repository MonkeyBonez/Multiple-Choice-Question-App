//
//  QuestionViewController.swift
//  MCQuestions
//
//  Created by Snehal Mulchandani on 2/22/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import UIKit
class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionView: QuestionView!
    
    private var qList = [Question]()
    var incorrectQList = [Question]()//store questions answered incorrectly to show user later(incomplete)
    var currQuestionNum = 0
    var currNumCorrect = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() { //configure to be delegate of questionView
       
        super.viewDidLoad()
        questionView.delegate = self
        loadQuestions()
    }
    
    private func loadQuestions() {//parses JSON data for questions and answers from website and create objects
        let source = "http://lsatmaxadmin.us/interview/loadDataIOS.php"
        
        
        
         if let url = URL(string: source), let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
            guard let questions = try? decoder.decode([Question].self, from: data) else { return }
            qList = questions
            questionView.dataSource = questions[0] //triggers questionView to update with first question
        }
        
    }
   
    private func finishTest(){//creates alert with score, once test is complete
        
        let alert = UIAlertController(title: "Congrats, you got \(currNumCorrect) out of \(currQuestionNum) Correct. ", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { action in
                if let navController = self.navigationController {
                navController.popViewController(animated: true)
        }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    private func nextQuestion(){//updates all variables to continue tracking and display next question
        currQuestionNum += 1
        if(currQuestionNum >= qList.count){
            finishTest()
        }
        else{
            updateScore()
            questionView.dataSource = qList[currQuestionNum] //triggers questionView to display next question
        }
        
    }
    private func updateScore(){
        scoreLabel.text = "Score: " + String(currNumCorrect) + "/" + String(currQuestionNum)
    }
    
}

extension QuestionViewController: QuestionViewDelegate {
    
    func didSelectAnswer(_ isCorrect: Bool) {//recieves from questionView if user answered the question correctly
        if isCorrect { currNumCorrect += 1 }
        else{ incorrectQList.append(qList[currQuestionNum])}
        nextQuestion();
    }
}

