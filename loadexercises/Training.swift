import Foundation
import CoreData

@objc(Training)
class Training: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var name: String
    @NSManaged var exercises: NSOrderedSet
}
