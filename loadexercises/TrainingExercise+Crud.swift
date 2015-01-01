import CoreData

extension TrainingExercise {
    
    class func create(moc: NSManagedObjectContext, training: Training, exercise: Exercise) -> TrainingExercise {
        let result = NSEntityDescription.insertNewObjectForEntityForName(
            "TrainingExercise", inManagedObjectContext: moc) as TrainingExercise
        result.training = training
        result.exercise = exercise
        return result
    }
    
    class func findByTraining(moc: NSManagedObjectContext, training: Training) -> [TrainingExercise]? {
        let fr = NSFetchRequest(entityName: "TrainingExercise")
        fr.predicate = NSComparisonPredicate(
            leftExpression: NSExpression(forKeyPath: "training"),
            rightExpression: NSExpression(forConstantValue: training),
            customSelector: "===")
        
        return moc.executeFetchRequest(fr, error: nil) as [TrainingExercise]?
    }
}