//
//  ExchangeRates.swift
//  FinanceHelper
//
//  Created by Boris on 6/3/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ExchangeRates {
    static let shared = ExchangeRates()
    var usdRate: Double = 0 {
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "usdRateDidChange"), object: nil)
        }
    }
    var eurRate: Double = 0 {
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "eurRateDidChange"), object: nil)
        }
    }
    
    
    private init () { }
    
    private let urlString = "https://bank.gov.ua/NBU_Exchange/exchange?json" /*"https://bank.gov.ua/NBUStatService/v1/statdirectory/exchangenew?json"*/
    
    func makeRequest(params: [String:Any]){
        print("begin")

        guard let url = URL(string: urlString) else {return}
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            
            guard let data = response.data else {return}

            guard let json = try? JSON(data: data) else {return}
            
            guard let arr = json.array else {return}
         
            guard let usdDict = arr[7].dictionary else {return}
            
            
            
            guard let usdRate = usdDict["Amount"]?.double else {return}
            
            guard let usdUnits = usdDict["Units"]?.int else {return}
            
            let finalUsdRate = usdRate / Double(usdUnits)
            
            
            self.usdRate = round(finalUsdRate * 100)/100
            
            guard let eurDict = arr[9].dictionary else {return}
            
            
            
            guard let eurRate = eurDict["Amount"]?.double else {return}
            
            guard let eurUnits = eurDict["Units"]?.int else {return}
            
            let finalEurRate = eurRate / Double(eurUnits)
            
            self.eurRate = round(finalEurRate*100)/100
        }
        print("end")
    }
}
