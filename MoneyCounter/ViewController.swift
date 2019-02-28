//
//  ViewController.swift
//  MoneyCounter
//
//  Created by mac on 1/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
var timer = Timer()

class ViewController: UIViewController {
    
    // Labels
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var moneyCurrency: UILabel!
    
    // Buttons
    @IBOutlet weak var startButton: UIButton!
    
    // Variables
    var time = 0
    var startTime = 0
    var elapsedTime = 0
    var runningStatus = String()
    var saveTimer: Int {
        get {
        if let saved = UserDefaults.standard.object(forKey: "start_time") as! Int? {
            print("NONE \(timer)  \("start_time")");
            return saved
            
        }else {
            return 1
        }
            
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "start_time")
            UserDefaults.standard.synchronize()
        }
    }

    var selectedHourlyMoneyCurrency: Float {
        get {
            if let hourlyMoneyCurrency = UserDefaults.standard.object(forKey: "HourlyMoneyCurrency") as! Float?  {
                return hourlyMoneyCurrency
            } else  { return 1.0 }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "HourlyMoneyCurrency")
            UserDefaults.standard.synchronize()
        }
    }
    
    var selectedMoneyCurrency: String {
        get {
            if let moneyCurrency = UserDefaults.standard.string(forKey: "moneyCurrency") as String? {
                return moneyCurrency
            } else  {return "$"}
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "moneyCurrency")
            UserDefaults.standard.synchronize()
        }
    }
    
    // Function
    @IBAction func start(_ sender: Any) {
        startTimer()
    }
    
    @IBAction func pause(_ sender: Any) {
        startButton.isEnabled = true
        timer.invalidate()
    }
    
    @IBAction func reset(_ sender: Any) {
        stopTimer()
    }
    
    @objc func action() {
        time += 1
        OnTick()
        timerLabel.text = String().formatTime(time)
    }
    
    func OnTick()
    {
        moneyLabel.text = String().formatMoney(selectedHourlyMoneyCurrency, selectedMoneyCurrency, time)
    }
    
    func initMoneySettings() {
        moneyCurrency.text! = moneyCurrency.text! + String(selectedHourlyMoneyCurrency) + " " + selectedMoneyCurrency
    }
    
    func startTimer() {
        startButton.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.action), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        startButton.isEnabled = true
        timer.invalidate()
        time = 0
        timerLabel.text = "00:00:00"
        moneyLabel.text = "0.00\(selectedMoneyCurrency)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OnTick()
        initMoneySettings()
    }
    
   override func viewWillAppear(_ animated: Bool) { // скоро загрузится view
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
   
    override func viewWillDisappear(_ animated: Bool) { // мы не видим появление view
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

}


