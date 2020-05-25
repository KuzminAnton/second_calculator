//
//  Calculation.swift
//  CalculatorTextView
//
//  Created by Антон on 02.05.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import Foundation
import UIKit

protocol ColculationDelegate: class {
    func showResult(_ res: String)
}
class Calculation: ObservableObject {
    let calcRPN = CalculationRPN()
    weak var delegate: ColculationDelegate?

    var firstArgument: String = ""
    var lastArgument: String = ""
    var lastValue: String = ""
    var flag: Bool = true

    var secondArgument = ""
    var action = ""
    var value = ""
    
    func calculateData(button: String) {
        value = button
        
        if ("C".contains(value)){
                  secondArgument = ""
                  firstArgument = ""
                  action = ""
                  delegate?.showResult(firstArgument)
              }
        if ("%".contains(value)) {
            if (firstArgument.contains("+") || firstArgument.contains("-") || firstArgument.contains("*") || firstArgument.contains("/")){
                
                let fullName = firstArgument.split{($0 == "-") || ($0 == "+") || ($0 == "*")}
                let fullName2 = fullName.joined(separator: "/").split{($0 == "/") || ($0 == "^")}
                let fullName3 = fullName2.joined(separator: "(").split{($0 == "(") || ($0 == ")")}
                            
                var str:[String] = []
                
                for e in fullName3{
                    str.append(String(e))
                }
                //print("Массив чисел",str)
                var indexAddElem = 1
                for elem in firstArgument{
                    //print("elem",elem)
                    if("*/+-^".contains(String(elem))){
                        //print("*/+-^",indexAddElem)
                        if(indexAddElem == str.count)
                        {
                            str.append(String(elem))
                        }
                        else
                        {
                        str.insert(String(elem), at: indexAddElem)
                        indexAddElem = indexAddElem + 2
                        }
                    }
                    if("(".contains(String(elem))){
                        //print("(",indexAddElem)
                        if (indexAddElem == str.count) {
                           str.append(String(elem))
                        }
                        else{
                        str.insert(String(elem), at: (indexAddElem-1))
                        indexAddElem = indexAddElem + 1
                        }
                    }
                    if(")".contains(String(elem))){
                        //print(")",indexAddElem)
                        if (indexAddElem == str.count) {
                            str.append(String(elem))
                        }
                        else{
                            str.insert(String(elem), at: indexAddElem)
                            indexAddElem = indexAddElem + 1
                        }
                    }
                }
                //print("что то похожее",str)
                firstArgument = calcRPN.calculation(input: str)
                print("firstArgument",firstArgument)

            }
            
            firstArgument = String(Double(firstArgument)! * Double("0.01")!)
            delegate?.showResult(firstArgument)
        }
        if ("s".contains(value)){
            if(firstArgument.contains("+")){
            firstArgument = String(firstArgument.dropFirst())
            firstArgument = "-" + firstArgument
            value = ""
            }
            else if(firstArgument.contains("-")){
            firstArgument = String(firstArgument.dropFirst())
            firstArgument="+" + firstArgument
            value = ""
            }
            else {
                firstArgument="-" + firstArgument
                value = ""
            }
            delegate?.showResult(firstArgument)
        }
        
          if ("0123456789.*/+-()".contains(value)){
            
            
            if ("0123456789".contains(lastValue)) && (("(" == value)) || (("(" == lastValue) && ("+-/*".contains(value)))
            {
                flag = false
                print("AAAAA")
            }
            else if(("*/+-".contains(value)) && ("*/+-".contains(lastValue)))
            {
                print("FA = ",firstArgument)
                let index = firstArgument.index(firstArgument.startIndex, offsetBy: firstArgument.count-1)

                print("FA-1 = ",String(firstArgument[..<index]))
                firstArgument = firstArgument[..<index] + value
                flag = true
            }
            else
            {
                print("nen")
                firstArgument = firstArgument + value
                flag = true
                
            }
            
            if (flag)
            {
            lastValue = value
            }
                    value = ""
                    delegate?.showResult(firstArgument)
        }
        if ("<".contains(value)) {
            firstArgument = String(firstArgument.dropLast())
            value = ""
            delegate?.showResult(firstArgument)
        }
        if ("=".contains(value)){
            let fullName = firstArgument.split{($0 == "-") || ($0 == "+") || ($0 == "*")}
            let fullName2 = fullName.joined(separator: "/").split{($0 == "/") || ($0 == "^")}
            let fullName3 = fullName2.joined(separator: "(").split{($0 == "(") || ($0 == ")")}
                        
            var str:[String] = []
            
            for e in fullName3{
                str.append(String(e))
            }
            //print("Массив чисел",str)
            var indexAddElem = 1
            for elem in firstArgument{
                //print("elem",elem)
                if("*/+-^".contains(String(elem))){
                    //print("*/+-^",indexAddElem)
                    if(indexAddElem == str.count)
                    {
                        str.append(String(elem))
                    }
                    else
                    {
                    str.insert(String(elem), at: indexAddElem)
                    indexAddElem = indexAddElem + 2
                    }
                }
                if("(".contains(String(elem))){
                    //print("(",indexAddElem)
                    if (indexAddElem == str.count) {
                       str.append(String(elem))
                    }
                    else{
                    str.insert(String(elem), at: (indexAddElem-1))
                    indexAddElem = indexAddElem + 1
                    }
                }
                if(")".contains(String(elem))){
                    //print(")",indexAddElem)
                    if (indexAddElem == str.count) {
                        str.append(String(elem))
                    }
                    else{
                        str.insert(String(elem), at: indexAddElem)
                        indexAddElem = indexAddElem + 1
                    }
                }
            }
            //print("что то похожее",str)
            firstArgument = calcRPN.calculation(input: str)
            delegate?.showResult(firstArgument)
            
            
        }
    }
    
}
