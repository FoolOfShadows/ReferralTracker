//
//  SpecialistVC.swift
//  ReferralTracker
//
//  Created by Fool on 10/23/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Cocoa



class SpecialistVC: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var specName: NSTextField!
    @IBOutlet weak var specAddress: NSTextField!
    @IBOutlet weak var specPhone: NSTextField!
    @IBOutlet weak var specFax: NSTextField!
    @IBOutlet weak var specialty: NSTextField!
    @IBOutlet weak var npi: NSTextField!
    @IBOutlet weak var contact: NSTextField!
    @IBOutlet weak var id: NSTextField!
    
    @IBOutlet weak var specialistTableView: NSTableView!
    
    var specialistArray = [Specialist]()
    let specialistsFilePath = URL(fileURLWithPath: "\(NSHomeDirectory())/WPCMSharedFiles/WPCM Software Bits/00 CAUTION - Data Files/specialists.json")
    
    weak var currentSpecialistDelegate: SpecialistDelegate?
    var chosenSpecialist:Specialist?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.specialistTableView.delegate = self
        self.specialistTableView.dataSource = self
        
        specialistTableView.target = self
        specialistTableView.doubleAction = #selector(tableViewDoubleClick(_:))
    }

    override func viewDidAppear() {
        guard let output = [Specialist].parse(jsonFile: specialistsFilePath) else {return}
        specialistArray = output

        for item in specialistArray {
            print(item.specName)
        }
        self.specialistTableView.reloadData()
    }

    
    @IBAction func proccessChoice(_ sender: NSButton) {
        let firstVC = presentingViewController as! ViewController
        firstVC.chosenSpecialist = Specialist(specName: specName.stringValue, specAddress: specAddress.stringValue, specPhone: specPhone.stringValue, specFax: specFax.stringValue, specialty: specialty.stringValue, npi: npi.stringValue, contact: contact.stringValue)
        firstVC.addSpecialist()
        self.dismiss(self)
    }
    
    @IBAction func addSpecialistToList(_ sender: NSButton) {
        if id.stringValue.isEmpty {
            if !specName.stringValue.isEmpty {
                specialistArray.append(Specialist(specName: specName.stringValue, specAddress: specAddress.stringValue, specPhone: specPhone.stringValue, specFax: specFax.stringValue, specialty: specialty.stringValue, npi: npi.stringValue, contact: contact.stringValue))
            }
            
        } else {
            let existingRecord = specialistArray.filter {$0.id.uuidString == id.stringValue}[0]
            existingRecord.specName = specName.stringValue
            existingRecord.specAddress = specAddress.stringValue
            existingRecord.specPhone = specPhone.stringValue
            existingRecord.specFax = specFax.stringValue
            existingRecord.specialty = specialty.stringValue
            existingRecord.npi = npi.stringValue
            existingRecord.contact = contact.stringValue
        }
        
        saveJSONFile(sender)
        clear(sender)
        
        print("Number of items in array = \(specialistArray.count)")
        self.specialistTableView.reloadData()
    }
    
    @IBAction func deleteItem(_ sender: NSButton) {
        if !id.stringValue.isEmpty {
            specialistArray.removeAll(where: {$0.id.uuidString == id.stringValue})
            self.specialistTableView.reloadData()
            saveJSONFile(sender)
            clear(sender)
        }
    }
    
    @IBAction func saveJSONFile(_ sender: Any) {
        //let pathDirectory = getDocumentsDirectory()
        //try? FileManager().createDirectory(at: pathDirectory, withIntermediateDirectories: true)
        //let filePath = pathDirectory.appendingPathComponent("specialists.json")
        //let specialtsList = [Specialist()]
        let json = try? JSONEncoder().encode(specialistArray)
        
        do {
            try json!.write(to: specialistsFilePath)
        } catch {
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }
    

    @IBAction func clear(_ sender: Any) {
        id.stringValue = ""
        specName.stringValue = ""
        specAddress.stringValue = ""
        specPhone.stringValue = ""
        specFax.stringValue = ""
        specialty.stringValue = ""
        npi.stringValue = ""
        contact.stringValue = ""
    }
    
    private func createSpecialistObjectWith(json: Data, completion: @escaping (_ data: Specialist?, _ error: Error?) -> Void) {
        do {
            let decoder = JSONDecoder()
            let specialist = try decoder.decode(Specialist.self, from: json)
            return completion(specialist, nil)
        } catch let error {
            print("Error creating specialist from JSON because: \(error.localizedDescription)")
            return completion(nil, error)
        }
    }

    
    //MARK: Table Handling
    func numberOfRows(in tableView: NSTableView) -> Int {
        print(specialistArray.count)
        return specialistArray.count
    }

    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let currentSpecialist = specialistArray[row]
        
        if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "nameColumn") {
            let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "nameCell")
            guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else {return nil}
            cellView.textField?.stringValue = currentSpecialist.specName
            return cellView
        } else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "specialtyColumn") {
            let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "specialtyCell")
            guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else {return nil}
            cellView.textField?.stringValue = currentSpecialist.specialty
            return cellView
        }
        
        return nil
    }
    
    //Load the selected Specialists data into the form when there selected in the table
    //FIX: need to make sure to update existing item rather than create a new one
    @objc func tableViewDoubleClick(_ sender:AnyObject) {
        let item = specialistArray[specialistTableView.selectedRow]
        
        id.stringValue = item.id.uuidString
        specName.stringValue = item.specName
        specAddress.stringValue = item.specAddress
        specPhone.stringValue = item.specPhone
        specFax.stringValue = item.specFax
        specialty.stringValue = item.specialty
        npi.stringValue = item.npi
        contact.stringValue = item.contact
    }
    
}
