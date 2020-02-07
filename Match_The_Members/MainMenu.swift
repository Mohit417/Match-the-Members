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
        
        startBtn.backgroundColor = UIColor(red:0.72, green:0.95, blue:0.95, alpha:1.0)
        startBtn.layer.borderColor = UIColor.black.cgColor
        startBtn.layer.borderWidth = 2
    }


}

