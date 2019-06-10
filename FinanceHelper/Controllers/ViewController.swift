//
//  ViewController.swift
//  FinanceHelper
//
//  Created by Boris on 4/23/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var mainLbl: UILabel!
    
    @IBOutlet weak var legendTableView: UITableView!
    
    @IBOutlet weak var totalSumLbl: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var totalView: UIView!
    var alertView: AlertView!
    var realm = try! Realm()
    
    private lazy var expenseAlertView: ExpenseAlertView = {
        let expenseAlertView: ExpenseAlertView = ExpenseAlertView.loadFromNib()
        expenseAlertView.delegate = self
        return expenseAlertView
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @IBOutlet weak var addIncomeBtn: UIButton!
    
    
    @IBOutlet weak var addExpenseBtn: UIButton!
    
    
    var accountsData = AccountsData.shared
    
   // var accounts: [Account] = AccountsData.shared.accounts
    
    var accountsRealm: Results<Account>!
    
    
    var arrayOfDataForChart: [PieChartDataEntry] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupBackgroundImage()
        accountsRealm = realm.objects(Account.self)
        
        for item in accountsRealm{
            let account = Account()
            account.title = item.title
            account.amountOfMoney = item.amountOfMoney
            account.currency = item.currency
            accountsData.accounts.append(account)
        }
        
        
        
        setupLegendTableView()
        updateData()
        updateCharData()
        legendTableView.reloadData()
        
        totalView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.08)
        totalView.layer.cornerRadius = 10
        setSumLbl()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
            
        
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.backgroundColor = .clear
        
        
        // Keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
       // NotificationCenter.default.addObserver(self, selector: #selector(onTableCellDeleted(_:)), name: NSNotification.Name(rawValue: "Table cell deleted"), object: nil)
        
        // Chart Configuration
        pieChartView.chartDescription?.text = ""
        pieChartView.holeColor = .clear
        pieChartView.holeRadiusPercent = 0.35
        pieChartView.transparentCircleRadiusPercent = 0.4
        pieChartView.legend.enabled = false
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.rotationEnabled = false
      
        updateCharData()
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(true)
//        
//        try! self.realm.write {
//            self.realm.deleteAll()
//        }
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       self.tabBarController?.tabBar.isHidden = false
        
    }
    
//    @objc func onTableCellDeleted(_ notification: NSNotification){
//        print("table cell deleted")
//        print(accountsData.accounts)
//        updateData()
//        updateCharData()
//        legendTableView.reloadData()
//    }
    
    
    // Selectors for kb notifications
    @objc func keyboardWillShow(_ notification: NSNotification){
        guard let userInfo = notification.userInfo else {return}
        let kbFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        alertView.frame.origin.y -= kbFrame.size.height / 5
        expenseAlertView.frame.origin.y -= kbFrame.size.height / 5
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        alertView.frame.origin.y = 0
        expenseAlertView.frame.origin.y = 0
    }
    
    
    
    func updateData(){
        if accountsData.accounts.isEmpty == false{
            for index in 0...accountsData.accounts.count - 1 {
            
                for item in arrayOfDataForChart{
                    if item.label == accountsData.accounts[index].title {
                        arrayOfDataForChart.remove(at: arrayOfDataForChart.firstIndex(of: item)!)
                    }
                }
                
                arrayOfDataForChart.append(PieChartDataEntry(value: Double(accountsData.accounts[index].amountOfMoney), label: accountsData.accounts[index].title))
            
                if index == 3{
                    break
                }
            }
        }
        
    }
    // MARK: Setup new views
    
    func setupLegendTableView(){
        legendTableView.delegate = self
        legendTableView.dataSource = self
        legendTableView.rowHeight =  41.5
        legendTableView.allowsSelection = false
        legendTableView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.08)
        legendTableView.tableFooterView = UIView()
        legendTableView.layer.cornerRadius = 10
        legendTableView.isScrollEnabled = false
        legendTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: legendTableView.frame.size.width, height: 1))
    }
    
    func setupAlert(){
        alertView = AlertView.loadFromNib()
        alertView.delegate = self
        self.view.addSubview(alertView)
        alertView.center = self.view.center
        alertView.titleLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        alertView.firstLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        alertView.secondLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        alertView.titleLbl.text = "Add Income"
        alertView.firstLbl.text = "Account"
        alertView.secondLbl.text = "Sum"
    }
    
  

    
    func setupExpenseAlert() {
        self.view.addSubview(expenseAlertView)
        expenseAlertView.center = self.view.center
        expenseAlertView.titleLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        expenseAlertView.firstLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        expenseAlertView.secondLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        expenseAlertView.thirdLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        expenseAlertView.titleLbl.text = "Add Expence"
        expenseAlertView.firstLbl.text = "Account"
        expenseAlertView.secondLbl.text = "Type"
        expenseAlertView.thirdLbl.text = "Sum"
    }
    
    
    func setupVisualEffectView(){
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
    // MARK: ANIMATION
    
    func expenseAnimatedIn(){
        expenseAlertView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        expenseAlertView.alpha = 0
        
        
        UIView.animate(withDuration: 0.3) {
            self.visualEffectView.alpha = 0.5
            self.expenseAlertView.alpha = 1
            self.expenseAlertView.transform = CGAffineTransform.identity
        }
    }
    
    func cancelExpenseAnimatedOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.expenseAlertView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.visualEffectView.alpha = 0
            self.expenseAlertView.alpha = 0
            
        }) { (_) in
            self.expenseAlertView.removeFromSuperview()
            self.visualEffectView.removeFromSuperview()
        }
    }
    
    func addExpenseAnimatedOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.expenseAlertView.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.visualEffectView.alpha = 0
            self.expenseAlertView.alpha = 0
            
        }) { (_) in
            self.expenseAlertView.removeFromSuperview()
            self.visualEffectView.removeFromSuperview()
        }
    }
    
    
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
    
    
    func updateCharData(){
        let charDataSet = PieChartDataSet(entries: arrayOfDataForChart, label: nil)
        let charDataObject = PieChartData(dataSet: charDataSet)
        
        let colors: [UIColor] = [UIColor(red:0.87, green:0.24, blue:0.44, alpha:1.0), UIColor(red:0.96, green:0.65, blue:0.14, alpha:1.0), UIColor(red:0.29, green:0.79, blue:0.89, alpha:1.0), UIColor(red:0.53, green:0.70, blue:0.34, alpha:1.0)]
        charDataSet.colors = colors
        charDataSet.drawValuesEnabled = false
        pieChartView.data = charDataObject
        
    }
    
    func sumOfMoney() -> Float{
        var sum: Float = 0
        for item in accountsData.accounts{
            sum += item.amountOfMoney
        }
        return sum
    }
    
    func setSumLbl(){
        let sum = sumOfMoney()
        totalSumLbl.text = "\(sum) UAH"
        totalSumLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
    }
    
    @IBAction func settingsBtnPressed(_ sender: UIBarButtonItem) {
        
    }
    
    
    @IBAction func menuBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let accountsManagementVC = storyboard.instantiateViewController(withIdentifier: "AccountsManagementViewController")
        self.navigationController?.popToViewController(accountsManagementVC, animated: true)
    }
    
    
    @IBAction func addIncomeBtnPressed(_ sender: UIButton) {
        setupVisualEffectView()
        setupAlert()
        animatedIn()
    }
    
    
    
    @IBAction func addExpenseBtnPressed(_ sender: UIButton) {
        setupVisualEffectView()
        setupExpenseAlert()
        expenseAnimatedIn()
    }
    
    
}





