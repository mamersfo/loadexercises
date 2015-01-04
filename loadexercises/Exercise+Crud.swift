import CoreData

extension Exercise {
    
    class func create(moc: NSManagedObjectContext, uuid: String) -> Exercise {
        let exercise: Exercise = NSEntityDescription.insertNewObjectForEntityForName(
            "Exercise", inManagedObjectContext: moc) as Exercise
        exercise.uuid = uuid
        return exercise
    }

    class func findByName(moc: NSManagedObjectContext, name: String) -> [Exercise]? {
        let fr = NSFetchRequest(entityName: "Exercise")
        fr.predicate = NSComparisonPredicate(
            leftExpression: NSExpression(forKeyPath: "name"),
            rightExpression: NSExpression(forConstantValue: name),
            modifier: .DirectPredicateModifier,
            type: .ContainsPredicateOperatorType,
            options: .CaseInsensitivePredicateOption)

        return moc.executeFetchRequest(fr, error: nil) as [Exercise]?
    }
}