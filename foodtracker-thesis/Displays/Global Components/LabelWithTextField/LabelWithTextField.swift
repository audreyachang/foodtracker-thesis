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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
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
        textField.delegate = self
        setupStyle()
    }
    
    convenience init(title: String, textFieldPh: String, textFieldData: String?){
        self.init()
        titleLabel.text = title
        textField.placeholder = textFieldPh
        textField.text = textFieldData
        textField.delegate = self
    }
    
    fileprivate func initWithNib(){
        guard let view = loadViewFromNib(nibName: "LabelWithTextField")else {return}
        view.frame = self.bounds
        self.addSubview(view)
        
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

extension LabelWithTextField: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 4 {
            delegate?.isTextFieldFilled(was: true)
        }else{
            delegate?.isTextFieldFilled(was: false)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    func setupStyle(){
        textField.tintColor = .black
        textField.layer.cornerRadius = 5
    }
}
