//
//  ResultsViewController.swift
//  MCQuestions
//
//  Created by Snehal Mulchandani on 2/23/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    var incorrectQList = [Question]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    func loadScore(currNumCorrect : Int, currQuestionNum :Int){
        scoreLabel.text = "Score: " + (String (currNumCorrect)) + "/" + (String(currQuestionNum))
    }
       
    func loadWrongQuestions( incorrectList: [Question]){
        incorrectQList = incorrectList
        
    }

}
