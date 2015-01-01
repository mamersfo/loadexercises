import CoreData

extension Training {
    
    class func create(moc: NSManagedObjectContext, name: String) -> Training {
        let training = NSEntityDescription.insertNewObjectForEntityForName(
            "Training", inManagedObjectContext: moc) as Training
        training.name = name
        training.date = NSDate()
        return training
    }
    
    class func findByName(moc: NSManagedObjectContext, name: String) -> [Training]? {
        let fr = NSFetchRequest(entityName: "Training")
        fr.predicate = NSComparisonPredicate(
            leftExpression: NSExpression(forKeyPath: "name"),
            rightExpression: NSExpression(forConstantValue: name),
            modifier: .DirectPredicateModifier,
            type: .ContainsPredicateOperatorType,
            options: .CaseInsensitivePredicateOption)
        
        return moc.executeFetchRequest(fr, error: nil) as [Training]?
    }
    
    func addExercise(moc: NSManagedObjectContext, exercise: Exercise) {
        let trainingExercise = NSEntityDescription.insertNewObjectForEntityForName(
            "TrainingExercise", inManagedObjectContext: moc) as TrainingExercise
        trainingExercise.training = self
        trainingExercise.exercise = exercise
    }
    
}