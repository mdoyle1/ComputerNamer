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
    @IBOutlet weak var scenarioLBL: NSTextField!
    
    
    //Pop-up Menus
    @IBOutlet weak var departPopUp: NSPopUpButton!
    @IBOutlet weak var departOptions: NSPopUpButton!
    @IBOutlet weak var buildingPopUp: NSPopUpButton!
    @IBOutlet weak var scenarioPopUp: NSPopUpButton!
    
    //Text Fields
    @IBOutlet weak var computerName: NSTextField!
    @IBOutlet weak var compNumberField: NSTextField!
    @IBOutlet weak var roomNumberFLD: NSTextField!
    
    
    
    //Text Field Returns
    @IBAction func computerNumber(_ sender: NSTextField) {
       
        if chkLab.state == checked {
        let compNum: String? = compNumberField.stringValue
        let roomNum: String? = roomNumberFLD.stringValue+"-"
        let prefix: String? = buildingTable[buildingPopUp.titleOfSelectedItem!]
        if prefix != nil {
            let modPrefix = prefix!.dropLast()
            if modPrefix != nil {
                computerName.stringValue = "ELAB"+modPrefix+roomNum!+compNum!
                }
            }
        }
        
            //Check Other State
        else{
            if chkOther.state == checked {
                let compNum: String? = compNumberField.stringValue
                //submit current building and roomNumber
                let prefix: String? = departmentTable[departOptions.titleOfSelectedItem!]
                if prefix != nil {
                    let modPrefix = prefix!.dropLast()
                    if modPrefix != nil {
                        computerName.stringValue = "EADJ"+modPrefix+"-"+compNum!
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func roomNumRTN(_ sender: NSTextField) {
        //submit current building and computerNumber
        let compNum: String? = compNumberField.stringValue
        let roomNum: String? = roomNumberFLD.stringValue+"-"
        let prefix: String? = buildingTable[buildingPopUp.titleOfSelectedItem!]
        if prefix != nil {
             let modPrefix = prefix!.dropLast()
             if modPrefix != nil {
                
                if chkOther.state == checked && scenarioPopUp.titleOfSelectedItem == "Classroom Lectern" {
                    computerName.stringValue = "ELAB"+prefix!+roomNum!.dropLast()
                }else{
                    computerName.stringValue = "ELAB"+modPrefix+roomNum!+compNum!
                    
                }
            }
        }
    }
    
    
    
    //Global Functions
    func clearName() {
        computerName.stringValue = ""
    }
    
    
    func otherElements() {
        scenarioPopUp.isHidden = false
        scenarioLBL.isHidden = false
        roomNumberFLD.isHidden = true
        roomNumberLBL.isHidden = true
        computerNumLBL.isHidden = true
        compNumberField.isHidden = true
        buildingLabel.isHidden = true
        buildingPopUp.isHidden = true
        departmentLBL.isHidden = true
        departPopUp.isHidden = true
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
         departPopUp.selectItem(at: 0)
        compNumberField.stringValue = ""
        
        clearName()
        
        if chkFacultyStaff.state == checked{
            clearName()
            departPopUp.selectItem(at: 0)
            departmentLBL.isHidden = false
            departPopUp.isHidden = false
            buildingLabel.isHidden = true
            buildingPopUp.isHidden = true
            computerNumLBL.isHidden = true
            compNumberField.isHidden = true
            roomNumberFLD.isHidden = true
            roomNumberLBL.isHidden = true
            scenarioPopUp.isHidden = true
            scenarioLBL.isHidden = true
            
            chkLab.state = unchecked
            chkStudentWorker.state = unchecked
            chkOther.state = unchecked
        }
    }
    
    
    //Student Worker Check Box
    @IBAction func studentWorkFunc(_ sender: NSButton) {
        
        clearName()
        departPopUp.selectItem(at: 0)
        compNumberField.stringValue = ""
        setPre = "EDF"
        
        if chkStudentWorker.state == checked{
            clearName()
            departPopUp.selectItem(at: 0)
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
            scenarioPopUp.isHidden = true
            scenarioLBL.isHidden = true
        }
    }
    
    
    //Lab Check Box
    @IBAction func labFunc(_ sender: NSButton) {
        setPre = "ELAB"
        compNumberField.stringValue = ""
        roomNumberFLD.stringValue = ""
        buildingPopUp.selectItem(at: 0)
        if chkLab.state == checked {
            clearName()
            buildingPopUp.selectItem(at: 0)
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
            scenarioPopUp.isHidden = true
            scenarioLBL.isHidden = true
        }
    }
    
    
    //Other Check Box
    @IBAction func chkOther(_ sender: NSButton) {
        clearName()
        compNumberField.stringValue = ""
        roomNumberFLD.stringValue = ""
        computerName.stringValue=""
        scenarioPopUp.selectItem(at: 0)
        if chkOther.state == checked {
            clearName()
            otherElements()
            chkFacultyStaff.state = unchecked
            chkStudentWorker.state = unchecked
            chkLab.state = unchecked
        }
    }
    
    

    //Department Selection Pop Up Button
    @IBAction func departSelect(_ sender: NSPopUpButton) {
        clearName()
        let prefix = departmentTable[departOptions.titleOfSelectedItem!]
        
        if chkFacultyStaff.state == checked  || chkStudentWorker.state == checked || chkLab.state == checked {
            if prefix != nil {
                computerName.stringValue = (setPre+prefix!+lastSix)}
          
        }else {
            if chkOther.state == checked && scenarioPopUp.titleOfSelectedItem == "Adjunct Shared Mac"{
                if prefix != nil {
                    computerName.stringValue = "EADJ"+prefix!+"-"+compNumberField.stringValue }
            }else {
                if chkOther.state == checked && scenarioPopUp.titleOfSelectedItem == "Student Laptop"{
                    if prefix != nil {
                        computerName.stringValue = "EDF"+prefix!+lastSix }
                }
            }
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
        print(buildingPopUp.titleOfSelectedItem)
        
        let ecsuResHalls = ["Burnap Hall", "Burr Hall", "Constitution Hall", "Crandall Hall", "High Rise", "Laurel Hall", "Mead Hall", "Niejadik Hall", "Noble Hall", "Nutmeg Hall", "Occum Hall", "Winthrop Hall"]
      
        for ecsuResHall in ecsuResHalls {
            print(ecsuResHall)
        }
        var resHallCount = ecsuResHalls.count
        print(resHallCount)
        
        
        for ecsuResHall in ecsuResHalls {
        if buildingPopUp.titleOfSelectedItem == ecsuResHall {
            let prefix = buildingTable[buildingPopUp.titleOfSelectedItem!]
            print(prefix![prefix!.startIndex])
            roomNumberFLD.isHidden = true
            roomNumberLBL.isHidden = true
            computerName.stringValue = (setPre+prefix!+compNum)
            
        }
            else{
            print(ecsuResHall)
                let prefix = buildingTable[buildingPopUp.titleOfSelectedItem!]
                let modPrefix = prefix!.dropLast()
                roomNumberFLD.isHidden = false
                roomNumberLBL.isHidden = false
                let roomNum = roomNumberFLD.stringValue+"-"
                computerName.stringValue = (setPre+modPrefix+roomNum+compNum)
                }
        }
        if chkOther.state == checked && scenarioPopUp.titleOfSelectedItem == "Classroom Lectern" {
            let prefix = buildingTable[buildingPopUp.titleOfSelectedItem!]
            let modPrefix = prefix!.dropLast()
            let roomNum = roomNumberFLD.stringValue
            computerName.stringValue = "ELECT"+modPrefix+"-"+roomNum
        }
        
    }
    

//Scenario Pop-Up Button
    @IBAction func scenarioPopUp(_ sender: NSPopUpButton) {
        
        if scenarioPopUp.titleOfSelectedItem == "Select a Scenario..."{
      clearName()
      otherElements()
        }else {
        clearName()
        if scenarioPopUp.titleOfSelectedItem == "Adjunct Shared Mac" {
            clearName()
            setPre = "EADJ"
            let compNum = compNumberField.stringValue
            computerNumLBL.isHidden = false
            compNumberField.isHidden = false
            departPopUp.isHidden = false
            departmentLBL.isHidden = false
            buildingLabel.isHidden = true
            buildingPopUp.isHidden = true
            roomNumberFLD.isHidden = true
            roomNumberLBL.isHidden = true
        } else {
            if scenarioPopUp.titleOfSelectedItem == "Classroom Lectern" {
                setPre = "ELECT"
                clearName()
                computerNumLBL.isHidden = true
                compNumberField.isHidden = true
                roomNumberFLD.isHidden = false
                roomNumberLBL.isHidden = false
                departPopUp.isHidden = true
                departmentLBL.isHidden = true
                buildingLabel.isHidden = false
                buildingPopUp.isHidden = false
                
            } else {
                
                if scenarioPopUp.titleOfSelectedItem == "Emergency Cart Mac" {
                    clearName()
                    computerNumLBL.isHidden = true
                    compNumberField.isHidden = true
                    roomNumberFLD.isHidden = true
                    roomNumberLBL.isHidden = true
                    departPopUp.isHidden = true
                    departmentLBL.isHidden = true
                    buildingLabel.isHidden = true
                    buildingPopUp.isHidden = true
                    computerName.stringValue = "EDFCART"+lastSix
                } else {
                    if scenarioPopUp.titleOfSelectedItem == "Student Laptop" {
                        clearName()
                        computerNumLBL.isHidden = true
                        compNumberField.isHidden = true
                        roomNumberFLD.isHidden = true
                        roomNumberLBL.isHidden = true
                        departPopUp.isHidden = false
                        departmentLBL.isHidden = false
                        buildingLabel.isHidden = true
                        buildingPopUp.isHidden = true
                        computerName.stringValue = "EDF"+lastSix
                    }
                }
            }
            }
            
        }
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

