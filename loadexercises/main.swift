import Foundation
import CoreData

let modelURL = NSBundle.mainBundle().URLForResource("Exercises", withExtension: "momd")!

var managedObjectModel: NSManagedObjectModel = {
    return NSManagedObjectModel(contentsOfURL: modelURL)!
}()

var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
    var error: NSError? = nil

    var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    
    let sqliteURL = NSURL(fileURLWithPath: "~/Code/scratch/ios/Training/Training/Exercises.sqlite".stringByExpandingTildeInPath)

    if coordinator!.addPersistentStoreWithType(
        NSSQLiteStoreType, configuration: nil, URL: sqliteURL, options: nil, error: &error) == nil {
        coordinator = nil
        NSLog("Unresolved error \(error), \(error!.userInfo)")
        abort()
    }
    
    return coordinator
}()

var managedObjectContext: NSManagedObjectContext? = {
    var managedObjectContext = NSManagedObjectContext()
    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    return managedObjectContext
}()

var error: NSError? = nil

let cat1 = Category.create(managedObjectContext!, name: "Looptraining", image: "running30")
let cat2 = Category.create(managedObjectContext!, name: "Kracht-training", image: "weightlift")
let cat3 = Category.create(managedObjectContext!, name: "Samenspelen en druk zetten", image: "planning1")
let cat4 = Category.create(managedObjectContext!, name: "Dribbelen en afpakken", image: "football6")
let cat5 = Category.create(managedObjectContext!, name: "Scoren en tegenhouden", image: "soccer71")
let cat6 = Category.create(managedObjectContext!, name: "Positiespel", image: "soccer18")
let cat7 = Category.create(managedObjectContext!, name: "Standaard-situaties", image: "corner1")
let cat8 = Category.create(managedObjectContext!, name: "Spelregels", image: "football72")

let categories = [
    cat1.name: cat1,
    cat2.name: cat2,
    cat3.name: cat3,
    cat4.name: cat4,
    cat5.name: cat5,
    cat6.name: cat6,
    cat7.name: cat7,
    cat8.name: cat8
]

if ( !managedObjectContext!.save(&error) ) {
    println("Error saving entity: \(error)")
}

if let dataPath = NSBundle.mainBundle().pathForResource("out", ofType: "json") {
    
    if let data: NSData = NSData.dataWithContentsOfMappedFile(dataPath) as? NSData {

        let exercises: NSArray = NSJSONSerialization.JSONObjectWithData(
            data, options: NSJSONReadingOptions.allZeros, error: &error) as NSArray
        
        for e in exercises {
            
            let name = e.objectForKey("name") as String!
            println("exercise: \(name)")
            let uuid = e.objectForKey("uuid") as String!
            println("uuid: \(uuid)")
            
            let exercise = Exercise.create(managedObjectContext!, uuid: uuid)
            exercise.name = name
            
            var str: String!
            
            if let str = e.objectForKey("text") as? String {
                exercise.text = str
            }
            
            if let str = e.objectForKey("category") as? String {
                exercise.category = categories[str]!
            }
            
            if let str = e.objectForKey("tags") as? String {
                exercise.tags = str
            }

            if let str = e.objectForKey("variations") as? String {
                str.split(";").map {
                    Variation.create(managedObjectContext!, string: $0, exercise: exercise)
                }
            }
            
            if ( !managedObjectContext!.save(&error) ) {
                println("Error saving entity: \(error)")
            }
        }
    }
}

if let fetchResults = Exercise.findByName(managedObjectContext!, name: "Duo-loop") as [Exercise]? {
    
    println("exercise: \(fetchResults[0].name)")

    let training = Training.create(managedObjectContext!, name: "Foo")
    
    TrainingExercise.create(managedObjectContext!, training: training, exercise: fetchResults[0])
    
    if ( !managedObjectContext!.save(&error) ) {
        println("Error saving entity: \(error)")
    }
    
    let t = Training.findByName(managedObjectContext!, name: "Foo")
    println("found training: \(t?[0].exercises.count)")
}

