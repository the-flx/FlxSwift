// The Swift Programming Language
// https://docs.swift.org/swift-book

class Flx {
    static let wordSeparators: [Character] = [" ", "-", "_", ":", ".", "/", "\\"]

    static let defaultScore: Int = -35

    /// Check if `ch` is a word character.
    static func isWord(ch: Character?) -> Bool {
        if ch == nil {
            return false
        }
        return !wordSeparators.contains(ch!)
    }

    /// Check if` ch` is an uppercase character.
    static func isCapital(ch: Character?) -> Bool {
        return isWord(ch: ch) && String([ch!]) == ch?.uppercased()
    }

    /// Check if `lastCh` is the end of a word and `ch` the start of the next.
    ///
    /// This function is camel-case aware.
    static func isBoundary(lastCh: Character?, ch: Character) -> Bool {
        if lastCh == nil {
            return true
        }
        if !isCapital(ch: lastCh) && isCapital(ch: ch) {
            return true
        }
        if !isWord(ch: lastCh) && isWord(ch: ch) {
            return true
        }
        return false
    }

    /// Increment each element in `vec` between `beg` and `end` by `inc`.
    static func incVec(vec: inout [Int], inc: Int?, beg: Int?, end: Int?) {
        let _inc: Int = (inc == nil) ? 1 : inc!
        var _beg: Int = (beg == nil) ? 0 : beg!
        let _end: Int = (end == nil) ? vec.count : end!

        while _beg < _end {
            vec[_beg] += _inc
            _beg += 1
        }
    }

    public class Result {
        // ..
    }

    /// Return best score matching `query` against `str`.
    public static func score(str: String, query: String) -> Result? {
        // ..
        return nil
    }
}
