//
//  InsuranceModel.swift
//  ReferralTracker
//
//  Created by Fool on 10/23/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Foundation

class InsuranceCompanies:Codable {
    var insurances: [Insurance]?
    
    init(fileURL: URL) {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        guard let jsonData = try? JSONDecoder().decode(InsuranceCompanies.self, from: data) else { return }
        
        insurances = jsonData.insurances
    }
}
class Insurance:Codable {
    var id:UUID
    var insName:String
    var insPhone:String
    var insFax:String
    
    init(insName:String, insPhone:String, insFax:String) {
        self.id = UUID()
        self.insName = insName
        self.insPhone = insPhone
        self.insFax = insFax
    }
}
