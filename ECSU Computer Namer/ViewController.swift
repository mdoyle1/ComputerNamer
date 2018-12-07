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
var checked = NSControl.StateValue(rawValue: 1)
var unchecked = NSControl.StateValue(rawValue: 0)


// Last 6 of computer serial #
let serialEnd = serialNumber.endIndex
let serialStart = serialNumber.index(serialEnd, offsetBy: -6)
let range = Range(uncheckedBounds: (lower: serialStart, upper: serialEnd))
let lastSix = serialNumber[range]


//Buildings and Departments

var buildingTable = [
    "Communication Building": "COMM-",
    "Center for Early Childhood Ed.": "CECE-",
    "Fine Arts Instructional Center": "FAIC-",
    "J. Eugene Smith Library": "LIB-",
    "Science Building": "SB-",
    "Sports Center": "SPRT-",
    "Webb Hall": "WEBB-",
    "Burnap Hall": "BURN-",
    "Burr Hall": "BURR-",
    "Constitution Hall": "CONS-",
    "Crandall Hall": "CRAN-",
    "High Rise": "HRIS-",
    "Laurel Hall": "LAUR-",
    "Mead Hall": "MEAD-",
    "Niejadik Hall": "NEI-",
    "Noble Hall": "NOBL-",
    "Nutmeg Hall": "NUTM-",
    "Occum Hall": "OCCUM-",
    "Winthrop Hall": "WIN-"
]

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


//Total # of Departments and buildings...
let departmentCount = departmentTable.count
let buildingCount = buildingTable.count


//Set Departments and Buildings to an array
let departmentKeys = Array(departmentTable.keys)
let buildingKeys = Array(buildingTable.keys)


//Sort the Array in alphabetical order
let departSorted = departmentKeys.sorted { $0 < $1 }
let buildingSorted = buildingKeys.sorted { $0 < $1 }


class ViewController: NSViewController {
    
    //Checkboxes
    @IBOutlet weak var chkFacultyStaff: NSButton!
    @IBOutlet weak var chkStudentWorker: NSButton!
    @IBOutlet weak var chkLab: NSButton!
    @IBOutlet weak var chkOther: NSButton!

    
    //Labels
    @IBOutlet weak var buildingLabel: NSTextField!
    @IBOutlet weak var departmentLBL: NSTextField!
    @IBOutlet weak var computerNumLBL: NSTextField!
    @IBOutlet weak var roomNumberLBL: NSTextField!
    
    
    //Pop-up Menus
    @IBOutlet weak var departPopUp: NSPopUpButton!
    @IBOutlet weak var departOptions: NSPopUpButton!
    @IBOutlet weak var buildingPopUp: NSPopUpButton!

    //Text Fields
    @IBOutlet weak var computerName: NSTextField!
    @IBOutlet weak var compNumberField: NSTextField!
    @IBOutlet weak var roomNumberFLD: NSTextField!
    
    
    
    //Text Field Returns
    @IBAction func computerNumber(_ sender: NSTextField) {
        //submit current building and roomNumber
        let prefix = buildingTable[buildingPopUp.titleOfSelectedItem!]
        computerName.stringValue = "ELAB"+prefix!+compNumberField.stringValue
    }
    
    @IBAction func roomNumRTN(_ sender: NSTextField) {
        //submit current building and computerNumber
        
        let prefix = buildingTable[buildingPopUp.titleOfSelectedItem!]
        let modPrefix = prefix!.dropLast()
        let roomNum = roomNumberFLD.stringValue+"-"
       
        computerName.stringValue = "ELAB"+modPrefix+roomNum+compNumberField.stringValue
    }
    
    
    
