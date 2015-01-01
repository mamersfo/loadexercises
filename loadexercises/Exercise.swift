import Foundation
import CoreData

@objc(Exercise)
class Exercise: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var text: String
    @NSManaged var variations: String
    @NSManaged var tags: String
    @NSManaged var category: Category
    @NSManaged var trainings: NSSet

}
