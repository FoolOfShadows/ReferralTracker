//
//  ReferralModel.swift
//  ReferralTracker
//
//  Created by Fool on 7/2/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Foundation


class Referral {
    var theText:String
    private let currentDate = Date()
    private let formatter = DateFormatter()
    private var messageDate:String {
        formatter.dateStyle = DateFormatter.Style.short
        return formatter.string(from: currentDate)
    }
    
    var ptName = String()
    var dob = String()
    var age = String()
    var mobile = String()
    var home = String()
    var address = String()
    var activityType = String()
    var paNeeded = String()
    var insurance = String()
    var specName = String()
    var specAddress = String()
    var specPhone = String()
    var specFax = String()
    var specialty = String()
    var npi = String()
    var contact = String()
    var testType = String()
    var testLocation = String()
    var testTime = String()
    var paInsurance = String()
    var paInsPhone = String()
    var paInsFax = String()
    var infoNeeded = String()
    var infoSent = String()
    var paDeclined = String()
    var notified = String()
    var notes = String()
    
    let paNeededChoices = ["", "Y", "N"]
    let declinedChoices = ["", "Y", "N"]
    var notifiedChoices: [String] {return ["", "By phone \(messageDate)", "By mail \(messageDate)", "In person \(messageDate)", "N"]}
    let activityChoices = ["", "Referral", "Radiology"]
    
    init(theText: String) {
        print("Trying to initialize the data")
        self.theText = theText
        self.ptName = theText.simpleRegExMatch(Regexes().name).cleanTheTextOf([SectionDelimiters.ptNameStart.rawValue, SectionDelimiters.ptNameEnd.rawValue])
        self.dob = theText.simpleRegExMatch(Regexes().dob).cleanTheTextOf([SectionDelimiters.ptDOBStart.rawValue, SectionDelimiters.ptDOBEnd.rawValue])
        self.age = theText.simpleRegExMatch(Regexes().age).cleanTheTextOf([SectionDelimiters.ptAgeStart.rawValue, SectionDelimiters.ptAgeEnd.rawValue])
        self.mobile = theText.simpleRegExMatch(Regexes().mobile).cleanTheTextOf([SectionDelimiters.ptMobileStart.rawValue, SectionDelimiters.ptMobileEnd.rawValue])
        self.home = theText.simpleRegExMatch(Regexes().home).cleanTheTextOf([SectionDelimiters.ptHomeStart.rawValue, SectionDelimiters.ptHomeEnd.rawValue])
        self.address = theText.simpleRegExMatch(Regexes().address).cleanTheTextOf([SectionDelimiters.ptAddressStart.rawValue, SectionDelimiters.ptAddressEnd.rawValue])
        self.activityType = theText.simpleRegExMatch(Regexes().activityType).cleanTheTextOf([SectionDelimiters.activityTypeStart.rawValue, SectionDelimiters.activityTypeEnd.rawValue])
        self.paNeeded = theText.simpleRegExMatch(Regexes().paNeeded).cleanTheTextOf([SectionDelimiters.paNeededStart.rawValue, SectionDelimiters.paNeededEnd.rawValue])
        self.insurance = theText.simpleRegExMatch(Regexes().insurance).cleanTheTextOf([SectionDelimiters.insuranceStart.rawValue, SectionDelimiters.insuranceEnd.rawValue])
        self.specName = theText.simpleRegExMatch(Regexes().specName).cleanTheTextOf([SectionDelimiters.specNameStart.rawValue, SectionDelimiters.specNameEnd.rawValue])
        self.specAddress = theText.simpleRegExMatch(Regexes().specAddress).cleanTheTextOf([SectionDelimiters.specAddressStart.rawValue, SectionDelimiters.specAddressEnd.rawValue])
        self.specPhone = theText.simpleRegExMatch(Regexes().specPhone).cleanTheTextOf([SectionDelimiters.specPhoneStart.rawValue, SectionDelimiters.specPhoneEnd.rawValue])
        self.specFax = theText.simpleRegExMatch(Regexes().specFax).cleanTheTextOf([SectionDelimiters.specFaxStart.rawValue, SectionDelimiters.specFaxEnd.rawValue])
        self.specialty = theText.simpleRegExMatch(Regexes().specType).cleanTheTextOf([SectionDelimiters.specialtyStart.rawValue, SectionDelimiters.specialtyEnd.rawValue])
        self.npi = theText.simpleRegExMatch(Regexes().npi).cleanTheTextOf([SectionDelimiters.specNPIStart.rawValue, SectionDelimiters.specNPIEnd.rawValue])
        self.contact = theText.simpleRegExMatch(Regexes().contact).cleanTheTextOf([SectionDelimiters.specContactStart.rawValue, SectionDelimiters.specContactEnd.rawValue])
        self.testLocation = theText.simpleRegExMatch(Regexes().testLocation).cleanTheTextOf([SectionDelimiters.testLocationStart.rawValue, SectionDelimiters.testLocationEnd.rawValue])
        self.testTime = theText.simpleRegExMatch(Regexes().testTime).cleanTheTextOf([SectionDelimiters.testTimeStart.rawValue, SectionDelimiters.testTimeEnd.rawValue])
        self.testType = theText.simpleRegExMatch(Regexes().testType).cleanTheTextOf([SectionDelimiters.testTypeStart.rawValue, SectionDelimiters.testTypeEnd.rawValue])
        self.paInsurance = theText.simpleRegExMatch(Regexes().paInsurance).cleanTheTextOf([SectionDelimiters.paInsNameStart.rawValue, SectionDelimiters.paInsNameEnd.rawValue])
        self.paInsPhone = theText.simpleRegExMatch(Regexes().paInsPhone).cleanTheTextOf([SectionDelimiters.paInsPhoneStart.rawValue, SectionDelimiters.paInsPhoneEnd.rawValue])
        self.paInsFax = theText.simpleRegExMatch(Regexes().paInsFax).cleanTheTextOf([SectionDelimiters.paInsFaxStart.rawValue, SectionDelimiters.paInsFaxEnd.rawValue])
        self.infoNeeded = theText.simpleRegExMatch(Regexes().infoNeeded).cleanTheTextOf([SectionDelimiters.infoNeededStart.rawValue, SectionDelimiters.infoNeededEnd.rawValue])
        self.infoSent = theText.simpleRegExMatch(Regexes().infoSent).cleanTheTextOf([SectionDelimiters.infoSentStart.rawValue, SectionDelimiters.infoSentEnd.rawValue])
        self.paDeclined = theText.simpleRegExMatch(Regexes().declined).cleanTheTextOf([SectionDelimiters.paDeclinedStart.rawValue, SectionDelimiters.paDeclinedEnd.rawValue])
        self.notified = theText.simpleRegExMatch(Regexes().notified).cleanTheTextOf([SectionDelimiters.ptNotifiedStart.rawValue, SectionDelimiters.ptNotifiedEnd.rawValue])
        self.notes = theText.simpleRegExMatch(Regexes().notes).cleanTheTextOf([SectionDelimiters.notesStart.rawValue, SectionDelimiters.notesEnd.rawValue])
    }
    
