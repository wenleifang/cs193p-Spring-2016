//
//  ViewController.swift
//  Calculator
//
//  Created by Dulio Denis on 5/1/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet fileprivate weak var display: UILabel!
    @IBOutlet fileprivate weak var calculationTape: UILabel!
    
    fileprivate var userIsInTheMiddleOfTyping = false
    fileprivate var decimalUsed = false

    @IBAction fileprivate func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            
            if digit == "." && decimalUsed == true {
                return
            } else if digit == "." && decimalUsed == false {
                decimalUsed = true
            }
            
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }
    
    // computed property is calculated when getting and setting
    fileprivate var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        
        set {
            display.text = String(newValue)
        }
    }

    fileprivate var brain = CalculatorBrain()
    
    @IBAction fileprivate func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        displayValue = brain.result
    }
    
    @IBAction func clear(_ sender: AnyObject) {
        userIsInTheMiddleOfTyping = false
        decimalUsed = false
        brain.clear()
        displayValue = brain.result
        display.text = "0"
    }
}

