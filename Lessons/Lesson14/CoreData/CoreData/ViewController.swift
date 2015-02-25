//
//  ViewController.swift
//  CoreData
//
//  Created by Rudd Taylor on 2/23/15.
//  Copyright (c) 2015 ga. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let moc = appDelegate.managedObjectContext {
            let animal = NSEntityDescription.insertNewObjectForEntityForName("Animal", inManagedObjectContext: moc) as Animal
            animal.name = "Rabbit"
            println(animal)
            appDelegate.saveContext()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if let moc = appDelegate.managedObjectContext {
            let fetch = NSFetchRequest(entityName: "Animal")
            var error: NSError?
            if let animals: [Animal] = moc.executeFetchRequest(fetch, error: &error) as? [Animal] {
                for animal in animals {
                    println(animal.name)
                }
            }
            println(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

