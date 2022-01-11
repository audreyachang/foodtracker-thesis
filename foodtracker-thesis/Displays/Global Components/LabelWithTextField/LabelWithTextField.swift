//
//  LabelWithTextField.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 10/01/22.
//

import UIKit

protocol LabelWithTextFieldDelegate: AnyObject{
    func isTextFieldFilled(was: Bool)
}

class LabelWithTextField: UIView {

    weak var delegate: LabelWithTextFieldDelegate?
    
    func setUp(dlgt: LabelWithTextFieldDelegate){
        self.delegate = dlgt
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        initWithNib()
    }
   
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        initWithNib()
        
    }
    
    func initWithNib(){
        
    }
}
