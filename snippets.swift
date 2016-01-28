

/// app6 ///
    @IBOutlet weak var outSlider: UISlider!
    
    @IBOutlet weak var outTableView: UITableView!
    
    @IBAction func actSlider(sender: AnyObject) {
        outTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let timesTable = Int(outSlider.value * 20)
        cell.textLabel?.text = String(timesTable * (indexPath.row + 1))
        return cell
    }





/// app7 ///
	NSUserDefaults.standardUserDefaults().setObject("Heeki", forKey: "name")
	let userName = NSUserDefaults.standardUserDefaults().objectForKey("name")! as! String
	print(userName)


    let array = [1, 2, 3, 4]
    NSUserDefaults.standardUserDefaults().setObject(array, forKey: "array")
    let retArray = NSUserDefaults.standardUserDefaults().objectForKey("array")! as! NSArray
    for x in retArray {
        print(x)
    }




//// app8 ///
override func touchesBegan(touches: NSSet, withEvent event: UIEvent?) {
	self.view.endEditing(true)
}

func textFieldShouldReturn(textField: UITextField!) --> Bool {
	textField.resignFirstResponder()
	return true
}