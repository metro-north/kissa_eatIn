//
//  SubViewController.swift
//  test
//
//  Created by Kei Kawamura on 2018/09/03.
//  Copyright © 2018年 Kei Kawamura. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class SubViewController: UIViewController{
    //ラベルのコネクション
    @IBOutlet weak var B1AmountLabel: UILabel!
    @IBOutlet weak var S1AmountLabel: UILabel!
    @IBOutlet weak var D1AmountLabel: UILabel!
    @IBOutlet weak var De1AmountLabel: UILabel!
    @IBOutlet weak var B1StepperValue: UIStepper!
    @IBOutlet weak var S1StepperValue: UIStepper!
    @IBOutlet weak var D1StepperValue: UIStepper!
    @IBOutlet weak var De1StepperValue: UIStepper!
    
    @IBOutlet weak var tableNumberLabel: UILabel!
    
    var tableNumber : String?
    // インスタンス変数
    var DBRef1:DatabaseReference!
    var status2 : String?
    var intstatus2 : Int?
    var b1amount : String?
    var s1amount : String?
    var d1amount : String?
    var de1amount : String?
    var hoge : String?

    
    
    //Stepper
    @IBAction func B1Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        B1AmountLabel.text = "\(Amount)"
    }
    @IBAction func S1Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        S1AmountLabel.text = "\(Amount)"
    }
    @IBAction func D1AmountLabel(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        D1AmountLabel.text = "\(Amount)"
    }
    @IBAction func De1Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        De1AmountLabel.text = "\(Amount)"
    }
    
    
    //各ボタン機能
    @IBAction func add(_ sender: Any) {
        let alertController1 = UIAlertController(title: "注文",message: "", preferredStyle: UIAlertControllerStyle.alert)
        let okAction1 = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            
            //オーダーの入力
            self.b1amount = self.B1AmountLabel.text
            self.s1amount = self.S1AmountLabel.text
            self.d1amount = self.D1AmountLabel.text
            self.de1amount = self.De1AmountLabel.text
            self.DBRef1.child("table/order").child(self.tableNumber!).setValue(["b1amount":self.b1amount!,"s1amount":self.s1amount!,"d1amount":self.d1amount!,"de1amount":self.de1amount!, "time":ServerValue.timestamp()])
            
            //オーダーキーの設定
            let key = self.DBRef1.child("table/orderorder").childByAutoId().key;
            self.DBRef1.child("table/orderorder").child(key).setValue(self.tableNumber!)
            self.DBRef1.child("table/orderkey").child(self.tableNumber!).setValue(key)
            
            //新規テーブルの区別
            //let defaultPlace = DBRef.child("table/status").child(tableNumber!)
            //defaultPlace.observe(.value) { (snap: DataSnapshot) in self.status2 = (snap.value! as AnyObject).description
            //self.intstatus2 = Int(self.status2!)
            //if self.intstatus2! == 0{
            self.DBRef1.child("table/status").child(self.tableNumber!).setValue(1)
            //     DBReff.DBRef1.child("data").childByAutoId().setValue(["b1t":self.b1amount,"s1t":self.s1amount,"d1t":self.d1amount,"de1t":self.de1amount])
            //    }
            //}
            
        }
        let cancelButton1 = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController1.addAction(okAction1)
        alertController1.addAction(cancelButton1)
        present(alertController1,animated: true,completion: nil)
        
        
    }
    
    @IBAction func complete(_ sender: Any) {
        let alertController2 = UIAlertController(title: "配膳完了",message: "", preferredStyle: UIAlertControllerStyle.alert)
        let okAction2 = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            self.DBRef1.child("table/status").child(self.tableNumber!).setValue(3)
            //オーダーキーのリセット
            var hogekey : String?
            let defaultPlace = self.DBRef1.child("table/orderkey").child(self.tableNumber!)
            defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in
                hogekey = (snapshot.value! as AnyObject).description
                self.DBRef1.child("table/orderorder").child(hogekey!).setValue(nil)
                self.DBRef1.child("table/orderkey").child(self.tableNumber!).setValue(nil)
                print("hoge1")
            })
        }
        let cancelButton2 = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController2.addAction(okAction2)
        alertController2.addAction(cancelButton2)
        
        present(alertController2,animated: true,completion: nil)
        
    }
    
    @IBAction func dlete(_ sender: Any) {
        let alertController3 = UIAlertController(title: "削除",message: "", preferredStyle: UIAlertControllerStyle.alert)
        let okAction3 = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            self.B1AmountLabel.text = "0"
            self.S1AmountLabel.text = "0"
            self.D1AmountLabel.text = "0"
            self.De1AmountLabel.text = "0"
            self.B1StepperValue.value = 0
            self.S1StepperValue.value = 0
            self.D1StepperValue.value = 0
            self.De1StepperValue.value = 0
            self.DBRef1.child("table/order").child(self.tableNumber!).setValue(["b1amount":0,"s1amount":0,"d1amount":0,"de1amount":0,"time":0])
            self.DBRef1.child("table/status").child(self.tableNumber!).setValue(0)
            //オーダーキーのリセット
            var hogekey : String?
            let defaultPlace1 = self.DBRef1.child("table/orderkey").child(self.tableNumber!)
            defaultPlace1.observeSingleEvent(of: .value, with: { (snapshot) in
                hogekey = (snapshot.value! as AnyObject).description
                self.DBRef1.child("table/orderorder").child(hogekey!).setValue(nil)
                self.DBRef1.child("table/orderkey").child(self.tableNumber!).setValue(nil)
                print("hoge2")
            })
        }
        let cancelButton3 = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController3.addAction(okAction3)
        alertController3.addAction(cancelButton3)
        
        present(alertController3,animated: true,completion: nil)
}
    
    @IBAction func load(_ sender: Any) {
        let defaultPlace = DBRef1.child("table/order").child(tableNumber!).child("b1amount")
        defaultPlace.observe(.value) { (snap: DataSnapshot) in self.b1amount = (snap.value! as AnyObject).description
            self.B1AmountLabel.text = self.b1amount!
            self.B1StepperValue.value = Double(Int(self.b1amount!)!)
        }
        let defaultPlace1 = DBRef1.child("table/order").child(tableNumber!).child("s1amount")
        defaultPlace1.observe(.value) { (snap: DataSnapshot) in self.s1amount = (snap.value! as AnyObject).description
            self.S1AmountLabel.text = self.s1amount!
            self.S1StepperValue.value = Double(Int(self.s1amount!)!)
        }
        let defaultPlace2 = DBRef1.child("table/order").child(tableNumber!).child("d1amount")
        defaultPlace2.observe(.value) { (snap: DataSnapshot) in self.d1amount = (snap.value! as AnyObject).description
            self.D1AmountLabel.text = self.d1amount!
            self.D1StepperValue.value = Double(Int(self.d1amount!)!)
        }
        let defaultPlace3 = DBRef1.child("table/order").child(tableNumber!).child("de1amount")
        defaultPlace3.observe(.value) { (snap: DataSnapshot) in self.de1amount = (snap.value! as AnyObject).description
            self.De1AmountLabel.text = self.de1amount!
            self.De1StepperValue.value = Double(Int(self.de1amount!)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef1 = Database.database().reference()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
