//
//  CalculatorMastermind.swift
//  Calculator
//
//  Created by Ege Tanboga on 5/6/17.
//  Copyright © 2017 Ege Tanboga. All rights reserved.
//

import Foundation

let SPEEDOFLIGHT = 299792458.0;
let GRAVITATIONALCONSTANT = 6.67408*pow(10.0 ,-11);
let PLANCKCONSTANT = 6.626070040*pow(10.0, -34);
let GRAVITATIONALACCELERATION = 9.80665;
let STANDARDATMOSPHERE = 101325.0;
let STEFANBOLTZMANNCONSTANT = 5.670367*pow(10.0,-8);
let GASCONSTANT = 8.3144598;
let ELEMENTARYCHARGE = 1.6021766208;
let AVOGADRO = 6.022140857*pow(10.0,23)
let PROTONMASS = 1.672621898*pow(10.0,-27)
let NEUTRONMASS = 1.674927471*pow(10.0,-27)
let PERMITIVITYOFFREESPACE = 8.854187817*pow(10.0,-12)
let ATOMICMASSCONSTANT = 1.660539040*pow(10.0,-27)
let SPECIFICHEATOFWATER = 4.18


class CalculatorMastermind
{
    private var accumulator = 0.0
    
     func set(value: Double){        //value is basically the thing we are going to oparate with and display in our screen
        accumulator = value;
    }
    
    private var operations: Dictionary<String,Op> = [
    "π": Op.ConstantVal(Double.pi),
    "e": Op.ConstantVal(M_E),    //so I just need to add constants here to get a physics calculator
    "c": Op.ConstantVal(SPEEDOFLIGHT),
    "G": Op.ConstantVal(GRAVITATIONALCONSTANT),
    "h": Op.ConstantVal(PLANCKCONSTANT),
    "g": Op.ConstantVal(GRAVITATIONALACCELERATION),
    "atm": Op.ConstantVal(STANDARDATMOSPHERE),
    "σ": Op.ConstantVal(STEFANBOLTZMANNCONSTANT),
    "R": Op.ConstantVal(GASCONSTANT),
    "e-": Op.ConstantVal(ELEMENTARYCHARGE),
    "Avogadro": Op.ConstantVal(AVOGADRO),
    "mass of proton": Op.ConstantVal(PROTONMASS),
    "mass of neutron": Op.ConstantVal(NEUTRONMASS),
    "permitivity of free space": Op.ConstantVal(PERMITIVITYOFFREESPACE),
    "atomic mass constant": Op.ConstantVal(ATOMICMASSCONSTANT),
    "specific heat of water": Op.ConstantVal(SPECIFICHEATOFWATER),
    "√": Op.UnaryOp(sqrt),
    "cos": Op.UnaryOp(cos),
    "sin": Op.UnaryOp(sin),
    "×": Op.BinaryOp({$0 * $1}),  //$ sign gives out the argument, for example $0 is first argument, $1 is second. Swift knows what is going on behind the scenes so we do not even need return
    "÷": Op.BinaryOp({$0 / $1}),
    "+": Op.BinaryOp({$0 + $1}),
    "−": Op.BinaryOp({$0 - $1}),
    "=": Op.Equal
    ]
    
    private enum Op {   //cannot have inheritance, they are passed by value
        case ConstantVal(Double)
        case UnaryOp((Double)->Double)
        case BinaryOp ((Double,Double)->Double)
        case Equal
    
    }
    
     func performOp(symbol: String){
        if let op = operations[symbol] {
            switch op
            {       //we are doing op.ConstantVal but swift is able to infer what that is
            case .ConstantVal(let associated):
                accumulator=associated;
            case .UnaryOp(let associated):
                accumulator=associated(accumulator)  //in this case and the case below, associated is a function instead of a double
            case .BinaryOp(let associated):
                execPendingBinaryOp()
                pending = PendingInfo(binaryFunc: associated, firstOp: accumulator)
            case .Equal:
                execPendingBinaryOp()
            }
        }
    
    }
    
    private func execPendingBinaryOp()
    {
        if pending != nil
        {
            accumulator = pending!.binaryFunc(pending!.firstOp, accumulator)
            pending = nil
        }

    }
    
    private var pending: PendingInfo?
    
    private struct PendingInfo {
        var binaryFunc: (Double, Double) ->Double
        var firstOp: Double
    }
    
    var currentnum: Double{
        get {
            return accumulator
        }
    }

}