    //Global Functions
    func clearName() {
        computerName.stringValue = ""
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Add items to Pop-up menus
        for department in departSorted {
            departOptions.addItems(withTitles: ["\(department)"] )
        }
        
        for building in buildingSorted {
            buildingPopUp.addItems(withTitles: ["\(building)"])
        }
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    
    //Faculty Staff Check Box
    @IBAction func facultyStaffFunc(_ sender: NSButton) {
        
        setPre = "E"
        
        if chkFacultyStaff.state == NSControl.StateValue(rawValue: 1){
            clearName()
            departmentLBL.isHidden = false
            departPopUp.isHidden = false
            buildingLabel.isHidden = true
            buildingPopUp.isHidden = true
            computerNumLBL.isHidden = true
            compNumberField.isHidden = true
            roomNumberFLD.isHidden = true
            roomNumberLBL.isHidden = true
            chkLab.state = unchecked
            chkStudentWorker.state = unchecked
            chkOther.state = unchecked
            
        } else {
            buildingLabel.isHidden = false
        }
    }
    
    
    
    
    
    
    //Student Worker Check Box
    @IBAction func studentWorkFunc(_ sender: NSButton) {
        
        
        setPre = "EDF"
        
        if chkStudentWorker.state == checked {
            clearName()
            buildingPopUp.isHidden = true
            departPopUp.isHidden = false
            departmentLBL.isHidden = false
            compNumberField.isHidden = true
            computerNumLBL.isHidden = true
            buildingLabel.isHidden = true
            buildingPopUp.isHidden = true
            roomNumberFLD.isHidden = true
            roomNumberLBL.isHidden = true
            chkFacultyStaff.state = unchecked
            chkLab.state = unchecked
            chkOther.state = unchecked
        }
    }
    
    
    
    
    
    
    
    //Lab Check Box
    @IBAction func labFunc(_ sender: NSButton) {
        
        
        setPre = "ELAB"
        
        
        if chkLab.state == checked {
            clearName()
            departPopUp.isHidden = true
            buildingLabel.isHidden = false
            departmentLBL.isHidden = true
            buildingPopUp.isHidden = false
            compNumberField.isHidden = false
            computerNumLBL.isHidden = false
            roomNumberFLD.isHidden = false
            roomNumberLBL.isHidden = false
            chkFacultyStaff.state = unchecked
            chkStudentWorker.state = unchecked
            chkOther.state = unchecked
        }
    }
    
    
    //Building Labs and Res Hall Pop Up Button
    @IBAction func buildingLabs(_ sender: NSPopUpButton) {
        clearName()
        let compNum = compNumberField.stringValue
        let buildingSelect = buildingPopUp.titleOfSelectedItem
        let split = buildingSelect!.split(separator: " ")
        let checkForHall = String(split.suffix(1).joined(separator: [" "]))
        print(checkForHall)
        
        if checkForHall == "Hall" {
            let prefix = buildingTable[buildingPopUp.titleOfSelectedItem!]
            print(prefix![prefix!.startIndex])
            roomNumberFLD.isHidden = true
            roomNumberLBL.isHidden = true
            computerName.stringValue = (setPre+prefix!+compNum)
            
        }else{
            
                let prefix = buildingTable[buildingPopUp.titleOfSelectedItem!]
                let modPrefix = prefix!.dropLast()
                roomNumberFLD.isHidden = false
                roomNumberLBL.isHidden = false
                let roomNum = roomNumberFLD.stringValue+"-"
                computerName.stringValue = (setPre+modPrefix+roomNum+compNum)
        }
        
        
    }
    

    
    
    
    
    
    //Department Selection Pop Up Button
    @IBAction func departSelect(_ sender: NSPopUpButton) {
       // var department = departOptions.titleOfSelectedItem
        let prefix = departmentTable[departOptions.titleOfSelectedItem!]
       
        computerName.stringValue = (setPre+prefix!+lastSix )
        print (prefix as Any)
    }
    
    
    
    //Set Computer Name!!
    @IBOutlet weak var nameProgress: NSProgressIndicator!
    @IBAction func setCompName(_ sender: NSButton) {
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

