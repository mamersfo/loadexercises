import Foundation
import CoreData

@objc(Category)
class Category: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var image: String
    @NSManaged var exercises: NSSet

}
