//
//  ViewController.swift
//  Match_The_Members
//
//  Created by Nicholas Wang on 2/5/20.
//  Copyright © 2020 Nicholas Wang. All rights reserved.
//

import UIKit

class MainMenu: UIViewController {
    
    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBtn.backgroundColor = UIColor(red:1, green:232/255, blue:105/255, alpha:1.0)
        startBtn.layer.cornerRadius = 10
    }


}