    var saveValue:String { return """
#REFERRALFILE#
        
\(SectionDelimiters.ptNameStart.rawValue)
\(ptName)
\(SectionDelimiters.ptNameEnd.rawValue)

\(SectionDelimiters.ptDOBStart.rawValue)
\(dob)
\(SectionDelimiters.ptDOBEnd.rawValue)

\(SectionDelimiters.ptAgeStart.rawValue)
\(age)
\(SectionDelimiters.ptAgeEnd.rawValue)

\(SectionDelimiters.ptMobileStart.rawValue)
\(mobile)
\(SectionDelimiters.ptMobileEnd.rawValue)

\(SectionDelimiters.ptHomeStart.rawValue)
\(home)
\(SectionDelimiters.ptHomeEnd.rawValue)

\(SectionDelimiters.ptAddressStart.rawValue)
\(address)
\(SectionDelimiters.ptAddressEnd.rawValue)

\(SectionDelimiters.activityTypeStart.rawValue)
\(activityType)
\(SectionDelimiters.activityTypeEnd.rawValue)

\(SectionDelimiters.paNeededStart.rawValue)
\(paNeeded)
\(SectionDelimiters.paNeededEnd.rawValue)

\(SectionDelimiters.insuranceStart.rawValue)
\(insurance)
\(SectionDelimiters.insuranceEnd.rawValue)

\(SectionDelimiters.specNameStart.rawValue)
\(specName)
\(SectionDelimiters.specNameEnd.rawValue)

\(SectionDelimiters.specAddressStart.rawValue)
\(specAddress)
\(SectionDelimiters.specAddressEnd.rawValue)

\(SectionDelimiters.specPhoneStart.rawValue)
\(specPhone)
\(SectionDelimiters.specPhoneEnd.rawValue)

\(SectionDelimiters.specFaxStart.rawValue)
\(specFax)
\(SectionDelimiters.specFaxEnd.rawValue)

\(SectionDelimiters.specialtyStart.rawValue)
\(specialty)
\(SectionDelimiters.specialtyEnd.rawValue)

\(SectionDelimiters.specNPIStart.rawValue)
\(npi)
\(SectionDelimiters.specNPIEnd.rawValue)

\(SectionDelimiters.specContactStart.rawValue)
\(contact)
\(SectionDelimiters.specContactEnd.rawValue)
        
\(SectionDelimiters.testLocationStart.rawValue)
\(testLocation)
\(SectionDelimiters.testLocationEnd.rawValue)
        
\(SectionDelimiters.testTimeStart.rawValue)
\(testTime)
\(SectionDelimiters.testTimeEnd.rawValue)

\(SectionDelimiters.testTypeStart.rawValue)
\(testType)
\(SectionDelimiters.testTypeEnd.rawValue)

\(SectionDelimiters.paInsNameStart.rawValue)
\(paInsurance)
\(SectionDelimiters.paInsNameEnd.rawValue)

\(SectionDelimiters.paInsPhoneStart.rawValue)
\(paInsPhone)
\(SectionDelimiters.paInsPhoneEnd.rawValue)

\(SectionDelimiters.paInsFaxStart.rawValue)
\(paInsFax)
\(SectionDelimiters.paInsFaxEnd.rawValue)

\(SectionDelimiters.infoNeededStart.rawValue)
\(infoNeeded)
\(SectionDelimiters.infoNeededEnd.rawValue)

\(SectionDelimiters.infoSentStart.rawValue)
\(infoSent)
\(SectionDelimiters.infoSentEnd.rawValue)

\(SectionDelimiters.paDeclinedStart.rawValue)
\(paDeclined)
\(SectionDelimiters.paDeclinedEnd.rawValue)

\(SectionDelimiters.ptNotifiedStart.rawValue)
\(notified)
\(SectionDelimiters.ptNotifiedEnd.rawValue)

\(SectionDelimiters.notesStart.rawValue)
\(notes)
\(SectionDelimiters.notesEnd.rawValue)
"""
    }
}

