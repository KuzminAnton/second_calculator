//
//  ViewController.swift
//  CalculatorTextView
//
//  Created by Антон on 01.05.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let calc = Calculation()
    var previuosSender: SpecialButton! = nil
    
    @IBOutlet weak var result: UITextView!
    
 
    
    @IBAction func buttonClick(_ sender: SpecialButton!) {
        print("result",String(result.text))
        
        
        
    if ( String(result.text) == "error")
    
      {
        
               
        print("nenennenenenenenene")
        result.text = ""
      }
      if (sender.buttonValue == ".") {
          previuosSender = sender
          sender.isEnabled = false
        
          calc.calculateData(button: sender.value(forKey: "buttonValue") as! String)
      }
      else if (previuosSender != nil) && ("0123456789.*/+-()".contains(sender.buttonValue))
      {
          previuosSender.isEnabled = true
          calc.calculateData(button: sender.value(forKey: "buttonValue") as! String)
          
      }
      else{
          calc.calculateData(button: sender.value(forKey: "buttonValue") as! String)
      }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        calc.delegate = self

        // Do any additional setup after loading the view.
    }

}
extension ViewController: ColculationDelegate{
    func showResult(_ res: String){
        
        result.text = res
    }
}



