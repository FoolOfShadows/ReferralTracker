//
//  ReferralWindowController.swift
//  ReferralTracker
//
//  Created by Fool on 7/24/19.
//  Copyright © 2019 Fool. All rights reserved.
//

import Cocoa

class ReferralWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        //Need this to allow the program to remember last window location when reopening
        self.windowFrameAutosaveName = "referralWindow"
    }

}
