//
//  CalculationRPN.swift
//  CalculatorTextView
//
//  Created by Антон on 02.05.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import Foundation




class CalculationRPN {
func calculation(input: [String]) ->  String{
   return (calculationRPN(rpns: converstionToRPN(str: input)))[0]
}

func converstionToRPN(str: [String]) ->  [String]{
    var input = str
    let priority: [String: Int] = ["^": 4, "*": 3, "/": 3,"+": 2,"-": 2]
    var stack: [String] = []
    var out: [String] = []
    
    input.append("&")
    for elem in input{
        if(Double(elem) != nil)
        {
            out.append(elem)
        }
        else
        {
            if (stack.count == 0)
            {
                
                stack.append(elem)
            }
            else
            {
                if(elem == "(")
                {
                    stack.append(elem)
                }
                else
                    if (elem == ")" )
                    {
                      
                             out.append(stack[stack.count-1])
                        if((stack.count-1) >= 0){
                             stack.remove(at: stack.count-1)
                        }
                        else{
                            print("Ошибка ввода мать его")
                            return [""]
                            
                        }
                        if((stack.count-1) >= 0){
                             stack.remove(at: stack.count-1)
                        }
                        else{
                            print("Ошибка ввода мать его")
                            return [""]

                        }
                        
                    }
                    else
                        if(elem == "&")
                        {
                            var i = 1
                            for _ in stack
                            {
                                out.append(stack[stack.count-i])
                                i+=1
                            }
                        }
                        else
                        {
                            let curremt_prior: Int = priority[elem] ?? 0
                            let previous_prior: Int = priority[stack[stack.count-1]] ?? 0
                            if (curremt_prior > previous_prior)
                            {
                                stack.append(elem)
                            }
                            else
                            {
                                if (previous_prior == 4)&&(curremt_prior == 3){
                                    out.append(stack[stack.count-1])
                                    stack.remove(at: stack.count-1)
                                }
                                else {while (stack.count != 0 ){
                                    out.append(stack[stack.count-1])
                                    stack.remove(at: stack.count-1)
                                    }
                                }
                                stack.append(elem)
                            }
                }
            }
        }
    }
    return out
}
//подсчит выражения из обратной полтской записи

func calculationRPN(rpns: [String]) ->  [String]{
    if(rpns.count > 2)
    {
        var rpn = rpns
        var new_rpn:[String] = []
        for (index,elem) in rpn.enumerated(){
            if(Double(elem) == nil)
            {
                var index_new = index
                if(index_new == 2){
                    while (index_new < rpn.count-1) {
                        new_rpn.append(rpn[index_new+1])
                        index_new = index_new+1
                    }
                }
                else{
                    let temroiry_rpn = rpn
                    print("index_new-2",index_new-2,"index_new+1",index_new+1)
                    if((index_new-2) >= 0)
                    {
                    rpn.removeSubrange((index_new-2)..<index_new+1)
                    new_rpn = rpn
                    rpn = temroiry_rpn
                    }
                    else
                    {
                        print("ошибка ввода данных")
                        return [""]

                    }
                    
                }
                if (rpn[index] == "+") {
                    let first_elem: Double = Double(rpn[index-2]) ?? 0
                    let second_elem: Double = Double(rpn[index-1]) ?? 0
                    let new_elem = first_elem + second_elem
                    if(index == 2){
                        new_rpn.insert(String(new_elem), at: 0)
                    } else {new_rpn.insert(String(new_elem), at:(index-2))}
                }
                if (rpn[index] == "-") {
                    let first_elem: Double = Double(rpn[index-2]) ?? 0
                    let second_elem: Double = Double(rpn[index-1]) ?? 0
                    let new_elem = first_elem - second_elem
                    if(index == 2){
                        new_rpn.insert(String(new_elem), at: 0)
                    } else {new_rpn.insert(String(new_elem), at:(index-2))}
                    
                }
                if (rpn[index] == "*") {
                    let first_elem: Double = Double(rpn[index-2]) ?? 0
                    let second_elem: Double = Double(rpn[index-1]) ?? 0
                    let new_elem = first_elem * second_elem
                    if(index == 2){
                        new_rpn.insert(String(new_elem), at: 0)
                    } else {new_rpn.insert(String(new_elem), at:(index-2))}
                    
                }
                if (rpn[index] == "/") {
                    let first_elem: Double = Double(rpn[index-2]) ?? 0
                    let second_elem: Double = Double(rpn[index-1]) ?? 0
                    let new_elem = first_elem / second_elem
                    if(index == 2){
                        new_rpn.insert(String(new_elem), at: 0)
                    } else {new_rpn.insert(String(new_elem), at:(index-2))}
                    
                }
                if (rpn[index] == "^") {
                    let first_elem: Double = Double(rpn[index-2]) ?? 0
                    let second_elem: Double = Double(rpn[index-1]) ?? 0
                    let new_elem = pow(first_elem, second_elem)
                    let n_elem = Double(truncating: NSDecimalNumber(decimal: Decimal(new_elem)))
                    if(index == 2){
                        new_rpn.insert(String(n_elem), at: 0)
                    } else {new_rpn.insert(String(n_elem), at:(index-2))}
                }
                break
            }
        }
        if ("*/+-^".contains(new_rpn[0]))
        {
          
            print("ошибка ввода данных")

            return [""]
            
            
        }
            else {return calculationRPN(rpns: new_rpn)}
    }
    else {return rpns}
}
}
