import Foundation
import CoreData

@objc(Variation)
class Variation: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var video: String
    @NSManaged var source: String
    @NSManaged var comment: String
    @NSManaged var time: String
    @NSManaged var exercise: Exercise
}
