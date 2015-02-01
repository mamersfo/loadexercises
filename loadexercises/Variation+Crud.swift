import CoreData

extension Variation {
    
    class func create(moc: NSManagedObjectContext, string: String, exercise: Exercise) -> Variation {
        
        let variation = NSEntityDescription.insertNewObjectForEntityForName(
            "Variation", inManagedObjectContext: moc) as Variation
        
        let comps = string.split(",")
        
        if comps.count > 1 {
            for i in 1...comps.count-1 {
                let params = comps[i].split("=")
                if params.count > 1 {
                    switch params[0] {
                    case "c":
                        variation.comment = params[1]
                    case "s":
                        variation.source = params[1]
                    case "v":
                        variation.video = params[1]
                    default:
                        continue
                    }
                }
            }
        }
        
        variation.name = comps[0]
        variation.exercise = exercise
        
        return variation
    }
}