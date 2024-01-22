//
//  CoreDataManager.swift
//  RightNowMemo
//
//  Created by 김성호 on 2022/10/18.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "MemoData"
    
    // MARK: [Read]
    func getDataFromCoreData() -> [MemoData] {
        var data: [MemoData] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                if let fetchedData = try context.fetch(request) as? [MemoData] {
                    data = fetchedData
                }
            } catch {
                print("데이터를 가져오는데 실패함.")
            }
        }
        return data
    }
    
    
    
    // MARK: [Create]
    func saveData(memoText: String?, completion: @escaping() -> Void) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                if let data = NSManagedObject(entity: entity, insertInto: context) as? MemoData {
                    
                    data.date = Date()
                    data.memoText = memoText
                    
                    appDelegate?.saveContext()
                }
            }
        }
    }
    
    // MARK: [Delete]
    func deleteData(data: MemoData, completion: @escaping() -> Void) {
        guard let date = data.date else {
            completion()
            return
        }
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                if let fetchedData = try context.fetch(request) as? [MemoData] {
                    if let targetMemo = fetchedData.first {
                        context.delete(targetMemo)
                        
                        appDelegate?.saveContext()
                    }
                }
            } catch {
                print("삭제 실패")
            }
        }
    }
    
    // MARK: [Update]
    
    func updateData(newData: MemoData, completion: @escaping() -> Void) {
        guard let date = newData.date else {
            completion()
            return
        }
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                if let fetchedData = try context.fetch(request) as? [MemoData] {
                    if var targetMemo = fetchedData.first {
                        targetMemo = newData
                        
                        appDelegate?.saveContext()
                    }
                }
            } catch {
                print("업데이트 실패")
            }
        }
    }
    
    
}
