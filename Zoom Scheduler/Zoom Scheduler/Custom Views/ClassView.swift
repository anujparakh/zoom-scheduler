//
//  ClassView.swift
//  Zoom Scheduler
//
//  Created by Anuj Parakh on 3/7/21.
//

import Cocoa

class ClassView: NSView, LoadableView
{
    @IBOutlet weak var classLabel: NSTextField!
    @IBOutlet weak var linkButton: NSButton!
    @IBOutlet weak var centerHeightConstraint: NSLayoutConstraint!
    
    var linkToCopy: String! = ""
    @IBAction func linkButtonClicked(_ sender: NSButton)
    {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([.string], owner: nil)
        pasteboard.setString(linkToCopy, forType: .string)
    }
    
    override init(frame frameRect: NSRect)
    {
        super.init(frame: frameRect)
        _ = load(fromNIBNamed: "ClassView")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}