extension ViewController: AlertDelegate {
    
//    func saveInRealm() {
//        let account = AccountRealm()
//        guard let title = alertView.firstLblTF.text else {return}
//        let amountOfMoney = Float(alertView.secondLblTF.text!) ?? 0
//
//        account.amountOfMoney = amountOfMoney
//        account.title = title
//
//
//        try! self.realm.write {
//            self.realm.add(account)
//            print("saved in realm")
//        }
//    }
    
    
    func addBtnPressed() {
        
        if accountsData.accounts.isEmpty && alertView.firstLblTF.text != nil && alertView.firstLblTF.text != "" && alertView.secondLblTF.text != nil && alertView.secondLblTF.text != ""{
//            accountsData.accounts.append(Account(title: alertView.firstLblTF.text!, currency: "Usd", amountOfMoney: Float(alertView.secondLblTF.text!) ?? 0))
            let account = Account()
            account.amountOfMoney = Float(alertView.secondLblTF.text!) ?? 0
            account.title = alertView.firstLblTF.text!
            accountsData.accounts.append(account)
            
            try! self.realm.write {
                self.realm.add(account)
            }
            
//            saveInRealm()
            alertView.removeFromSuperview()
            visualEffectView.removeFromSuperview()
            updateData()
            updateCharData()
            addAnimatedOut()
            alertView.firstLblTF.text = ""
            alertView.secondLblTF.text = ""
            alertView.firstLblTF.placeholder = nil
            alertView.secondLblTF.placeholder = nil
        } else if alertView.firstLblTF.text != nil && alertView.firstLblTF.text != "" && alertView.secondLblTF.text != nil && alertView.secondLblTF.text != "" && accountsData.accounts.contains(where: { (item) -> Bool in
            if item.title == alertView.firstLblTF.text! {
                return true
            }
            return false
        }) == false {
//            accountsData.accounts.append(Account(title: alertView.firstLblTF.text!, currency: "Usd", amountOfMoney: Float(alertView.secondLblTF.text!) ?? 0))
            let account = Account()
            account.amountOfMoney = Float(alertView.secondLblTF.text!) ?? 0
            account.title = alertView.firstLblTF.text!
            accountsData.accounts.append(account)
            
            try! self.realm.write {
                self.realm.add(account)
            }
            
//            saveInRealm()
            alertView.removeFromSuperview()
            visualEffectView.removeFromSuperview()
            updateData()
            updateCharData()
            addAnimatedOut()
            alertView.firstLblTF.text = ""
            alertView.secondLblTF.text = ""
            alertView.firstLblTF.placeholder = nil
            alertView.secondLblTF.placeholder = nil
        } else if accountsData.accounts.contains(where: { (item) -> Bool in
            if item.title == alertView.firstLblTF.text!{
                return true
            }
            return false
        }) == true  {
            
            var accountsInRealm: Results<Account>!
            accountsInRealm = realm.objects(Account.self)
            
//            try! realm.write {
//                for item in accountsInRealm{
//                    if item.title == alertView.firstLblTF.text!{
//                        item.amountOfMoney += Float(alertView.secondLblTF.text!) ?? 0
//                    }
//                }
//            }
            
            
            for item in accountsData.accounts{
                if item.title == alertView.firstLblTF.text!{
                    item.amountOfMoney += Float(alertView.secondLblTF.text!) ?? 0
                }
            }
            
            
            
//            saveInRealm()
            alertView.removeFromSuperview()
            visualEffectView.removeFromSuperview()
            updateData()
            updateCharData()
            addAnimatedOut()
            alertView.firstLblTF.text = ""
            alertView.secondLblTF.text = ""
            alertView.firstLblTF.placeholder = nil
            alertView.secondLblTF.placeholder = nil
        } else {
            alertView.firstLblTF.placeholder = "Can not be empty"
            alertView.secondLblTF.placeholder = "Can not be empty"
        }
        
        legendTableView.reloadData()
        setSumLbl()
    }
    
