// The Swift Programming Language
// https://docs.swift.org/swift-book

class Flx {
    static let wordSeparators: [Character] = [" ", "-", "_", ":", ".", "/", "\\"]
    
    static let defaultScore: Int = -35
    
    /// Check if `ch` is a word character.
    static func isWord(ch : Character?) -> Bool {
        if (ch == nil) {
            return false
        }
        return !wordSeparators.contains(ch!)
    }
    
    /// Check if` ch` is an uppercase character.
    static func isCapital(ch : Character?) -> Bool {
        return isWord(ch: ch) && String([ch!]) == ch?.uppercased()
    }
    
    /// Check if `lastCh` is the end of a word and `ch` the start of the next.
    ///
    /// This function is camel-case aware.
    static func isBoundary(lastCh : Character?, ch: Character) -> Bool {
        if (lastCh == nil) {
            return true
        }
        if (!isCapital(ch: lastCh) && isCapital(ch: ch)) {
            return true
        }
        if (!isWord(ch: lastCh) && isWord(ch: ch)) {
            return true
        }
        return false
    }
    
    static func incVec() {
        
    }
    
    public static func score() {
        // ..
    }
}
