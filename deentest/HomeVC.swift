//
//  HomeVC.swift
//  Shadhin-BL-Example
//
//  Created by Joy on 29/11/22.
//

import UIKit
import DeenIslamSDK
import SwiftUI

class HomeVC: UIViewController {
    
    init(){
        super.init(nibName: "HomeVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var sessionTimeButton: UIButton!
    
    @IBOutlet weak var sessionTimeTV: UITextField!
    
    private var dataSource : [String] = ["Home","Islamic Name","Tasbeeh","Daily Dua","Hadith","PrayerTime","Qibla", "Zakat","Al Quran","", "IslamicEvent", "NearestMosque", "EidJamatPlace", "NamazLearning", "MoccaModinaLive", "DuaAndAmol", "IslamicLearningStory", "Ramadan", "khotom Quran", "Hajj and Umrah", "Allah All Names", "Islamic Calender"]
    var token : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onKeyboardDone))
        toolbar.setItems([done], animated: true)
        textField.delegate = self
        textField.inputAccessoryView = toolbar
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sessionTimeButton.isEnabled = true
        
        
        // Check if SDK is initialized
        if NoorSDK.shared.isInitialized {
            // SDK is already initialized
        } else {
            // Need to initialize SDK
            NoorSDK.shared.initialize(with: self.tabBarController, nav: self.navigationController!, delegate: self, token: token ?? "", isBL: true)
        }

        
      
    }
    @objc func onKeyboardDone(){
        textField.resignFirstResponder()
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            UIView.animate(withDuration: 0.2) {
                self.bottomConstraint.constant = keyboardHeight
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.2) {
            
            self.bottomConstraint.constant = 16
        }
    }

   
    @IBAction func onButtonPressed(_ sender: Any) {
        //guard let code = textField.text else {return}
        //ShadhinBL.shared.openPatch(patchID: code, navigationController: self.navigationController!, tabController: self.tabBarController)
    }
    
    @IBAction func onSessionTimeSetPressed(_ sender: Any) {
//        guard let tt = sessionTimeTV.text, let time = Double(tt) else {return}
//        ShadhinBL.shared.setSessionPulesTimer(second: time)
//        sessionTimeButton.isEnabled = false
        
    }
}

extension HomeVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = dataSource[indexPath.row]
            cell.contentConfiguration = content
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = dataSource[indexPath.row]
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let type =  FeatureType(rawValue: indexPath.row)!
        switch indexPath.row{
        case 0:
            NoorSDK.shared.gotoHome(tabBar: self.tabBarController, nav: self.navigationController!)
        case 1:
            NoorSDK.shared.goto(feature: .islamicName, tabBar: self.tabBarController, nav: self.navigationController!)
        case 2:
            NoorSDK.shared.goto(feature: .tasbeeh, tabBar: self.tabBarController, nav: self.navigationController!)
        case 3:
            NoorSDK.shared.goto(feature: .dua, tabBar: self.tabBarController, nav: self.navigationController!)
        case 4:
            NoorSDK.shared.goto(feature: .hadith, tabBar: self.tabBarController, nav: self.navigationController!)
        case 5:
            NoorSDK.shared.goto(feature: .prayerTime, tabBar: self.tabBarController, nav: self.navigationController!)
        case 6:
            NoorSDK.shared.goto(feature: .qibla, tabBar: self.tabBarController, nav: self.navigationController!)
        case 7:
            NoorSDK.shared.goto(feature: .zakat, tabBar: self.tabBarController, nav: self.navigationController!)
        case 8:
            NoorSDK.shared.goto(feature: .alQuaran, tabBar: self.tabBarController, nav: self.navigationController!)
        case 9: break
            //DeenIslamGPSDK.shared.goto(feature: .ramadan )
        case 10:
            NoorSDK.shared.goto(feature: .islamicEvent , tabBar: self.tabBarController, nav: self.navigationController!)
        case 11:
            NoorSDK.shared.goto(feature: .nearestMosque, tabBar: self.tabBarController, nav: self.navigationController!)
        case 12:
            NoorSDK.shared.goto(feature: .eidJamatPlace, tabBar: self.tabBarController, nav: self.navigationController!)
        case 13:
            NoorSDK.shared.goto(feature: .namazLearning, tabBar: self.tabBarController, nav: self.navigationController!)
        case 14:
            NoorSDK.shared.goto(feature: .moccaModinaLive, tabBar: self.tabBarController, nav: self.navigationController!)
        case 15:
            NoorSDK.shared.goto(feature: .duaAndAmol, tabBar: self.tabBarController, nav: self.navigationController!)
        case 16:
            NoorSDK.shared.goto(feature: .islamicLearningStory, tabBar: self.tabBarController, nav: self.navigationController!)
        case 17:
            NoorSDK.shared.goto(feature: .ramadan, tabBar: self.tabBarController, nav: self.navigationController!)
        case 18:
            NoorSDK.shared.goto(feature: .KhotomQuran, tabBar: self.tabBarController, nav: self.navigationController!)
        case 19:
            NoorSDK.shared.goto(feature: .HajjAndUmrah, tabBar: self.tabBarController, nav: self.navigationController!)
        case 20:
            NoorSDK.shared.goto(feature: .AllahNames, tabBar: self.tabBarController, nav: self.navigationController!)
            
        case 21:
            NoorSDK.shared.goto(feature: .IslamicCalender, tabBar: self.tabBarController, nav: self.navigationController!)
        case 22:
            NoorSDK.shared.goto(feature: .IslamicBoyan, tabBar: self.tabBarController, nav: self.navigationController!)
        case 23:
            NoorSDK.shared.goto(feature: .rramadan, tabBar: self.tabBarController, nav: self.navigationController!)
            
        default:
            NoorSDK.shared.goto(feature: .home, tabBar: self.tabBarController, nav: self.navigationController!)
        }
        
        
    }
}

extension HomeVC : UITextFieldDelegate{
    
}
extension HomeVC : DeenIslamSDKNotifier{
    
    func deenPaymentEvent(eventName: String, parameters: [String : String]) {
        print("Payment name: \(eventName)")
        print("Event parameters:")
           for (key, value) in parameters {
               print("\(key): \(value)")
           }
    }
    
    func errorMessage(error: String) {
        
    }
    
    func tokenStatus(token isValid: Bool, error: String?) {
        if isValid{
            print("token is valid")
        }else{
            print(error ?? "error")
        }
    }
}