//Enum used to define the start and end of the various sections
enum SectionDelimiters:String {
    //    case ptNameFirstStart = "#NAMEFIRST"
    //    case ptNameFirstEnd = "NAMEFIRST#"
    //
    //    case ptNameLastStart = "#NAMELAST"
    //    case ptNameLastEnd = "NAMELAST#"
    //
    //    case ptNameMiddleStart = "#NAMEMIDDLE"
    //    case ptNameMiddleEnd = "NAMEMIDDLE#"
    
    case ptNameStart = "#PATIENTNAME"
    case ptNameEnd = "PATIENTNAME#"
    
    case ptDOBStart = "#DOB"
    case ptDOBEnd = "DOB#"
    
    case ptAgeStart = "#AGE"
    case ptAgeEnd = "AGE#"
    
    case ptMobileStart = "#MOBILEPHONE"
    case ptMobileEnd = "MOBILEPHONE#"
    
    case ptHomeStart = "#HOMEPHONE"
    case ptHomeEnd = "HOMEPHONE#"
    
    case ptAddressStart = "#PATIENTADDRESS"
    case ptAddressEnd = "PATIENTADDRESS#"
    
    case activityTypeStart = "#ACTIVITYTYPE"
    case activityTypeEnd = "ACTIVITYTYPE#"
    
    case paNeededStart = "#PANEEDED"
    case paNeededEnd = "PANEEDED#"
    
    case insuranceStart = "#ALLINSURANCE"
    case insuranceEnd = "ALLINSURANCE#"
    
    case specNameStart = "#SPECNAME"
    case specNameEnd = "SPECNAME#"
    
    case specAddressStart = "#SPECADDRESS"
    case specAddressEnd = "SPECADDRESS#"
    
    case specPhoneStart = "#SPECPHONE"
    case specPhoneEnd = "SPECPHONE#"
    
    case specFaxStart = "#SPECFAX"
    case specFaxEnd = "SPECFAX#"
    
    case specialtyStart = "#SPECIALTY"
    case specialtyEnd = "SPECIALTY#"
    
    case specNPIStart = "#NPI"
    case specNPIEnd = "NPI#"
    
    case specContactStart = "#CONTACT"
    case specContactEnd = "CONTACT#"
    
    case testLocationStart = "#LOCATION"
    case testLocationEnd = "LOCATION#"
    
    case testTimeStart = "#TIME"
    case testTimeEnd = "TIME#"
    
    case testTypeStart = "#TESTTYPE"
    case testTypeEnd = "TESTTYPE#"
    
    case paInsNameStart = "#PAINSNAME"
    case paInsNameEnd = "PAINSNAME#"
    
    case paInsPhoneStart = "#PAINSPHONE"
    case paInsPhoneEnd = "PAINSPHONE#"
    
    case paInsFaxStart = "#PAINSFAX"
    case paInsFaxEnd = "PAINSFAX#"
    
    case infoNeededStart = "#INFONEEDED"
    case infoNeededEnd = "INFONEEDED#"
    
