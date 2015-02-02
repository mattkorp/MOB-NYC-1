//
//  ViewController.swift
//  Lesson04
//
//
//TODO one: Add a table view AND a text input box to this view controller, either in code or via the storyboard. Accept keyboard input from the text view when the return key is pressed. Add the string that was entered into the text view into an array of strings (stored in this class).
//
//TODO two: Make this class a UITableViewDelegate and UITableViewDataSource that supply the above table view with cells. These cells should correspond to the text entered into the text box. E.g. If the text "one", then "two", then "three" was entered into the text box, there should be three cells in this table view that contain those strings in order.
//

import UIKit

class ArrayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // make map a property so it persists
    private var mapViewController = MapViewController()
    // data class for reading & saving to plist
    private var fileManager = ArrayData()
    private var tableView = UITableView()
    // cell data array
    private var tableArray = [String]()
    private var userInputField = UITextField()
    // to swipe to MapVC
    private let swipeGesture = UISwipeGestureRecognizer()

    private var minX = CGFloat()
    private var minY = CGFloat()
    private var width = CGFloat()
    private var height = CGFloat()
    private var rowHeight: CGFloat = 40
    private var backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
    
    // MARK: View
    
    init(frame: CGRect) {
        super.init(nibName: nil, bundle: nil)
        
        minX = frame.minX
        minY = frame.minY
        width = frame.width
        height = frame.height
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dataIn = fileManager.readData() {
            self.tableArray = dataIn
        }
        setupNavBar()
        setupTableView()
        setupTextField()
        setupSwipeToMap()
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }
    
    // MARK: NavBar
    
    private func setupNavBar() {
        let nextBarButton = UIBarButtonItem(title: "Map", style: .Plain, target: self, action: "pushMapViewController")
        self.navigationItem.rightBarButtonItem = nextBarButton
        let saveBarButton = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "saveToPlist")
        self.navigationItem.leftBarButtonItem = saveBarButton
        self.navigationItem.title = "Array"
    }
    
    internal func pushMapViewController() {
        // TODO: Is this the best way to get Orientation?
        var frame = CGRect()
        var orientation = UIDevice.currentDevice().orientation
        if UIDeviceOrientationIsPortrait(orientation) {
            frame = CGRect(x: minX, y: minY, width: width, height: height)
        } else if UIDeviceOrientationIsLandscape(orientation) {
            frame = CGRect(x: minX, y: minY, width: height, height: width)
        }
        mapViewController.setFrame(frame)
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    internal func saveToPlist() {
        if let success = fileManager.writeData(tableArray) {
            UIAlertView(
                title: "Success!",
                message: "Table Data Saved To File",
                delegate: self,
                cancelButtonTitle: ":)")
                .show()
        } else {
            UIAlertView(
                title: "Error!",
                message: "Cannot Save Array Data",
                delegate: self,
                cancelButtonTitle: ":(")
                .show()
        }
    }
    
    private func setupSwipeToMap() {
        swipeGesture.addTarget(self, action: "pushMapViewController")
        swipeGesture.direction = .Left
        tableView.addGestureRecognizer(swipeGesture)
        tableView.userInteractionEnabled = true
    }
    
    // MARK: TextField
    
    private func setupTextField() {
        userInputField = UITextField(frame: CGRectMake(0, 0, width, rowHeight))
        userInputField.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        userInputField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        userInputField.backgroundColor = UIColor.lightGrayColor()
        userInputField.layer.cornerRadius = 10
        userInputField.placeholder = " Enter Something.."
        userInputField.delegate = self
        tableView.tableHeaderView?.addSubview(userInputField)
    }
    
    internal func textFieldShouldReturn(textField: UITextField) -> Bool {
        tableArray.append(userInputField.text)
        userInputField.text = ""
        userInputField.resignFirstResponder()
        tableView.reloadData()
        return true
    }
    
    // MARK: TableView Management
    
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: minX, y: minY, width: width, height: height))
        tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, width, rowHeight))
        tableView.autoresizingMask = (UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight)
        tableView.rowHeight = rowHeight
        tableView.backgroundColor = backgroundColor
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }

    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Array") as? UITableViewCell ?? UITableViewCell(style: .Default, reuseIdentifier: "Array")
        let row = indexPath.row
        cell.textLabel?.text = tableArray[indexPath.row]
        cell.backgroundColor = backgroundColor
        cell.textLabel?.textColor = UIColor.whiteColor()
        return cell
    }

    internal func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.superview?.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    internal func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            tableArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}

