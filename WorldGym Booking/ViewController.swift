//
//  ViewController.swift
//  WorldGym Booking
//
//  Created by 陳永展 on 2019/5/16.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
  
    
    let trainingArr = ["胸","肩","腿","背"]
    let DayArr = ["日","一","二","三","四","五","六"]
//    let HourArr = ["一小時","兩小時"]
    
  
    @IBOutlet weak var DaySegmentctrl: UISegmentedControl!
    
    @IBOutlet weak var PartSegmentctrl: UISegmentedControl!
    @IBOutlet weak var CoachTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var ClickBtn: UIButton!
    var picker = UIPickerView()     //產生picker
    var BookingArr=[String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ClickBtn.layer.cornerRadius = 30
//        ActitivyIndicator.isHidden = true
        BookingArr = drinkdata() //撈菜單
        initPicker()
    }
    
    @IBAction func go(_ sender: Any) {
        if (NameTextField.text?.count)! > 0 ,
            (CoachTextField.text?.count)! > 0 ,
            PartSegmentctrl.selectedSegmentIndex >= 0
            
        {
            let name = NameTextField.text!
            let coach = CoachTextField.text!
            let training = trainingArr[PartSegmentctrl.selectedSegmentIndex]
            let day = DayArr[DaySegmentctrl.selectedSegmentIndex]
//            let todaysDate:NSDate = NSDate()
//            let dateFormatter:DateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyy-MM-dd HH:mm"
//            let time:String = dateFormatter.string(from: todaysDate as Date)
            let orderDictionary:[String: Any] = ["name": name, "coach": coach, "training": training, "day": day]
            
            let orderData: [String: Any] = ["data": orderDictionary]
            print(orderData)
//            self.ActitivyIndicator.isHidden = false
//            self.ActitivyIndicator.startAnimating()
            
            CWorkout.Workout.upload(data: orderData, finished: {check in
                if check{
                    let Controller = UIAlertController(title: "資料已送出", message: "謝謝您的預約", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "確認", style: .default, handler: { (action) -> Void in
//                        self.ActitivyIndicator.stopAnimating()
//                        self.ActitivyIndicator.isHidden = true
                    })
                    Controller.addAction(okAction)
                    self.present(Controller, animated: true, completion: nil)
                }else{
                    let Controller = UIAlertController(title: "系統異常", message: "請再試一次", preferredStyle:.alert)
                    let okAction = UIAlertAction(title: "確認", style: .default, handler: { (action) -> Void in
//                        self.ActitivyIndicator.stopAnimating()
//                        self.ActitivyIndicator.isHidden=true
                    })
                    Controller.addAction(okAction)
                    self.present(Controller, animated: true, completion: nil)
                }
            })
            //            print(uploadStr)
        }else{
            //提醒alert
            let controller = UIAlertController(title: "預約失敗", message: "有欄位沒有填到，要檢查清楚哦！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }
    }
        
        
        
    
    
    func initPicker(){    //初始化Picker
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        //設定代理人和資料來源為viewController
        picker.delegate = self
        picker.dataSource = self
        let doneButton = UIBarButtonItem(title: "確認", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.doneAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "取消", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.closeKeyboard))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        CoachTextField.inputAccessoryView = toolBar
        //讓textfiled的輸入方式改為PickerView
        CoachTextField.inputView = picker
        //加上手勢按鈕
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
    }
    // 飲料選項按下確定事件
    @objc func doneAction() {
        let row = picker.selectedRow(inComponent: 0)    //picker裡的選項
        CoachTextField.text = BookingArr[row]
        self.view.endEditing(true)
    }
    func drinkdata()->Array<String>{    //解析菜單
        if let asset = NSDataAsset(name: "萵苣"), let content = String(data: asset.data, encoding: .utf8) {
            let array = content.components(separatedBy: "\n")
            print(array[0], array[1])
            return array
        }else{
            let array = [String]()
            return array
        }
    }
    @objc func closeKeyboard(){
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BookingArr.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return BookingArr[row]    //顯示內容
    }
//override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//    if event?.subtype == .motionShake { //是否為搖晃手機的事件
//        let randomNum = Int(arc4random()) % BookingArr.count
//        //let tmpDic = DrinkArr[randomNum]
//        //print("shanking now - \(tmpDic["drinkShowString"]!)")
//        picker.selectRow(randomNum, inComponent: 0, animated: true)
//        //drinkTextField.text = tmpDic["drinkShowString"]!
//    }
//}

}

   