    func cancelBtnPressed() {
        alertView.removeFromSuperview()
        visualEffectView.removeFromSuperview()
        alertView.firstLblTF.text = ""
        alertView.secondLblTF.text = ""
        alertView.firstLblTF.placeholder = nil
        alertView.secondLblTF.placeholder = nil
       
        cancelAnimatedOut()
    }
    
    
}

extension ViewController: ExpenseAlertDelegate {
    func addBtnTapped(){
        if accountsData.accounts.contains(where: { (item) -> Bool in
            if item.title == expenseAlertView.firstLblTF.text!{
                return true
            }
            return false
        }) == true && expenseAlertView.secondLblTF.text != nil && expenseAlertView.secondLblTF.text != "" && expenseAlertView.firstLblTF.text != "" && expenseAlertView.firstLblTF.text != nil && expenseAlertView.thirdLblTF.text != "" && expenseAlertView.thirdLblTF.text != nil{
            for item in accountsData.accounts{
                if item.title == expenseAlertView.firstLblTF.text!{
                    item.amountOfMoney -= Float(expenseAlertView.thirdLblTF.text!) ?? 0
                }
            }
            
            expenseAlertView.removeFromSuperview()
            visualEffectView.removeFromSuperview()
            updateData()
            updateCharData()
            addExpenseAnimatedOut()
            expenseAlertView.firstLblTF.text = ""
            expenseAlertView.secondLblTF.text = ""
            expenseAlertView.thirdLblTF.text = ""
            expenseAlertView.firstLblTF.placeholder = nil
            expenseAlertView.secondLblTF.placeholder = nil
        } else if accountsData.accounts.contains(where: { (item) -> Bool in
            if item.title == expenseAlertView.firstLblTF.text!{
                return true
            }
            return false
        }) == false {
            expenseAlertView.firstLblTF.placeholder = "No such account"
            expenseAlertView.secondLblTF.placeholder = "No such account"
            expenseAlertView.thirdLblTF.placeholder = "No such account"
        } else {
            expenseAlertView.firstLblTF.placeholder = "Can not be empty"
            expenseAlertView.secondLblTF.placeholder = "Can not be empty"
            expenseAlertView.thirdLblTF.placeholder = "Can not be empty"
        }
        
        legendTableView.reloadData()
        setSumLbl()
    }
    
    func cancelBtnTapped(){
        expenseAlertView.firstLblTF.text = ""
        expenseAlertView.secondLblTF.text = ""
        expenseAlertView.thirdLblTF.text = ""
        expenseAlertView.firstLblTF.placeholder = nil
        expenseAlertView.secondLblTF.placeholder = nil
        expenseAlertView.thirdLblTF.placeholder = nil
        expenseAlertView.removeFromSuperview()
        visualEffectView.removeFromSuperview()
        cancelExpenseAnimatedOut()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfDataForChart.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = legendTableView.dequeueReusableCell(withIdentifier: "LegendTableViewCell", for: indexPath) as! LegendTableViewCell
        cell.backgroundColor = .clear
        cell.colorOfElement.backgroundColor = pieChartView.data?.getColors()![indexPath.row]
        cell.nameOfAccountLbl.text = accountsData.accounts[indexPath.row].title
        cell.nameOfAccountLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        cell.valueOfAccountLbl.text = String(accountsData.accounts[indexPath.row].amountOfMoney)
        cell.valueOfAccountLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)

        return cell
    }


}
