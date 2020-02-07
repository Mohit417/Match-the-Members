//
//  StatisticsViewController.swift
//  Match_The_Members
//
//  Created by Nicholas Wang on 2/5/20.
//  Copyright © 2020 Nicholas Wang. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var longestLabel: UILabel!
    @IBOutlet weak var q1label: UILabel!
    @IBOutlet weak var a1label: UILabel!
    @IBOutlet weak var q2label: UILabel!
    @IBOutlet weak var a2label: UILabel!
    @IBOutlet weak var q3label: UILabel!
    @IBOutlet weak var a3label: UILabel!
    
    
    var longestStreak = 0
    var lastThreeNames: [String] = ["N/A", "N/A", "N/A"]
    var lastThreeStatus: [Bool] = [false, false, false]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        longestLabel.text = String(longestStreak)
        
        q1label.text = lastThreeNames[0]
        q2label.text = lastThreeNames[1]
        q3label.text = lastThreeNames[2]
        
        let t1 = lastThreeStatus[0] ? "Correct" : "Wrong"
        
        let t2 = lastThreeStatus[1] ? "Correct" : "Wrong"
        
        let t3 = lastThreeStatus[2] ? "Correct" : "Wrong"
        
        a1label.text = t1
        a2label.text = t2
        a3label.text = t3
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
