//
//  ViewController.swift
//  ECSU Computer Namer
//
//  Created by Doyle, Mark(Information Technology Services) on 12/3/18.
//  Copyright © 2018 Doyle, Mark(Information Technology Services). All rights reserved.
//

import Cocoa


//Serial #
let platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice") )
let serialNumber = (IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0).takeUnretainedValue()).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

//Eastern Naming Catagories

var facultyStaff = "E"
var studentWorker = "EDF"
var lab = "ELAB"
var other = ""
var setPre = "E"

//Departments
var departmentTable = [
    "Accessability": "ACCS",
    "Accounting": "ACCT",
    "Academic Affairs": "ADAF",
    "Admissions": "ADMN",
    "Advising Center": "ADVC",
    "School of Arts & Sciences": "ASCI",
    "Athletics": "ATHL",
    "Biology": "BIOL",
    "Book Store": "BOOK",
    "Business Administration": "BUAD",
    "Card Services": "CARD",
    "Media Carts": "CART",
    "Center Early Childhood Educ": "CECE",
    "School of Continuing Education": "CEDU",
    "Child & Family Development Ctr": "CFDC",
    "Communication": "COMM",
    "Counseling & Psycholocial Svcs": "COUN",
    "Economics": "ECON",
    "Education": "EDUC",
    "English": "ENGL",
    "Environmental Earth Science": "ENVS",
    "School of Educ & Prof Studies": "EPRF"]

class ViewController: NSViewController {
    
    //Checkboxes
    @IBOutlet weak var chkFacultyStaff: NSButton!
    @IBOutlet weak var chkStudentWorker: NSButton!
    @IBOutlet weak var chkLab: NSButton!
    @IBOutlet weak var chkOther: NSButton!
    
    //Labels
    @IBOutlet weak var buildingLabel: NSTextField!
    @IBOutlet weak var departmentLBL: NSTextField!
    
    //Pop-up Menus
    
    @IBOutlet weak var departPopUp: NSPopUpButton!
    
    //Actions
    
    
    //Faculty Staff
    @IBAction func facultyStaffFunc(_ sender: NSButton) {
        
        setPre = "E"
        
        if chkFacultyStaff.state == NSControl.StateValue(rawValue: 1){
            //Show
            departmentLBL.isHidden = false
            departPopUp.isHidden = false
            
            //Hide
            buildingLabel.isHidden = true
            
        } else {
            buildingLabel.isHidden = false
        }
        
        
    }
    
    //Student Worker
    @IBAction func studentWorkFunc(_ sender: NSButton) {
        
        setPre = "EDF"
        
        if chkStudentWorker.state == NSControl.StateValue(rawValue: 1){
            departPopUp.isHidden = false
            departmentLBL.isHidden = false
            chkFacultyStaff.state = NSControl.StateValue(rawValue: 0)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBOutlet weak var departOptions: NSPopUpButton!
    @IBOutlet weak var computerName: NSTextField!
    
    @IBAction func departSelect(_ sender: NSPopUpButton) {
        var department = departOptions.titleOfSelectedItem
        let prefix = departmentTable[departOptions.titleOfSelectedItem!]
        let serialEnd = serialNumber.endIndex
        let serialStart = serialNumber.index(serialEnd, offsetBy: -6)
        let range = Range(uncheckedBounds: (lower: serialStart, upper: serialEnd))
        let lastSix = serialNumber[range]
        computerName.stringValue = (setPre+prefix!+lastSix ?? nil)!
        print (prefix)
    }
    


}

