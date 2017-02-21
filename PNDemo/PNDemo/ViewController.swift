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
        self.title = "Hello5"
        self.navigationController?.title = "Hello"
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBOutlet var showMessages: UIView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleClick(_ sender: Any) {
        self.performSegue(withIdentifier: "segueId", sender: self)
    }
    
    func showAlertPopup(title: String, body: String) {
        
        let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }

}

