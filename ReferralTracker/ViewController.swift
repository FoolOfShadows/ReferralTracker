//
//  ViewController.swift
//  ReferralTracker
//
//  Created by Fool on 7/23/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextViewDelegate, NSTextFieldDelegate, NSControlTextEditingDelegate, NSWindowDelegate {
    
    @IBOutlet weak var ptName: NSTextField!
    @IBOutlet weak var dob: NSTextField!
    @IBOutlet weak var age: NSTextField!
    @IBOutlet weak var mobile: NSTextField!
    @IBOutlet weak var home: NSTextField!
    @IBOutlet weak var address: NSTextField!
    @IBOutlet weak var activityRefCheckbox: NSButton!
    @IBOutlet weak var activityRadCheckbox: NSButton!
    @IBOutlet weak var paNoCheckbox: NSButton!
    @IBOutlet weak var paYesCheckbox: NSButton!
    
    @IBOutlet weak var insurance: NSComboBox!
    @IBOutlet weak var specName: NSTextField!
    @IBOutlet weak var specAddress: NSTextField!
    @IBOutlet weak var specPhone: NSTextField!
    @IBOutlet weak var specFax: NSTextField!
    @IBOutlet weak var specialty: NSTextField!
    @IBOutlet weak var npi: NSTextField!
    @IBOutlet weak var contact: NSTextField!
    @IBOutlet weak var testType: NSTextField!
    @IBOutlet weak var testLocation: NSTextField!
    @IBOutlet weak var testTime: NSTextField!
    @IBOutlet weak var paInsurance: NSTextField!
    @IBOutlet weak var paInsPhone: NSTextField!
    @IBOutlet weak var paInsFax: NSTextField!
    @IBOutlet weak var infoNeeded: NSTextField!
    @IBOutlet weak var infoSent: NSTextField!
    @IBOutlet weak var declinedNoCheckbox: NSButton!
    @IBOutlet weak var declinedYesCheckbox: NSButton!
    @IBOutlet weak var notified: NSComboBox!
    @IBOutlet weak var notesScroll: NSScrollView!
    
    var notes:NSTextView {
        get {
            return notesScroll.contentView.documentView as! NSTextView
        }
    }
    var theData = Referral(theText: "")
    var document = Document()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ptName.delegate = self
        dob.delegate = self
        age.delegate = self
        mobile.delegate = self
        home.delegate = self
        address.delegate = self
        specName.delegate = self
        specAddress.delegate = self
        specPhone.delegate = self
        specFax.delegate = self
        specialty.delegate = self
        npi.delegate = self
        contact.delegate = self
        testType.delegate = self
        testLocation.delegate = self
        testTime.delegate = self
        paInsurance.delegate = self
        paInsPhone.delegate = self
        paInsFax.delegate = self
        notes.delegate = self
        infoNeeded.delegate = self
        infoSent.delegate = self
        //In order to catch purely textual changes to a combobox
        //I have to cast it as a textfield so I can make the
        //view controller a textfield delegate for it
        (notified as NSTextField).delegate = self
        
