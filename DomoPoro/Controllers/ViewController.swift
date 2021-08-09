//
//  ViewController.swift
//  DomoPoro
//
//  Created by Cristian Costa on 03/08/2021.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var startBtnLabel: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var timeManager = TimeManager()
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
        timePicker.dataSource = self
        timePicker.delegate = self
//        restPicker.dataSource = self
//        restPicker.delegate = self
        timePicker.selectRow(2, inComponent: 0, animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeManager.timeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeManager.timeArray[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timeManager.totalTime.seconds = timeManager.timeArray[row].seconds
        timeManager.totalTime.name = timeManager.timeArray[row].name
        timeManager.countdownTime = timeManager.timeArray[row].seconds
        timeLabel.text = timeManager.timeArray[row].name
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        timer.invalidate()
        startCountdown()
        if startBtnLabel.titleLabel?.text == "Start !" {
            timePicker.isUserInteractionEnabled = false
            startBtnLabel.setTitle("Stop !", for: .normal)
        } else {
            timer.invalidate()
            progressBar.progress = 0.0
            timePicker.isUserInteractionEnabled = true
            startBtnLabel.setTitle("Start !", for: .normal)
            timeLabel.text = timeManager.totalTime.name
            timeManager.countdownTime = timeManager.totalTime.seconds
        }
    }
    
    func startCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        print("Total time \(timeManager.countdownTime)")
        //example functionality
        if 0 < timeManager.countdownTime {
            let (m,s) = secondsToHoursMinutesSeconds(seconds: timeManager.countdownTime)
            timeLabel.text = "\(m):\(s)"
            timeManager.countdownTime -= 1
            progressBar.progress = Float(timeManager.countdownTime - timeManager.totalTime.seconds) / Float(timeManager.totalTime.seconds) * -1
            print(progressBar.progress)
        } else {
            progressBar.progress = 0.0
            timeLabel.text = "Done !"
            timer.invalidate()
            startBtnLabel.setTitle("Start !", for: .normal)
            timePicker.isUserInteractionEnabled = true
            timeManager.countdownTime = timeManager.totalTime.seconds
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int) {
      return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
