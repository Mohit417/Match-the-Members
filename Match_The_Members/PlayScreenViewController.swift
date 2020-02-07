//
//  PlayScreenViewController.swift
//  Match_The_Members
//
//  Created by Nicholas Wang on 2/5/20.
//  Copyright © 2020 Nicholas Wang. All rights reserved.
//

import UIKit
import Foundation

class PlayScreenViewController: UIViewController {

    @IBOutlet weak var MemberImage: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var statsBtn: UIButton!
    
    var rightButton: Int!
    var score = 0
    var gameTimer = Timer()
    var timeLeft: Int!
    var pause = true
    var current_name = ""
    var right_or_wrong: Bool!
    var lastThreeNames: [String] = ["N/A", "N/A", "N/A"]
    var lastThreeStatus: [Bool] = [false, false, false]
    var longest_streak = 0
    var current_streak = 0
    var statisticsPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets score label to 0 first
        scoreLabel.text = "Score: " + String(score)
        
        loadImageAndNameAndNumAndStuff()
        
        button1.layer.borderWidth = 2
        button2.layer.borderWidth = 2
        button3.layer.borderWidth = 2
        button4.layer.borderWidth = 2
        
        button1.layer.borderColor = UIColor.black.cgColor
        button2.layer.borderColor = UIColor.black.cgColor
        button3.layer.borderColor = UIColor.black.cgColor
        button4.layer.borderColor = UIColor.black.cgColor
        statsBtn.layer.borderWidth = 2
        statsBtn.layer.borderColor = UIColor.black.cgColor
        
