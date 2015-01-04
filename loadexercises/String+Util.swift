import Foundation

extension String {

    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    func split(sep: String) -> [String] {
        return self.componentsSeparatedByString(sep).map { $0.trim() }
    }
}