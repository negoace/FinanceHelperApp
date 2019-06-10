//
//  AccountsManagementViewController.swift
//  FinanceHelper
//
//  Created by Boris on 4/23/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import UIKit
import RealmSwift

class AccountsManagementViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addAccBtn: UIBarButtonItem!
    
    
    var myIndex = 0
    
    var alertView: AlertView!
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var accountsData = AccountsData.shared
    
    var realm = try! Realm()
    
    //var accounts: [Account] = AccountsData.shared.accounts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationItem.title = "Your Accounts"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red:0.78, green:0.78, blue:0.78, alpha:1.0)]
        self.setupBackgroundImage()
        
        
        self.tabBarController?.tabBar.isHidden = true
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification){
        guard let userInfo = notification.userInfo else {return}
        let kbFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        alertView.frame.origin.y -= kbFrame.size.height / 5
        
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        alertView.frame.origin.y = 0
    }
    


    
    // MARK: SETUP NEW VIEWS
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        
        let image = UIImage(named: "Background")
        let imageView = UIImageView(image: image)
        tableView.backgroundView = imageView
        
    }
    
    func setupVisualEffectView(){
        self.view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
    func setupAlert(){
        alertView = AlertView.loadFromNib()
        alertView.delegate = self
        self.view.addSubview(alertView)
        alertView.center = self.view.center
        alertView.titleLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        alertView.firstLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        alertView.secondLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
    }
    
    
    
    
    // MARK: ANIMATION
    func animatedIn(){
        alertView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        alertView.alpha = 0
        
        
        UIView.animate(withDuration: 0.3) {
            self.visualEffectView.alpha = 0.5
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
        }
    }
    
    func cancelAnimatedOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.alertView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.visualEffectView.alpha = 0
            self.alertView.alpha = 0

        }) { (_) in
            self.alertView.removeFromSuperview()
            self.visualEffectView.removeFromSuperview()
        }
    }
    
    func addAnimatedOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.alertView.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.visualEffectView.alpha = 0
            self.alertView.alpha = 0
            
        }) { (_) in
            self.alertView.removeFromSuperview()
            self.visualEffectView.removeFromSuperview()
        }
    }
    
   
    
    
    @IBAction func addAccountBtnPressed(_ sender: UIBarButtonItem) {
        setupVisualEffectView()
        setupAlert()
        animatedIn()
    }
    

    
}


// MARK: EXTENSIONS
extension AccountsManagementViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountsData.accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountManagementTableViewCell", for: indexPath) as! AccountManagementTableViewCell
        
        cell.accountTitleLbl.text = accountsData.accounts[indexPath.row].title
        cell.backgroundColor = .clear
        cell.accountTitleLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        cell.amountOfMoneyLbl.text = String(accountsData.accounts[indexPath.row].amountOfMoney)
        cell.amountOfMoneyLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        myIndex = indexPath.row
        return indexPath
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        
//        let account = accountsData.accounts[indexPath.row]
//        
//        if editingStyle == .delete {
////            try! realm.write {
////                self.realm.delete(account)
////            }
//            self.accountsData.accounts.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            
//            
//        }
//    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteAction = UITableViewRowAction(style: .default, title: "") { (_, _) in
//            self.accountsData.accounts.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//        deleteAction.backgroundColor = UIColor(patternImage: UIImage(named: "Bin")!)
//
//        return [deleteAction]
//    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "") { (_, _, _) in
//            self.accountsData.accounts.remove(at: indexPath.row)
//            tableView.reloadData()
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Table cell deleted"), object: nil)
//        }
//
//        deleteAction.image = UIImage(named: "Bin")
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AccountSettingsTableViewController"{
            let nextVC = segue.destination as! AccountSettingsTableViewController
            nextVC.navigationItem.title = accountsData.accounts[myIndex].title
        }
    }
    
}

extension AccountsManagementViewController: AlertDelegate {
    func addBtnPressed(){
        if alertView.firstLblTF.text != nil && alertView.firstLblTF.text != "" && alertView.secondLblTF.text != nil && alertView.secondLblTF.text != "" && accountsData.accounts.contains(where: { (item) -> Bool in
            if item.title == alertView.firstLblTF.text! {
                return true
            }
            return false
        }) == false {
            let account = Account()
            account.currency = alertView.secondLblTF.text!
            account.title = alertView.firstLblTF.text!
            accountsData.accounts.append(account)
            
            try! self.realm.write {
                self.realm.add(account)
            }
            
                alertView.removeFromSuperview()
                visualEffectView.removeFromSuperview()
                addAnimatedOut()
                alertView.firstLblTF.text = ""
                alertView.secondLblTF.text = ""
                alertView.firstLblTF.placeholder = nil
                alertView.secondLblTF.placeholder = nil
                tableView.reloadData()
            
            
        } else {
            alertView.firstLblTF.placeholder = "Can not be empty"
            alertView.secondLblTF.placeholder = "Can not be empty"
        }
    }
    
    func cancelBtnPressed(){
        alertView.removeFromSuperview()
        visualEffectView.removeFromSuperview()
        alertView.firstLblTF.text = ""
        alertView.secondLblTF.text = ""
        alertView.firstLblTF.placeholder = nil
        alertView.secondLblTF.placeholder = nil
        cancelAnimatedOut()
        
    }
}
