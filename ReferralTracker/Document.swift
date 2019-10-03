//
//  Document.swift
//  ReferralTracker
//
//  Created by Fool on 7/2/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    
    var viewController: ViewController? {
        return windowControllers[0].contentViewController as? ViewController
    }
    
    var theData = Referral(theText: "")

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override class var autosavesInPlace: Bool {
        return true
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        //let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! NSWindowController
        self.addWindowController(windowController)
    }

    override func data(ofType typeName: String) throws -> Data {
        //Write data to a file
        if let theData = viewController?.theData.saveValue, let contents = theData.data(using: String.Encoding.utf8) {
            return contents
        }
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func read(from data: Data, ofType typeName: String) throws {
        // Load data from a file
        Swift.print("Starting data load")
        if let contents = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
            Swift.print("Data checks out.")
            if contents.contains("#REFERRALFILE#") {
                Swift.print("Data is referral file")
                theData = Referral(theText: contents)
            } else {
                theData.ptName = "You have tried to open a file which is not a valid Referral File."
            }
        }
        //throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }


}

