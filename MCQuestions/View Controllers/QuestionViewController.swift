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
    var incorrectQList = [Question]()
    var currQuestionNum = 0
    var currNumCorrect = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
       
        super.viewDidLoad()
        questionView.delegate = self
        loadQuestions()
    }
    
    private func loadQuestions() {
        let source = "http://lsatmaxadmin.us/interview/loadDataIOS.php"
        
        
        
         if let url = URL(string: source), let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
            guard let questions = try? decoder.decode([Question].self, from: data) else { return }
            qList = questions
            questionView.dataSource = questions[0]
        }
        
    }
   
    private func finishTest(){
        
        let alert = UIAlertController(title: "Congrats, you got \(currNumCorrect) out of \(currQuestionNum) Correct. ", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { action in
                if let navController = self.navigationController {
                navController.popViewController(animated: true)
        }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    private func nextQuestion(){
        currQuestionNum += 1
        if(currQuestionNum >= qList.count){
            finishTest()
        }
        else{
            updateScore()
            questionView.dataSource = qList[currQuestionNum]
        }
        
    }
    private func updateScore(){
        scoreLabel.text = "Score: " + String(currNumCorrect) + "/" + String(currQuestionNum)
    }
    
}

extension QuestionViewController: QuestionViewDelegate {
    
    func didSelectAnswer(_ isCorrect: Bool) {
        if isCorrect { currNumCorrect += 1 }
        else{ incorrectQList.append(qList[currQuestionNum])}
        nextQuestion();
    }
}

