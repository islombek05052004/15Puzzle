//
//  CoreDataFunc.swift
//  15Puzzle_1_1
//
//  Created by Abdurazzoqov Islombek on 07/06/23.
//


import UIKit
 
class CoreDataFunc {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllItem() -> [Record] {
        do {
            let recordsArr = try context.fetch(Record.fetchRequest())
            return recordsArr
        }
        catch {
            return [Record]()
        }
    }
    func createItem(_ nameGamer: String, _ steps: Int32) {
        let record = Record(context: context)
        record.nameGamer = nameGamer
        record.steps = steps
        do {
            try context.save()
        }
        catch {
        }
    }
    func deleteAll(_ itemArr: [Record]) {
        for item in itemArr {
            context.delete(item)
        }
        do {
            try context.save()
        }
        catch {
        }
    }
    
}
