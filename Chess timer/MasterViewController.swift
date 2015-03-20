//
//  MasterViewController.swift
//  Chess timer
//
//  Created by Poyi Chen on 3/11/15.
//  Copyright (c) 2015 Poyi. All rights reserved.
//

import UIKit
import QuartzCore

class MasterViewController: UIViewController {
    
    @IBOutlet var WhiteSecondLabel : UILabel!
    @IBOutlet var WhiteMinuteLabel : UILabel!
    @IBOutlet var miniWhiteSecondLabel : UILabel!
    @IBOutlet var miniWhiteMinuteLabel : UILabel!
    @IBOutlet var WhiteSecondLabelBlack : UILabel!
    @IBOutlet var WhiteMinuteLabelBlack : UILabel!
    @IBOutlet var miniBlackSecondLabel : UILabel!
    @IBOutlet var miniBlackMinuteLabel : UILabel!
    @IBOutlet var BlackSecondLabel : UILabel!
    @IBOutlet var BlackMinuteLabel : UILabel!
    @IBOutlet var BlackMinuteLabelWhite : UILabel!
    @IBOutlet var BlackSecondLabelWhite : UILabel!
    @IBOutlet var BlackTimeLabelTitle : UILabel!
    @IBOutlet var StartButton : UIButton!
    @IBOutlet var WhiteEndTurnButton : UIButton!
    @IBOutlet var BlackEndTurnButton : UIButton!
    @IBOutlet var BackgroundView: UIView!
    @IBOutlet var BlackLabelColon : UILabel!
    @IBOutlet var WhiteLabelColon : UILabel!
    @IBOutlet var miniBlackLabelColon : UILabel!
    @IBOutlet var miniWhiteLabelColon : UILabel!
    @IBOutlet var whitePauseBtn : UIView!
    @IBOutlet var BlackPauseBtn : UIView!
    var timer:NSTimer?
    var second:Int = 0
    var minute:Int = 0
    var BlackSecond:Int = 0
    var BlackMinute:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetTime()
        positionTimer()
        WhiteEndTurnButton.hidden = true
        BlackEndTurnButton.hidden = true
        setUpBackground()
    }
    
    var backgroundView: CALayer {
        return BackgroundView.layer
    }
    
    // Helper for using hex value with UIColor
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func positionTimer(){
        WhiteMinuteLabelBlack.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        WhiteSecondLabelBlack.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        BlackMinuteLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        BlackSecondLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        miniBlackMinuteLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        miniBlackSecondLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        BlackTimeLabelTitle.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
    }
    
    func setUpBackground() {
        backgroundView.frame = CGRect(x: 0, y: 0, width: 320, height: 65)
        backgroundView.backgroundColor = UIColorFromRGB(0x2d2d2d).CGColor
        self.miniWhiteMinuteLabel.alpha = 0
        self.miniWhiteSecondLabel.alpha = 0
        self.miniWhiteLabelColon.alpha = 0
        self.BlackSecondLabel.alpha = 0
        self.BlackMinuteLabel.alpha = 0
        self.BlackLabelColon.alpha = 0
        self.BlackPauseBtn.alpha = 0
    }
    
    func BlackTurnEnd() {
        UIView.animateWithDuration(0.5, animations: {
            self.backgroundView.frame = CGRect(x: 0, y: 0, width: 320, height: 60)
            self.miniBlackMinuteLabel.alpha = 1
            self.miniBlackSecondLabel.alpha = 1
            self.miniBlackLabelColon.alpha = 1
            self.BlackSecondLabel.alpha = 0
            self.BlackMinuteLabel.alpha = 0
            self.BlackLabelColon.alpha = 0
            self.WhiteSecondLabel.alpha = 1
            self.WhiteMinuteLabel.alpha = 1
            self.WhiteLabelColon.alpha = 1
            self.miniWhiteMinuteLabel.alpha = 0
            self.miniWhiteSecondLabel.alpha = 0
            self.miniWhiteLabelColon.alpha = 0
            self.whitePauseBtn.alpha = 1
            self.BlackPauseBtn.alpha = 0
        })
    }
    
    func WhiteTurnEnd() {
        UIView.animateWithDuration(0.5, animations: {
            self.backgroundView.frame = CGRect(x: 0, y: 0, width: 320, height: 503)
            self.miniWhiteMinuteLabel.alpha = 1
            self.miniWhiteSecondLabel.alpha = 1
            self.miniWhiteLabelColon.alpha = 1
            self.BlackSecondLabel.alpha = 1
            self.BlackMinuteLabel.alpha = 1
            self.BlackLabelColon.alpha = 1
            self.WhiteSecondLabel.alpha = 0
            self.WhiteMinuteLabel.alpha = 0
            self.WhiteLabelColon.alpha = 0
            self.miniBlackMinuteLabel.alpha = 0
            self.miniBlackSecondLabel.alpha = 0
            self.miniBlackLabelColon.alpha = 0
            self.whitePauseBtn.alpha = 0
            self.BlackPauseBtn.alpha = 1
        })
    }
    
    @IBAction func startbuttonTapped(sender : AnyObject) {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("WhiteCountdown:"), userInfo: nil, repeats: true)
        StartButton.hidden = true
        WhiteEndTurnButton.hidden = false
    }
    
    @IBAction func WhiteEndTurn(sender : AnyObject) {
        self.timer?.invalidate()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("BlackCountdown:"), userInfo: nil, repeats: true)
        WhiteEndTurnButton.hidden = true
        BlackEndTurnButton.hidden = false
        WhiteTurnEnd()
    }
    
    @IBAction func BlackEndTurn(sender : AnyObject) {
        self.timer?.invalidate()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("WhiteCountdown:"), userInfo: nil, repeats: true)
        BlackEndTurnButton.hidden = true
        WhiteEndTurnButton.hidden = false
        BlackTurnEnd()
    }

    func WhiteCountdown(timer : NSTimer){
        switch second {
            case 0:
                minute--
                WhiteMinuteLabel.text = String(minute)
                WhiteMinuteLabelBlack.text = String(minute)
                second = 59
                WhiteSecondLabel.text = "59"
                WhiteSecondLabelBlack.text = "59"
                miniWhiteSecondLabel.text = "59"
            case 1...10:
                second--
                WhiteSecondLabel.text = "0" + String(second)
                WhiteSecondLabelBlack.text = "0" + String(second)
                miniWhiteSecondLabel.text = "0" + String(second)
             println(second)
            default:
                second--
                WhiteMinuteLabel.text = String(minute)
                WhiteMinuteLabelBlack.text = String(minute)
                miniWhiteMinuteLabel.text = String(minute)
                WhiteSecondLabel.text = String(second)
                WhiteSecondLabelBlack.text = String(second)
                miniWhiteSecondLabel.text = String(second)
            println(second)
            
        }
        if minute == 0 && second == 0 {
           self.timer?.invalidate()
            println("White Countdown hits 0")
            // add some kind of end game trigger here
        }
        
    }
    
    func BlackCountdown(timer : NSTimer){
        switch BlackSecond {
        case 0:
            BlackMinute--
            BlackMinuteLabel.text = String(BlackMinute)
            BlackMinuteLabelWhite.text = String(BlackMinute)
            BlackSecond = 59
            BlackSecondLabel.text = "59"
            BlackSecondLabelWhite.text = "59"
            miniBlackSecondLabel.text = "59"
        case 1...10:
            BlackSecond--
            BlackSecondLabel.text = "0" + String(BlackSecond)
            BlackSecondLabelWhite.text = "0" + String(BlackSecond)
            miniBlackSecondLabel.text = "0" + String(BlackSecond)
        default:
            BlackSecond--
            BlackMinuteLabel.text = String(BlackMinute)
            BlackMinuteLabelWhite.text = String(BlackMinute)
            miniBlackMinuteLabel.text = String(BlackMinute)
            BlackSecondLabel.text = String(BlackSecond)
            BlackSecondLabelWhite.text = String(BlackSecond)
            miniBlackSecondLabel.text = String(BlackSecond)
            
        }
        if BlackMinute == 0 && BlackSecond == 0 {
            self.timer?.invalidate()
            println("Black Countdown hits 0")
            // add some kind of end game trigger here
        }
        
    }
    
    func resetTime(){
        minute = 10
        second = 0
        BlackMinute = 10
        BlackSecond = 0
        if second == 0 {
            WhiteSecondLabel.text = "00"
            WhiteSecondLabelBlack.text = "00"
            miniWhiteSecondLabel.text = "00"
            BlackSecondLabel.text = "00"
            BlackSecondLabelWhite.text = "00"
            miniBlackSecondLabel.text = "00"
        } else {
            WhiteSecondLabel.text = String(second)
            WhiteSecondLabelBlack.text = String(second)
            miniWhiteSecondLabel.text = String(second)
            BlackSecondLabel.text = String(second)
            BlackSecondLabelWhite.text = String(second)
            miniBlackSecondLabel.text = String(second)
        }
        WhiteMinuteLabel.text = String(minute)
        WhiteMinuteLabelBlack.text = String(minute)
        miniWhiteMinuteLabel.text = String(minute)
        BlackMinuteLabel.text = String(minute)
        BlackMinuteLabelWhite.text = String(minute)
        miniBlackMinuteLabel.text = String(minute)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Hide the status bar
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    @IBAction func showActionSheet(sender: AnyObject) {
        self.timer?.invalidate()
        let optionMenu = UIAlertController(title: nil, message: "Game Paused", preferredStyle: .ActionSheet)
        
        let reset10 = UIAlertAction(title: "New 10 Minute Game", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.StartButton.hidden = false
            
            self.BlackTurnEnd()
            self.minute = 10
            self.second = 0
            self.BlackMinute = 10
            self.BlackSecond = 0
            if self.second == 0 {
                self.WhiteSecondLabel.text = "00"
                self.WhiteSecondLabelBlack.text = "00"
                self.miniWhiteSecondLabel.text = "00"
                self.BlackSecondLabel.text = "00"
                self.BlackSecondLabelWhite.text = "00"
                self.miniBlackSecondLabel.text = "00"
            } else {
                self.WhiteSecondLabel.text = String(self.second)
                self.WhiteSecondLabelBlack.text = String(self.second)
                self.miniWhiteSecondLabel.self.text = String(self.second)
                self.BlackSecondLabel.text = String(self.second)
                self.BlackSecondLabelWhite.text = String(self.second)
                self.miniBlackSecondLabel.text = String(self.second)
            }
            self.WhiteMinuteLabel.text = String(self.minute)
            self.WhiteMinuteLabelBlack.text = String(self.minute)
            self.miniWhiteMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabelWhite.text = String(self.minute)
            self.miniBlackMinuteLabel.text = String(self.minute)
            
            println("10 min game restarted")
        })
        let reset5 = UIAlertAction(title: "New 5 Minute Game", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
  
            self.StartButton.hidden = false
            
            self.BlackTurnEnd()
            self.minute = 5
            self.second = 0
            self.BlackMinute = 5
            self.BlackSecond = 0
            if self.second == 0 {
                self.WhiteSecondLabel.text = "00"
                self.WhiteSecondLabelBlack.text = "00"
                self.miniWhiteSecondLabel.text = "00"
                self.BlackSecondLabel.text = "00"
                self.BlackSecondLabelWhite.text = "00"
                self.miniBlackSecondLabel.text = "00"
            } else {
                self.WhiteSecondLabel.text = String(self.second)
                self.WhiteSecondLabelBlack.text = String(self.second)
                self.miniWhiteSecondLabel.self.text = String(self.second)
                self.BlackSecondLabel.text = String(self.second)
                self.BlackSecondLabelWhite.text = String(self.second)
                self.miniBlackSecondLabel.text = String(self.second)
            }
            self.WhiteMinuteLabel.text = String(self.minute)
            self.WhiteMinuteLabelBlack.text = String(self.minute)
            self.miniWhiteMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabelWhite.text = String(self.minute)
            self.miniBlackMinuteLabel.text = String(self.minute)

            println("5 min game restarted")
        })
        
        let cancelAction = UIAlertAction(title: "Resume", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Game Resumed")
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("WhiteCountdown:"), userInfo: nil, repeats: true)

        })
        
        optionMenu.addAction(reset10)
        optionMenu.addAction(reset5)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }


}