    case infoSentStart = "#INFOSENT"
    case infoSentEnd = "INFOSENT#"
    
    case paDeclinedStart = "#PADECLINED"
    case paDeclinedEnd = "PADECLINED#"
    
    case ptNotifiedStart = "#NOTIFIED"
    case ptNotifiedEnd = "NOTIFIED#"
    
    case notesStart = "#NOTES"
    case notesEnd = "NOTES#"
}

private struct Regexes {
    let name = "(?s)\(SectionDelimiters.ptNameStart.rawValue).*\(SectionDelimiters.ptNameEnd.rawValue)"
    let dob = "(?s)\(SectionDelimiters.ptDOBStart.rawValue).*\(SectionDelimiters.ptDOBEnd.rawValue)"
    let age = "(?s)\(SectionDelimiters.ptAgeStart.rawValue).*\(SectionDelimiters.ptAgeEnd.rawValue)"
    let mobile = "(?s)\(SectionDelimiters.ptMobileStart.rawValue).*\(SectionDelimiters.ptMobileEnd.rawValue)"
    let home = "(?s)\(SectionDelimiters.ptHomeStart.rawValue).*\(SectionDelimiters.ptHomeEnd.rawValue)"
    let address = "(?s)\(SectionDelimiters.ptAddressStart.rawValue).*\(SectionDelimiters.ptAddressEnd.rawValue)"
    let activityType = "(?s)\(SectionDelimiters.activityTypeStart.rawValue).*\(SectionDelimiters.activityTypeEnd.rawValue)"
    let paNeeded = "(?s)\(SectionDelimiters.paNeededStart.rawValue).*\(SectionDelimiters.paNeededEnd.rawValue)"
    let insurance = "(?s)\(SectionDelimiters.insuranceStart.rawValue).*\(SectionDelimiters.insuranceEnd.rawValue)"
    let specName = "(?s)\(SectionDelimiters.specNameStart.rawValue).*\(SectionDelimiters.specNameEnd.rawValue)"
    let specAddress = "(?s)\(SectionDelimiters.specAddressStart.rawValue).*\(SectionDelimiters.specAddressEnd.rawValue)"
    let specPhone = "(?s)\(SectionDelimiters.specPhoneStart.rawValue).*\(SectionDelimiters.specPhoneEnd.rawValue)"
    let specFax = "(?s)\(SectionDelimiters.specFaxStart.rawValue).*\(SectionDelimiters.specFaxEnd.rawValue)"
    let specType = "(?s)\(SectionDelimiters.specialtyStart.rawValue).*\(SectionDelimiters.specialtyEnd.rawValue)"
    let npi = "(?s)\(SectionDelimiters.specNPIStart.rawValue).*\(SectionDelimiters.specNPIEnd.rawValue)"
    let contact = "(?s)\(SectionDelimiters.specContactStart.rawValue).*\(SectionDelimiters.specContactEnd.rawValue)"
    let testLocation = "(?s)\(SectionDelimiters.testLocationStart.rawValue).*\(SectionDelimiters.testLocationEnd.rawValue)"
    let testTime = "(?s)\(SectionDelimiters.testTimeStart.rawValue).*\(SectionDelimiters.testTimeEnd.rawValue)"
    let testType = "(?s)\(SectionDelimiters.testTypeStart.rawValue).*\(SectionDelimiters.testTypeEnd.rawValue)"
    let paInsurance = "(?s)\(SectionDelimiters.paInsNameStart.rawValue).*\(SectionDelimiters.paInsNameEnd.rawValue)"
    let paInsPhone = "(?s)\(SectionDelimiters.paInsPhoneStart.rawValue).*\(SectionDelimiters.paInsPhoneEnd.rawValue)"
    let paInsFax = "(?s)\(SectionDelimiters.paInsFaxStart.rawValue).*\(SectionDelimiters.paInsFaxEnd.rawValue)"
    let infoNeeded = "(?s)\(SectionDelimiters.infoNeededStart.rawValue).*\(SectionDelimiters.infoNeededEnd.rawValue)"
    let infoSent = "(?s)\(SectionDelimiters.infoSentStart.rawValue).*\(SectionDelimiters.infoSentEnd.rawValue)"
    let declined = "(?s)\(SectionDelimiters.paDeclinedStart.rawValue).*\(SectionDelimiters.paDeclinedEnd.rawValue)"
    let notified = "(?s)\(SectionDelimiters.ptNotifiedStart.rawValue).*\(SectionDelimiters.ptNotifiedEnd.rawValue)"
    let notes = "(?s)\(SectionDelimiters.notesStart.rawValue).*\(SectionDelimiters.notesEnd.rawValue)"
}
