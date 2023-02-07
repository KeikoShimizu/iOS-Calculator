//
//  ViewController.swift
//  Calculator
//
//  Created by SHIMIZU KEIKO on 2023-01-20.
//

import UIKit

enum modes {
    case not_set
    case addition
    case subtraction
    case multiplication
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var labelString: String = "0"
    var currentMode: modes = .not_set
    var saveNum: Int = 0
    var lastButtonWasMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didPressPlus(_ sender: Any) {
        changeModes(newMode: .addition)
    }
    
    
    @IBAction func didPressSubtract(_ sender: Any) {
        changeModes(newMode: .subtraction)
    }
    
    
    @IBAction func didPressMultiply(_ sender: Any) {
        changeModes(newMode: .multiplication)
    }
    
    
    @IBAction func didPressEquals(_ sender: Any) {
        guard let labelInt: Int = Int(labelString) else {
            return
        }
        
        if(currentMode == .not_set || lastButtonWasMode){
            return
        }
        if(currentMode == .addition){
            saveNum += labelInt
        }
        else if(currentMode == .subtraction){
            saveNum -= labelInt
        }
        else if(currentMode == .multiplication){
            saveNum *= labelInt
        }
        
        currentMode = .not_set
        labelString = "\(saveNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    
    @IBAction func didPressClear(_ sender: Any) {
        labelString = "0"
        currentMode = .not_set
        saveNum = 0
        lastButtonWasMode = false
        label.text = "0"
    }
    
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue: String? = sender.titleLabel?.text
        
        if(lastButtonWasMode){
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString.appending(stringValue!)
        updateText()
    }
    
    //read number as string then convert to int then convert back to string
    func updateText() {
        guard let labelInt: Int = Int(labelString) else {
            return
        }
        if(currentMode == .not_set){
            saveNum = labelInt
        }
        
        //Display decimal when the number is 1000  display 1,000
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num: NSNumber = NSNumber(value: labelInt)
        
        label.text = formatter.string(from: num)
        
//        label.text = "\(labelInt)"
    }
    
    func changeModes(newMode: modes) {
        if(saveNum == 0){
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
    }
}