//        activityRadCheckbox.action = #selector(self.uniqueSelections)
//        activityRefCheckbox.action = #selector(self.uniqueSelections)
//        paNoCheckbox.action = #selector(self.uniqueSelections)
//        paYesCheckbox.action = #selector(self.uniqueSelections)
//        declinedNoCheckbox.action = #selector(self.uniqueSelections)
//        declinedYesCheckbox.action = #selector(self.uniqueSelections)
    }
    
    override func viewWillAppear() {
        document = self.view.window?.windowController?.document as! Document
        theData = document.theData
        
        ptName.stringValue = theData.ptName
        dob.stringValue = theData.dob
        age.stringValue = theData.age
        mobile.stringValue = theData.mobile
        home.stringValue = theData.home
        address.stringValue = theData.address
        specName.stringValue = theData.specName
        specAddress.stringValue = theData.specAddress
        specPhone.stringValue = theData.specPhone
        specFax.stringValue = theData.specFax
        specialty.stringValue = theData.specialty
        npi.stringValue = theData.npi
        contact.stringValue = theData.contact
        testType.stringValue = theData.testType
        testLocation.stringValue = theData.testLocation
        testTime.stringValue = theData.testTime
        paInsurance.stringValue = theData.paInsurance
        paInsPhone.stringValue = theData.paInsPhone
        paInsFax.stringValue = theData.paInsFax
        notes.string = theData.notes
        infoNeeded.stringValue = theData.infoNeeded
        infoSent.stringValue = theData.infoSent
        
        //Activity Section
        
        insurance.clearComboBox(menuItems:[""] +  theData.insurance.convertListToArray())
        //PA Needed Section
        
        //PA Declined Section
        
        notified.clearComboBox(menuItems: theData.notifiedChoices)
        notified.stringValue = theData.notified
        
        if theData.activityType == "Referral" {
            activityRefCheckbox.state = .on
        } else if theData.activityType == "Radiology" {
            activityRadCheckbox.state = .on
        }
        if theData.paNeeded == "No" {
            paNoCheckbox.state = .on
        } else if theData.paNeeded == "Yes" {
            paYesCheckbox.state = .on
        }
        if theData.paDeclined == "No" {
            declinedNoCheckbox.state = .on
        } else if theData.paDeclined == "Yes" {
            declinedYesCheckbox.state = .on
        }
    }
    
    override func viewDidAppear() {
        self.view.window?.delegate = self
    }
    
    //Update the Referral instance variables as the user is typing into the associated fields
    func textDidChange(_ notification: Notification) {
        guard let theView = notification.object as? NSTextView else { return }
        updateVarForView(theView)
        document.updateChangeCount(.changeDone)
    }
    
    /*override*/ func controlTextDidChange(_ obj: Notification) {
        guard let theView = obj.object as? NSTextField else { return }
        updateVarForField(theView)
        document.updateChangeCount(.changeDone)
    }
    
    
    @IBAction func updateDataFromSelectedCheckBox(_ sender: NSButton) {
        var result = ""
        uniqueSelections(sender)
        if sender.state == .on {
            result = sender.title
        } else if sender.state == .off {
            result = ""
        }
        
        switch sender.tag {
        case 100:
            theData.activityType = result
        case 200:
            theData.paNeeded = result
        case 300:
            theData.paDeclined = result
        default:
            return
        }
        
        document.updateChangeCount(.changeDone)
    }
    
    @IBAction func updateComboValues(_ sender: NSComboBox) {
        switch sender.tag {
        case 4:
            paInsurance.stringValue = sender.stringValue
            theData.paInsurance = sender.stringValue
        case 5:
            theData.notified = sender.stringValue
        default:
            return
        }
        document.updateChangeCount(.changeDone)
    }
    
    func updateVarForField(_ field:NSTextField) {
        switch field {
        case ptName: theData.ptName = ptName.stringValue
        case dob: theData.dob = dob.stringValue
        case mobile: theData.mobile = mobile.stringValue
        case home: theData.home = home.stringValue
        case address: theData.address = address.stringValue
        case specName: theData.specName = specName.stringValue
        case specAddress: theData.specAddress = specAddress.stringValue
        case specPhone: theData.specPhone = specPhone.stringValue
        case specFax: theData.specFax = specFax.stringValue
        case specialty: theData.specialty = specialty.stringValue
        case npi: theData.npi = npi.stringValue
        case contact: theData.contact = contact.stringValue
        case testType: theData.testType = testType.stringValue
        case testLocation: theData.testLocation = testLocation.stringValue
        case testTime: theData.testTime = testTime.stringValue
        case paInsurance: theData.paInsurance = paInsurance.stringValue
        case paInsPhone: theData.paInsPhone = paInsPhone.stringValue
        case paInsFax: theData.paInsFax = paInsFax.stringValue
        case infoNeeded: theData.infoNeeded = field.stringValue
        case infoSent: theData.infoSent = field.stringValue
        case notified: theData.notified = field.stringValue
        default: return
        }
        //print(theData.ptName)
    }
    
    func updateVarForView(_ view:NSTextView) {
        switch view {
        case notes: theData.notes = notes.string
        default: return
        }
        document.updateChangeCount(.changeDone)
    }
    //For this to work correctly the attending buttons must be in a subview together separate from other buttons you don't want associated
    func uniqueSelections(_ sender:NSButton) {
        if sender.state == .on {
            if let buttons = sender.superview?.subviews {
                for button in buttons {
                    if (button as! NSButton).title != sender.title {
                        (button as! NSButton).state = .off
                    }
                }
            }
        }
    }
    
    @IBAction func printReferral(_ sender: NSButton) {
        let theText = """
        
        
        
        \(Date().shortDate())
        
        Name:  \(ptName.stringValue)     (\(dob.stringValue) - \(age.stringValue))
        Mobile Phone: \(mobile.stringValue)     Home Phone:  \(home.stringValue)
        Address: \(address.stringValue.replacingOccurrences(of: "\n", with: ", "))
        
        Activity Type: \(theData.activityType)     PA Needed: \(theData.paNeeded)
        
        Specialist:
        \(specName.stringValue)  - \(specialty.stringValue)
        NPI: \(npi.stringValue)
        Contact: \(contact.stringValue)
        Phone: \(specPhone.stringValue)     Fax:  \(specFax.stringValue)
        Address: \(specAddress.stringValue)
        
        PA Insurance:
        \(paInsurance.stringValue)
        Phone: \(paInsPhone.stringValue)     Fax:  \(paInsFax.stringValue)
        Declined:  \(theData.paDeclined)
        
        Testing
        Type: \(testType.stringValue)
        Location: \(testLocation.stringValue)
        Time: \(testTime.stringValue)
        
        Info Needed: \(infoNeeded.stringValue)
        Info Sent: \(infoSent.stringValue)
        
        Patient Notified:  \(theData.notified)
        
        Notes:
        \(notes.string)
"""
        
        printBlankPageWithText(theText, fontSize: 14.0, window: self.view.window!)
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        let textFields = getTextFieldsInView(self.view)
        for field in textFields {
            updateVarForField(field)
        }
        return true
    }
}
