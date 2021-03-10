//
//  AppDelegate.swift
//  Zoom Scheduler
//
//  Created by Anuj Parakh on 3/7/21.
//

import Cocoa
import HotKey

@main
class AppDelegate: NSObject, NSApplicationDelegate
{
    // MARK:- IBOutlets and Actions
    @IBOutlet weak var mainMenu: NSMenu?
    @IBOutlet weak var startClassItem: NSMenuItem?
    @IBOutlet weak var classViewItem: NSMenuItem?

    @IBAction func clickedStartClass(_ sender: NSMenuItem?)
    {
        // Find the right class and start it here
        if let currentClass = classSchedule.getCurrentClass()
        {
            currentClass.startClass()
        }

    }
    
    // MARK:- Members
    var appStatusItem: NSStatusItem!
    var classSchedule: ClassSchedule = ClassSchedule()
    var classView: ClassView?
    var startClassHotKey: HotKey!
    
    // MARK:- Delegate and Overriden Functions
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    // Called once when app opens up
    override func awakeFromNib()
    {
        super.awakeFromNib()
        setupMenuBarItems()
        parseJSONFile()

        // Setup hot key for ⌥⌘R
        startClassHotKey = HotKey(key: .z, modifiers: [.command, .option])
        startClassHotKey.keyDownHandler = {
            if let currentClass = self.classSchedule.getCurrentClass()
            {
                currentClass.startClass()
            }
            else
            {
//                NSSound.beep()
            }
            
            print("test")
        }
        
    }
    
    
    // MARK:- Private Functions
    private func setupMenuBarItems()
    {
        // Get the menu bar status item
        appStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        // Set an image for it
        let menuItemImage = NSImage(named: "clock")!
        menuItemImage.isTemplate = true
        appStatusItem.button?.image = menuItemImage
        
        // Set the status menu as the app menu outlet
        appStatusItem.menu = mainMenu!
        mainMenu?.delegate = self
        mainMenu?.autoenablesItems = false
        
        if let item = classViewItem
        {
            classView = ClassView(frame: NSRect(x: 0, y: 0, width: 250, height: 150))
            item.view = classView
        }
        
        
        
    }
    
    private func parseJSONFile()
    {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                classSchedule.parseAllClasses(jsonResult)
                
            } catch {
                // handle error
            }
        }
        
    }
    
}

extension AppDelegate: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu)
    {
        // Enable/Disable the button
        if classSchedule.getCurrentClass() == nil
        {
            startClassItem?.isEnabled = false
        }
        else
        {
            startClassItem?.isEnabled = true
        }
        
        // Show current class
        if let currentClass = classSchedule.getCurrentClass()
        {
            classView?.classLabel.stringValue = currentClass.codeName
            classView?.linkButton.isHidden = false
            classView?.linkToCopy = currentClass.link
            classView?.centerHeightConstraint.constant = -20
        }
        else
        {
            classView?.classLabel.stringValue = "No class!"
            classView?.linkButton.isHidden = true
            classView?.centerHeightConstraint.constant = 0

        }
    }
 
 
    func menuDidClose(_ menu: NSMenu)
    {
        
    }
}

