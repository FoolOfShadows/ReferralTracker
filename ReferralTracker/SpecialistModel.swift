//
//  SpecialistModel.swift
//  ReferralTracker
//
//  Created by Fool on 10/22/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Foundation

class Specialists:Codable {
    var specialist: [Specialist]?
    
    init(fileURL: URL) {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        guard let jsonData = try? JSONDecoder().decode(Specialists.self, from: data) else {return}
        
        specialist = jsonData.specialist
    }
}

//For column sorting to be implemented the class has to inherit from NSObject
//to avoid crashing and the extension below must be implemented for the sorting
//to actually work.
class Specialist: NSObject, Codable {
    var id:UUID
    var specName:String
    var specAddress:String
    var specPhone:String
    var specFax:String
    var specialty:String
    var npi:String
    var contact:String
    
    init(specName:String, specAddress:String, specPhone:String, specFax:String, specialty:String, npi:String, contact:String) {
        self.id = UUID()
        self.specName = specName
        self.specAddress = specAddress
        self.specPhone = specPhone
        self.specFax = specFax
        self.specialty = specialty
        self.npi = npi
        self.contact = contact
    }
}

extension Specialist {
    @objc override func value(forKey key: String) -> Any? {
        switch key {
        case "specialty":
            return specialty
        case "name":
            return specName
        default:
            return nil
        }
    }
}