        button1.backgroundColor = UIColor(red:0.72, green:0.95, blue:0.95, alpha:1.0)
        button2.backgroundColor = UIColor(red:0.72, green:0.95, blue:0.95, alpha:1.0)
        button3.backgroundColor = UIColor(red:0.72, green:0.95, blue:0.95, alpha:1.0)
        button4.backgroundColor = UIColor(red:0.72, green:0.95, blue:0.95, alpha:1.0)
        statsBtn.backgroundColor = UIColor(red:0.72, green:0.95, blue:0.95, alpha:1.0)
        
    }
    
    @IBAction func buttonOne(_ sender: Any) {
        // if answer is right
        if rightButton == 1 {
            right_or_wrong = true
            updateScore()
            button1.backgroundColor = UIColor.green
            checkStreak()
        } // if answer is wrong
        else {
            current_streak = 0
            button1.backgroundColor = UIColor.red
            getRightColor()
            right_or_wrong = false
        }
        // Either way load next question after 1 sec
        waitASec()
    }
    @IBAction func buttonTwo(_ sender: Any) {
        if rightButton == 2 {
            right_or_wrong = true
            updateScore()
            button2.backgroundColor = UIColor.green
            checkStreak()
        } else {
            current_streak = 0
            button2.backgroundColor = UIColor.red
            getRightColor()
            right_or_wrong = false
        }
        waitASec()
    }
    @IBAction func buttonThree(_ sender: Any) {
        if rightButton == 3 {
            right_or_wrong = true
            updateScore()
            button3.backgroundColor = UIColor.green
            checkStreak()
        } else {
            current_streak = 0
            button3.backgroundColor = UIColor.red
            getRightColor()
            right_or_wrong = false
        }
        waitASec()
    }
    @IBAction func buttonFour(_ sender: Any) {
        if rightButton == 4 {
            right_or_wrong = true
            updateScore()
            button4.backgroundColor = UIColor.green
            checkStreak()
        } else {
            current_streak = 0
            button4.backgroundColor = UIColor.red
            getRightColor()
            right_or_wrong = false
        }
        waitASec()
    }
    
    func checkStreak() {
        current_streak += 1
        if current_streak > longest_streak {
            longest_streak = current_streak
        }
    }
    
    @IBAction func pauseClick(_ sender: Any) {
        if pause {
            statisticsPage = false
        }
        pauseGame()
    }
    
    func pauseGame() {
        if pause {
            pauseButton.setTitle("Resume", for: .normal)
            gameTimer.invalidate()
            invalidateButtons()
        } else {
            validateButtons()
            pauseButton.setTitle("Pause", for: .normal)
            if !statisticsPage {
                score = 0
            }
            scoreLabel.text = "Score: " + String(score)
            startTimer()
        }
        pause = !pause
    }
    
    func invalidateButtons() {
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
    }
    
    func validateButtons() {
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
    }
    
    func revertColors() {
        button1.backgroundColor = UIColor(red:0.72, green:0.95, blue:0.95, alpha:1.0)
        button2.backgroundColor = UIColor(red:0.72, green:0.95, blue:0.95, alpha:1.0)
        button3.backgroundColor = UIColor(red:0.72, green:0.95, blue:0.95, alpha:1.0)
        button4.backgroundColor = UIColor(red:0.72, green:0.95, blue:0.95, alpha:1.0)
    }
    
    func getRightColor() {
        if rightButton==1 {
            button1.backgroundColor = UIColor.green
        } else if rightButton==2 {
            button2.backgroundColor = UIColor.green
        } else if rightButton==3 {
            button3.backgroundColor = UIColor.green
        } else {
            button4.backgroundColor = UIColor.green
        }
    }
    
    func waitASec() {
        invalidateButtons()
        updateThreeArrays()
        let _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(PlayScreenViewController.loadImageAndNameAndNumAndStuff)), userInfo: nil, repeats: false)
    }
    
    func updateThreeArrays() {
        lastThreeNames[2] = lastThreeNames[1]
        lastThreeNames[1] = lastThreeNames[0]
        lastThreeNames[0] = current_name
        
        lastThreeStatus[2] = lastThreeStatus[1]
        lastThreeStatus[1] = lastThreeStatus[0]
        lastThreeStatus[0] = right_or_wrong
        
    }
    
    func updateScore() {
        score += 1
        scoreLabel.text = "Score: " + String(score)
    }
    
    func startTimer() {
        validateButtons()
        gameTimer.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(PlayScreenViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if timeLeft >= 0 {
            timerLabel.text = "Time Left: " + String(timeLeft)
            timeLeft -= 1
        } else {
            outOfTime()
        }
    }
    
    func outOfTime() {
        current_streak = 0
        right_or_wrong = false
        gameTimer.invalidate()
        getRightColor()
        waitASec()
    }
    
    @IBAction func statClick(_ sender: Any) {
        pauseGame()
        statisticsPage = true
        self.performSegue(withIdentifier: "statSegue", sender: self)
    }
    
    // Function that loads images and names and numbers and stuff
    @objc func loadImageAndNameAndNumAndStuff() {
        // first and foremost revert colors from previous choices
        revertColors()
        
        // Load right member image / name / number
        let right_member_num = Int.random(in: 0 ..< Constants.names.count)
        let right_member_name = Constants.names[right_member_num]
        let right_member_img = Constants.getImageFor(name: right_member_name)
               
        // Load wrong member images / names/ numbers
        var wrong_names: [String] = []
        var used_nums: [Int] = [right_member_num]
        
        for _ in 0..<3 {
            var curr_random_num = Int.random(in: 0 ..< Constants.names.count)
            while used_nums.contains(curr_random_num) {
                curr_random_num = Int.random(in: 0 ..< Constants.names.count)
            }
            used_nums.append(curr_random_num)
            let wrong_str = Constants.names[curr_random_num]
            wrong_names.append(wrong_str)
        }
        
        current_name = right_member_name
               
        // Sets random member image to image view
        MemberImage.image = right_member_img
               
        // Get random right button
        rightButton = Int.random(in: 1 ... 4)
               
        if rightButton==1 {
            button1.setTitle(right_member_name, for: .normal)
            button2.setTitle(wrong_names[0], for: .normal)
            button3.setTitle(wrong_names[1], for: .normal)
            button4.setTitle(wrong_names[2], for: .normal)
        } else if rightButton==2 {
            button1.setTitle(wrong_names[0], for: .normal)
            button2.setTitle(right_member_name, for: .normal)
            button3.setTitle(wrong_names[1], for: .normal)
            button4.setTitle(wrong_names[2], for: .normal)
        } else if rightButton==3 {
            button1.setTitle(wrong_names[0], for: .normal)
            button2.setTitle(wrong_names[1], for: .normal)
            button3.setTitle(right_member_name, for: .normal)
            button4.setTitle(wrong_names[2], for: .normal)
        } else {
            button1.setTitle(wrong_names[0], for: .normal)
            button2.setTitle(wrong_names[1], for: .normal)
            button3.setTitle(wrong_names[2], for: .normal)
            button4.setTitle(right_member_name, for: .normal)
        }
        
        // Load the timer in for the Timer Label
        timeLeft = 5
        startTimer()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? StatisticsViewController {
            destinationVC.lastThreeNames = lastThreeNames
            destinationVC.lastThreeStatus = lastThreeStatus
            destinationVC.longestStreak = longest_streak
        }
    }

}
