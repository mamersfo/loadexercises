import Foundation
import CoreData

@objc(TrainingExercise)
class TrainingExercise: NSManagedObject {

    @NSManaged var training: Training
    @NSManaged var exercise: Exercise

}
