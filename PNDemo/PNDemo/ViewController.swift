//
//  ViewController.swift
//  PNDemo
//
//  Created by Shivi on 2/11/17.
//  Copyright © 2017 NaviSpin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showAlertPopup(title: String, body: String) {
        
        let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }

}

