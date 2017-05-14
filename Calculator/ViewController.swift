//
//  ViewController.swift
//  Calculator
//
//  Created by Ege Tanboga on 4/15/17.
//  Copyright © 2017 Ege Tanboga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var Display: UILabel!
    
    private var amItyping=false
    
    private var valueDisplayed: Double {
        get {
            return Double(Display.text!)!
        }
        set {
            Display.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if amItyping
        {
            let textCurrentlyInDisplay = Display.text!
            Display.text = textCurrentlyInDisplay+digit
        }
        else
        {
            Display.text=digit
        }
        amItyping=true
    }
    
        private var mind: CalculatorMastermind=CalculatorMastermind()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if amItyping {
        mind.set(value: valueDisplayed)
        amItyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            mind.performOp(symbol: mathematicalSymbol)
        }
        valueDisplayed=mind.currentnum
    }
}

