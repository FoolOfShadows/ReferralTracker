//
//  InsuranceVC.swift
//  ReferralTracker
//
//  Created by Fool on 10/23/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Cocoa

class InsuranceVC: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var id: NSTextField!
    @IBOutlet weak var insName: NSTextField!
    @IBOutlet weak var insPhone: NSTextField!
    @IBOutlet weak var insFax: NSTextField!
    
    @IBOutlet weak var insuranceTableView: NSTableView!
    
    var insuranceArray = [Insurance]()
    let insuranceFilePath = URL(fileURLWithPath: "\(NSHomeDirectory())/WPCMSharedFiles/WPCM Software Bits/00 CAUTION - Data Files/insurances.json")
    
    weak var currentInsuranceDelegate: InsuranceDelegate?
    var chosenInsurance:Insurance?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.insuranceTableView.delegate = self
        self.insuranceTableView.dataSource = self
        
        insuranceTableView.target = self
        insuranceTableView.doubleAction = #selector(tableViewDoubleClick(_:))
    }
    
    override func viewDidAppear() {
        guard let output = [Insurance].parse(jsonFile: insuranceFilePath) else { return }
        insuranceArray = output
        
        self.insuranceTableView.reloadData()
    }
    
    @IBAction func processChoice(_ sender: NSButton) {
        let firstVC = presentingViewController as! ViewController
        firstVC.chosenInsurance = Insurance(insName: insName.stringValue, insPhone: insPhone.stringValue, insFax: insFax.stringValue)
        firstVC.addInsurance()
        self.dismiss(self)
    }
    
    @IBAction func addInsuranceToList(_ sender: NSButton) {
        if id.stringValue.isEmpty {
            if !insName.stringValue.isEmpty {
                insuranceArray.append(Insurance(insName: insName.stringValue, insPhone: insPhone.stringValue, insFax: insFax.stringValue))
            }
        } else {
            let existingRecord = insuranceArray.filter {$0.id.uuidString == id.stringValue}[0]
            existingRecord.insName = insName.stringValue
            existingRecord.insPhone = insPhone.stringValue
            existingRecord.insFax = insFax.stringValue
        }
        saveJSONFile(sender)
        clear(sender)
        
        self.insuranceTableView.reloadData()
    }
    
    @IBAction func deleteItem(_ sender: NSButton) {
        if !id.stringValue.isEmpty {
            insuranceArray.removeAll(where: {$0.id.uuidString == id.stringValue})
            self.insuranceTableView.reloadData()
            saveJSONFile(sender)
            clear(sender)
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        id.stringValue = ""
        insName.stringValue = ""
        insPhone.stringValue = ""
        insFax.stringValue = ""
    }
    
    @IBAction func saveJSONFile(_ sender: Any) {
        let json = try? JSONEncoder().encode(insuranceArray)
        
        do {
            try json!.write(to: insuranceFilePath)
        } catch {
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }
    
    private func createInsuranceObjectWith(json: Data, completion: @escaping (_ data: Insurance?, _ error: Error?) -> Void) {
        do {
            let decoder = JSONDecoder()
            let insurance = try decoder.decode(Insurance.self, from: json)
            return completion(insurance, nil)
        } catch let error {
            print("Error creating insurance from JSON because \(error.localizedDescription)")
            return completion(nil, error)
        }
    }
    
    //MARK: Table Handling
    func numberOfRows(in tableView: NSTableView) -> Int {
        //print(specialistArray.count)
        return insuranceArray.count
    }

    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let currentInsurance = insuranceArray[row]
        
        if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "nameColumn") {
            let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "nameCell")
            guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else {return nil}
            cellView.textField?.stringValue = currentInsurance.insName
            return cellView
        }
        return nil
    }
    
    @objc func tableViewDoubleClick(_ sender:AnyObject) {
        let item = insuranceArray[insuranceTableView.selectedRow]
        
        id.stringValue = item.id.uuidString
        insName.stringValue = item.insName
        insPhone.stringValue = item.insPhone
        insFax.stringValue = item.insFax
    }
    
}
