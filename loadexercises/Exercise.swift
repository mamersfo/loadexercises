import Foundation
import CoreData

@objc(Exercise)
class Exercise: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var text: String
    @NSManaged var trainings: NSSet
    @NSManaged var category: Category
}
