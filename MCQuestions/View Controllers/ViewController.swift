//
//  ViewController.swift
//  MCQuestions
//
//  Created by Snehal Mulchandani on 2/22/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func didTapStartButton(_ sender: Any) {//send to questions after start button clicked
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "QuestionVC") as! QuestionViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    

}

