import Foundation
import CoreData

@objc(Exercise)
class Exercise: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var tags: String
    @NSManaged var text: String
    @NSManaged var uuid: String
    @NSManaged var station: NSNumber
    @NSManaged var category: Category
    @NSManaged var trainings: NSSet
    @NSManaged var variations: NSOrderedSet

}
