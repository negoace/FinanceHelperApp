//
//  ExpenseViewController.swift
//  FinanceHelper
//
//  Created by Boris on 6/17/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import UIKit
import RealmSwift
class ExpenseViewController: UIViewController {

    @IBOutlet weak var noDataLbl: UILabel!
    @IBOutlet weak var expenseTableView: UITableView!
    var historyArray: List<ExpenseHistory>!
    var historyArray2: [ExpenseHistory] = []
    var account = ""
    var expenseStatisticDict: Results<ExpenseStatisticDict>!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupExpenseTableView()
        self.setupBackgroundImage()
        // Do any additional setup after loading the view.
        
        let realm = try! Realm()
        expenseStatisticDict = realm.objects(ExpenseStatisticDict.self)
        var dict: [String:List<ExpenseHistory>] = [:]
        for item in expenseStatisticDict{
            dict[item.key] = item.value
        }
        historyArray = dict[account]
        print(dict)
        if historyArray != nil{
            for item in historyArray{
                historyArray2.append(item)
            }
        } else {
            noDataLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
            noDataLbl.isHidden = false
        }
    }
    
    private func setupExpenseTableView(){
        expenseTableView.delegate = self
        expenseTableView.dataSource = self
        expenseTableView.tableFooterView = UIView()
        expenseTableView.backgroundColor = .clear
        
        let viewHeight = self.view.frame.height
        let topConstraint = NSLayoutConstraint(item: expenseTableView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: viewHeight/3)
        expenseTableView.addConstraint(topConstraint)
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

extension ExpenseViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expenseTableView.dequeueReusableCell(withIdentifier: "ExpenseStatisticTableViewCell", for: indexPath) as! ExpenseStatisticTableViewCell
        cell.backgroundColor = .clear
        cell.dateLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        cell.sumLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        cell.expenseLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        cell.dateLbl.text = historyArray2[indexPath.row].date
        cell.expenseLbl.text = historyArray2[indexPath.row].expense
        cell.sumLbl.text = historyArray2[indexPath.row].sum
        
        return cell
    }
    
    
}
