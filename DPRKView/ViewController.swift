//
//  ViewController.swift
//  DPRKView
//
//  Created by Shalom Friss on 3/21/17.
//  Copyright © 2017 Shalom Friss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dp = DPRKView()
        dp.frame = self.view.frame
        self.view.addSubview(dp)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

