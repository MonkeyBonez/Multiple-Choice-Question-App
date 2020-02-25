//
//  QuestionView.swift
//  MCQuestions
//
//  Created by Snehal Mulchandani on 2/22/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import UIKit

protocol QuestionViewDelegate: class {
    func didSelectAnswer(_ isCorrect: Bool)
}

@IBDesignable
public final class QuestionView: UIView {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerAButton: UIButton!
    @IBOutlet weak var answerBButton: UIButton!
    @IBOutlet weak var answerCButton: UIButton!
    @IBOutlet weak var answerDButton: UIButton!
    @IBOutlet weak var answerEButton: UIButton!
    
    
    private lazy var answerChoices: [UIButton] = [answerAButton,answerBButton,answerCButton,answerDButton,answerEButton]
    
    weak var delegate: QuestionViewDelegate?
    
    var dataSource: Question? {
        didSet {
            refreshUI()
        }
    }
    
    override init(frame: CGRect) {//?
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        let bundle = Bundle.init(for: QuestionView.self)
        if let viewsToAdd = bundle.loadNibNamed("QuestionView", owner: self, options: nil), let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight,
                                            .flexibleWidth]
        }
    }
    public func updateScore(correct: Int, total: Int){
        scoreLabel.text = "Score: " + String(correct) + "/" + String(total)
    }
    private func refreshUI() {
        guard let ds = dataSource else { return }
        
        // Configure Question
        let attrStr = try! NSMutableAttributedString(
            data: ds.questionText.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options:[.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
        
        attrStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 15), range: NSRange(location: 0, length: attrStr.length))
        

        
        answerChoices.forEach {
            $0.titleLabel?.numberOfLines = 0
            $0.titleEdgeInsets = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 10)
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
        }
        
        // Configure Answer choices
        questionLabel.attributedText = attrStr
        if(ds.answers.count > 0){
            answerAButton.setTitle("A. " + ds.answers[0].answerText, for: .normal)
        }
        else{
            //throw error
        }
        if(ds.answers.count > 1){
            answerBButton.isHidden = false;
            answerBButton.setTitle("B. " + ds.answers[1].answerText, for: .normal)
        }
        else{
            answerBButton.isHidden = true;
        }
        if(ds.answers.count > 2){
            answerCButton.isHidden = false;
            answerCButton.setTitle("C. " + ds.answers[2].answerText, for: .normal)
        }
        else{
             answerCButton.isHidden = true;
        }
        if(ds.answers.count > 3){
            answerDButton.isHidden = false;
            answerDButton.setTitle("D. " + ds.answers[3].answerText, for: .normal)
        }
        else{
             answerDButton.isHidden = true;
        }
        if(ds.answers.count > 4){
            answerEButton.isHidden = false;
            answerEButton.setTitle("E. " + ds.answers[4].answerText, for: .normal)
        }
        else{
            answerEButton.isHidden = true;
        }

    }
    
    
    @IBAction func selected(_ sender: UIButton) {
        guard let dataSource = dataSource else {return}
        var isCorrect = false
        switch sender {
            
                case(answerAButton):
                    if(dataSource.answers[0].id == Int(dataSource.correctAnswerID)){
                        isCorrect = true
                    }
                case answerBButton:
                    
                    if(dataSource.answers[1].id == Int(dataSource.correctAnswerID)){
                        isCorrect = true
                        
                }
                case answerCButton:
                    
                    if(dataSource.answers[2].id == Int(dataSource.correctAnswerID)){
                        isCorrect = true
                    }
                
                case answerDButton:
                   
                    if(dataSource.answers[3].id == Int(dataSource.correctAnswerID)){
                        isCorrect = true
                    }
                   
        
                case answerEButton:
                    
                    if(dataSource.answers[4].id == Int(dataSource.correctAnswerID)){
                        isCorrect = true
                    }
                    
        
                default:
                    break
                    }
        delegate?.didSelectAnswer(isCorrect)
    }
    
    
}
