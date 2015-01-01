import CoreData

extension Category {
    class func create(moc: NSManagedObjectContext, name: String, image: String) -> Category {
        let category: Category = NSEntityDescription.insertNewObjectForEntityForName(
            "Category", inManagedObjectContext: moc) as Category
        category.name = name
        category.image = image
        return category
    }
}
