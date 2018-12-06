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
    "School of Educ & Prof Studies": "EPRF",
    "Financial Aid": "FAID",
    "Facilities": "FCIL",
    "Fine Arts": "FIAR",
    "Food Service": "FOOD",
    "Fiscal Affairs": "FSCL",
    "Graduate School": "GRAD",
    "History": "HIST",
    "Kinesiology and Physical Educ": "HLPE",
    "Honors Department": "HONR",
    "Housing":    "HOUS",
    "Human Resources ": "HRES",
    "Health Sciences": "HSCI",
    "Health Services": "HSVS",
    "Institutional Advancement": "IADV",
    "Intercultural": "ICCT",
    "Institute for Sustainable Energy": "IFSE",
    "Institutional Research": "IRES",
    "ITS- (other than Banner Team)": "ITSA",
    "Info Tech Services - Banner Team": "ITSB",
    "Judicial": "JDSV",
    "Lecterns": "LECT",
    "Learning Center ": "LERN",
    "Library": "LIBR",
    "Mathematics": "MATH",
    "Media Services": "MSVC",
    "Performing Arts": "PART",
    "Professional Development": "PDEV",
    "Physical Science": "PHSC",
    "Police Dept.": "PLDP",
    "PoliSci, Philosophy, & Geog": "POLI",
    "Presidents Office": "PRES",
    "Psychological Science": "PSYC",
    "Registrar Office": "REGS",
    "ROTC, UConn": "ROTC",
    "Student Activities": "SACT",
    "Sociology, Anthro & Social Wk": "SOCI",
    "Student Affairs": "STAF",
    "University Relations": "UNRL",
    "Art and Art History": "VART",
    "Veterans Affairs": "VETN",
    "Womens Center": "WNCT",
    "World Language and Cultures": "WOLC"
]
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
        
        //Total # of Departments
        let departmentCount = departmentTable.count
        
        //Set Departments to an array
        let departmentKeys = Array(departmentTable.keys)
       //Sort the Array in alphabetical order
        let departSorted = departmentKeys.sorted { $0 < $1 }
        
        print(departSorted[0])
        print(departmentCount)
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    
    //Department Selection Pop Up Button
    @IBOutlet weak var departOptions: NSPopUpButton!
   
   
    
    @IBOutlet weak var computerName: NSTextField!
    
    @IBAction func departSelect(_ sender: NSPopUpButton) {
        
        departOptions.addItems(withTitles: ["\(departmentTable)"])
        
        var department = departOptions.titleOfSelectedItem
        let prefix = departmentTable[departOptions.titleOfSelectedItem!]
        let serialEnd = serialNumber.endIndex
        let serialStart = serialNumber.index(serialEnd, offsetBy: -6)
        let range = Range(uncheckedBounds: (lower: serialStart, upper: serialEnd))
        let lastSix = serialNumber[range]
        computerName.stringValue = (setPre+prefix!+lastSix ?? nil)!
        print (prefix)
    }
    
    
    
    
    @IBOutlet weak var nameProgress: NSProgressIndicator!
    @IBAction func setCompName(_ sender: NSButton) {
        
       
        /*
        let path = "/usr/bin"
        let compName = computerName.stringValue
        let arguments = ["sudo", "jamf", "setcomputername", "-name", compName]
       
        sender.isEnabled = false
        nameProgress.startAnimation(self)
        let task = Process.launchedProcess(launchPath: path, arguments: arguments )
        task.waitUntilExit()
        sender.isEnabled = true
        nameProgress.stopAnimation(self)
        */
        
        let compName = computerName.stringValue
        
        func nameComputer () {
            sender.isEnabled = false
            nameProgress.startAnimation(self)
            NSAppleScript(source: "do shell script \"/usr/local/bin/jamf setcomputername -name \(compName)\" with administrator "+"privileges")!.executeAndReturnError(nil)
        }

        nameComputer()
        sender.isEnabled = true
        nameProgress.stopAnimation(self)
        
    }
    
    
    

}

