import CoreData
class CoreDataManager {
    
    //1
    static let sharedManager = CoreDataManager()
    private init() {} // Prevent clients from creating another instance.
    
    //2
    lazy var persistentContainer: NSPersistentContainer = {
        
        
        //Ghana_Business_Consultation.xcdatamodel
        let container = NSPersistentContainer(name: "Ghana_Business_Consultation")
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
	
//	lazy var context = persistantContainer.viewContext
	
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var clause_id: String?
    var clause_title: String?
    var clause_section: String?
    var clause_details: String?
    var clause_summary: String?
    var clause_procedure: String?
    var clause_form: String?
    var clause_fee: String?
    var clause_penalty: String?
    var sector_id: String?
    var sector_name: String?
    var subject_name: String?
    
    func isEntityAttributeExist(id: String, entityName: String) -> Bool {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "clause_id == %@", id)

        let res = try! managedContext.fetch(fetchRequest)
        return res.count > 0 ? true : false
    }
    
    func fetchAllClauses(callback: (_ error: NSError?, _ result: [FavoritedClause]?)-> Void) -> Void {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
         let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoritedClause")
         do {
            let consults = try managedContext.fetch(fetchRequest)
            callback(nil, consults as? [FavoritedClause])
            return
         } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            callback(error, nil)
            return
         }
    }
    
    func fetchClause(uid: String, callback: (_ error: NSError?, _ result: FavoritedClause?) -> Void) -> Void{
            let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "OldConsultations")
            fetchRequest.predicate = NSPredicate(format: "clause_id == %@" ,uid as String)
            
            do {
                let item = try managedContext.fetch(fetchRequest)
                for i in item {
                    callback(nil, (i as? FavoritedClause)!)
                    return
                }
            } catch let error as NSError {
                callback(error, nil)
                return
            }
        }
    
    func saveClause(clause_id: String, clause_title: String, clause_section: String, clause_details: String,clause_summary: String, clause_procedure: String, clause_form: String, clause_penalty: String,sector_id: String, sector_name: String, subject_name: String, date_added: Date, clause_fee: String, callback: (_ error: NSError?, _ result: Bool?) -> Void) -> Void{
            let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
            if !isEntityAttributeExist(id: clause_id, entityName: "FavoritedClause") {
                let clause = FavoritedClause(context: managedContext)
                clause.clause_id = clause_id
                clause.clause_details = clause_details
                clause.clause_fee = clause_fee
                clause.clause_form = clause_form
                clause.clause_title = clause_title
                clause.clause_penalty = clause_penalty
                clause.clause_section = clause_section
                clause.sector_id = sector_id
                clause.date_added = date_added
                clause.sector_name = sector_name
                clause.subject_name = subject_name
                clause.clause_procedure = clause_procedure
                clause.clause_summary = clause_summary
                
                do {
                    try managedContext.save()
                    callback(nil, true)
                    return
                } catch let error as NSError {
                    print("Could not fetch. \(error), \(error.userInfo)")
                    callback(error, false)
                    return
                }
            }
            else{
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Already exists"])
                callback(error, false)
        }
        }
    
    
    
    
    
	func saveFileName(name: String?,url: String?, attach: String?) {
    
    
      let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        
        
        let documentProperties = DownloadedDocuments(context: managedContext)
           documentProperties.fileName = name
           documentProperties.fileURL = url
		documentProperties.onlineURL = attach
        
        
        do {
            try managedContext.save()
           
        } catch  {
           
        }
 
    }
	
	
	func delete(file: String, web: String, url: String) -> [DownloadedDocuments]? {
		/*get reference to appdelegate file*/
		
		
		/*get reference of managed object context*/
		let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
		
		/*init fetch request*/
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DownloadedDocuments")
		
		/*pass your condition with NSPredicate. We only want to delete those records which match our condition*/
		fetchRequest.predicate = NSPredicate(format: "fileName == %@" ,file)
		do {
			
			/*managedContext.fetch(fetchRequest) will return array of person objects [personObjects]*/
			let item = try managedContext.fetch(fetchRequest)
			var arrRemovedPeople = [DownloadedDocuments]()
			for i in item {
				
				/*call delete method(aManagedObjectInstance)*/
				/*here i is managed object instance*/
				i.setValue("", forKey: "fileName")
				i.setValue("", forKey: "fileURL")
//				managedContext.delete(i)
				
				/*finally save the contexts*/
				try managedContext.save()
				
				/*update your array also*/
				arrRemovedPeople.append(i as! DownloadedDocuments)
				print("delete successful.... hip hip hip hurray")
			}
			return arrRemovedPeople
			
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
			return nil
		}
		
	}
	
	
	func update(file: String, url: String, name: String) {
		/*get reference to appdelegate file*/
		
		
		/*get reference of managed object context*/
		let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
		
		/*init fetch request*/
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DownloadedDocuments")
		
		/*pass your condition with NSPredicate. We only want to delete those records which match our condition*/
		fetchRequest.predicate = NSPredicate(format: "onlineURL == %@" ,file)
		do {
			
			/*managedContext.fetch(fetchRequest) will return array of person objects [personObjects]*/
			let item = try managedContext.fetch(fetchRequest)
			for i in item {
				i.setValue(name, forKey: "fileName")
				i.setValue(url, forKey: "fileURL")
				/*finally save the contexts*/
				try managedContext.save()
				
				/*update your array also*/
				print("update successful.... hip hip hip hurray")
			}
			
			
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		
	}
    
    
    func getAllDocuments() -> [DownloadedDocuments]?  {

        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
       
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DownloadedDocuments")
        
       
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [DownloadedDocuments]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
	
	func update(name:String, url : String, webURL: String, docToUpdate: DownloadedDocuments) {
		
		
		let context = CoreDataManager.sharedManager.persistentContainer.viewContext
		
		do {
			
			
			docToUpdate.setValue(name, forKey: "fileName")
			docToUpdate.setValue(url, forKey: "fileURL")
		
			do {
				try context.save()
				print("saved!")
			} catch let error as NSError  {
				print("Could not save \(error), \(error.userInfo)")
			} catch {
				
			}
			
		} catch {
			print("Error with request: \(error)")
		}
	}
	

	
	func deleteAll(entityName: String) -> Error? {
		let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
		if #available(iOS 9.0, *) {
			do {
				let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
				let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
				try managedContext.execute(batchDeleteRequest)
			} catch {
				return error
			}
			return nil
		} else {
			let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
			fetchRequest.returnsObjectsAsFaults = false
			do
			{
				let results = try managedContext.fetch(fetchRequest)
				for managedObject in results
				{
					if let managedObjectData:NSManagedObject = managedObject as? NSManagedObject {
						managedContext.delete(managedObjectData)
					}
				}
			} catch  {
				return error
			}
			return nil
		}
	}
	
	
	var objectModel: NSManagedObjectModel? {
		if #available(iOS 10.0, *) {
			return persistentContainer.managedObjectModel
		} else {
			return persistentContainer.managedObjectModel
		}
	}
	
	
	open func clean() {
		if let models = objectModel?.entities {
			for entity in models {
				if let entityName = entity.name {
					_ = deleteAll(entityName: entityName)
				}
			}
		}
	}

        
        
    
    
    /**
     func insertPerson(name: String, ssn : Int16)->Person? {
     
     /*1.
     Before you can save or retrieve anything from your Core Data store, you first need to get your hands on an NSManagedObjectContext. You can consider a managed object context as an in-memory “scratchpad” for working with managed objects.
     Think of saving a new managed object to Core Data as a two-step process: first, you insert a new managed object into a managed object context; then, after you’re happy with your shiny new managed object, you “commit” the changes in your managed object context to save it to disk.
     Xcode has already generated a managed object context as part of the new project’s template. Remember, this only happens if you check the Use Core Data checkbox at the beginning. This default managed object context lives as a property of the NSPersistentContainer in the application delegate. To access it, you first get a reference to the app delegate.
     */
     let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
     
     /*
     An NSEntityDescription object is associated with a specific class instance
     Class
     NSEntityDescription
     A description of an entity in Core Data.
     
     Retrieving an Entity with a Given Name here person
     */
     let entity = NSEntityDescription.entity(forEntityName: "Person",
     in: managedContext)!
     
     
     /*
     Initializes a managed object and inserts it into the specified managed object context.
     
     init(entity: NSEntityDescription,
     insertInto context: NSManagedObjectContext?)
     */
     let person = NSManagedObject(entity: entity,
     insertInto: managedContext)
     
     /*
     With an NSManagedObject in hand, you set the name attribute using key-value coding. You must spell the KVC key (name in this case) exactly as it appears in your Data Model
     */
     person.setValue(name, forKeyPath: "name")
     person.setValue(ssn, forKeyPath: "ssn")
     
     /*
     You commit your changes to person and save to disk by calling save on the managed object context. Note save can throw an error, which is why you call it using the try keyword within a do-catch block. Finally, insert the new managed object into the people array so it shows up when the table view reloads.
     */
     do {
     try managedContext.save()
     return person as? Person
     } catch let error as NSError {
     print("Could not save. \(error), \(error.userInfo)")
     return nil
     }
     }
     
     func update(name:String, ssn : Int16, person : Person) {
     
     /*1.
     Before you can save or retrieve anything from your Core Data store, you first need to get your hands on an NSManagedObjectContext. You can consider a managed object context as an in-memory “scratchpad” for working with managed objects.
     Think of saving a new managed object to Core Data as a two-step process: first, you insert a new managed object into a managed object context; then, after you’re happy with your shiny new managed object, you “commit” the changes in your managed object context to save it to disk.
     Xcode has already generated a managed object context as part of the new project’s template. Remember, this only happens if you check the Use Core Data checkbox at the beginning. This default managed object context lives as a property of the NSPersistentContainer in the application delegate. To access it, you first get a reference to the app delegate.
     */
     let context = CoreDataManager.sharedManager.persistentContainer.viewContext
     
     do {
     
     
     /*
     With an NSManagedObject in hand, you set the name attribute using key-value coding. You must spell the KVC key (name in this case) exactly as it appears in your Data Model
     */
     person.setValue(name, forKey: "name")
     person.setValue(ssn, forKey: "ssn")
     
     print("\(person.value(forKey: "name"))")
     print("\(person.value(forKey: "ssn"))")
     
     /*
     You commit your changes to person and save to disk by calling save on the managed object context. Note save can throw an error, which is why you call it using the try keyword within a do-catch block. Finally, insert the new managed object into the people array so it shows up when the table view reloads.
     */
     do {
     try context.save()
     print("saved!")
     } catch let error as NSError  {
     print("Could not save \(error), \(error.userInfo)")
     } catch {
     
     }
     
     } catch {
     print("Error with request: \(error)")
     }
     }
     
     
     func delete(person : Person){
     
     let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
     
     do {
     
     managedContext.delete(person)
     
     } catch {
     // Do something in response to error condition
     print(error)
     }
     
     do {
     try managedContext.save()
     } catch {
     // Do something in response to error condition
     }
     }
     
     func fetchAllPersons() -> [Person]?{
     
     
     /*Before you can do anything with Core Data, you need a managed object context. */
     let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
     
     /*As the name suggests, NSFetchRequest is the class responsible for fetching from Core Data.
     
     Initializing a fetch request with init(entityName:), fetches all objects of a particular entity. This is what you do here to fetch all Person entities.
     */
     let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
     
     /*You hand the fetch request over to the managed object context to do the heavy lifting. fetch(_:) returns an array of managed objects meeting the criteria specified by the fetch request.*/
     do {
     let people = try managedContext.fetch(fetchRequest)
     return people as? [Person]
     } catch let error as NSError {
     print("Could not fetch. \(error), \(error.userInfo)")
     return nil
     }
     }
     
     func delete(ssn: String) -> [Person]? {
     /*get reference to appdelegate file*/
     
     
     /*get reference of managed object context*/
     let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
     
     /*init fetch request*/
     let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
     
     /*pass your condition with NSPredicate. We only want to delete those records which match our condition*/
     fetchRequest.predicate = NSPredicate(format: "ssn == %@" ,ssn)
     do {
     
     /*managedContext.fetch(fetchRequest) will return array of person objects [personObjects]*/
     let item = try managedContext.fetch(fetchRequest)
     var arrRemovedPeople = [Person]()
     for i in item {
     
     /*call delete method(aManagedObjectInstance)*/
     /*here i is managed object instance*/
     managedContext.delete(i)
     
     /*finally save the contexts*/
     try managedContext.save()
     
     /*update your array also*/
     arrRemovedPeople.append(i as! Person)
     }
     return arrRemovedPeople
     
     } catch let error as NSError {
     print("Could not fetch. \(error), \(error.userInfo)")
     return nil
     }
     
     }
     **/
}
