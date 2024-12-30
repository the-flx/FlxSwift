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

    /// Return hash-table for string where keys are characters.
    /// Value is a sorted list of indexes for character occurrences.
    static func getHashForString(str: String) -> [Int: [Int]] {
        var result: [Int: [Int]] = [:]

        let strLen = str.count
        var index = strLen - 1

        var downCh: Character?

        while 0 <= index {
            let ch = Util.charAt(str: str, index: index)

            if isCapital(ch: ch) {
                Util.dictInsert(result: &result, key: Util.char2Int(ch: ch), val: index)

                let upper = ch?.uppercased()
                downCh = Util.charAt(str: upper, index: 0)
            } else {
                downCh = ch
            }

            Util.dictInsert(result: &result, key: Util.char2Int(ch: downCh), val: index)

            index -= 1
        }

        return result
    }

    /// Generate the heatmap vector of string.
    ///
    /// See documentation for logic.
    static func getHeatmapStr(str: String, groupSeparator: Character?) -> [Int] {
        var scores: [Int] = []

        let strLen = str.count
        let strLastIndex = strLen - 1

        for _ in 0...strLastIndex {
            scores.append(defaultScore)
        }

        let penaltyLead = Util.charAt(str: ".", index: 0)!

        var groupAlist: [[Int]] = [[-1, 0]]

        // final char bonus
        scores[strLastIndex] += 1

        // Establish baseline mapping
        var lastCh: Character? = nil
        var groupWordCount = 0
        var index1 = 0

        for strIndex in str.indices {
            let ch = str[strIndex]

            // before we find any words, all separaters are
            // considered words of length 1.  This is so "foo/__ab"
            // gets penalized compared to "foo/ab".
            let effectiveLastChar: Character? = (groupWordCount == 0) ? nil : lastCh

            if isBoundary(lastCh: effectiveLastChar, ch: ch) {
                groupAlist[0].insert(index1, at: 2)
            }

            if !isWord(ch: lastCh) && isWord(ch: ch) {
                groupWordCount += 1
            }

            // ++++ -45 penalize extension
            if lastCh != nil && lastCh! == penaltyLead {
                scores[index1] += -45
            }

            if groupSeparator != nil && groupSeparator == ch {
                groupAlist[0][1] = groupWordCount
                groupWordCount = 0
                groupAlist.insert([index1, groupWordCount], at: 0)
            }

            if index1 == strLastIndex {
                groupAlist[0][1] = groupWordCount
            } else {
                lastCh = ch
            }

            index1 += 1
        }

        let groupCount = groupAlist.count
        let separatorCount = groupCount - 1

        // ++++ slash group-count penalty
        if separatorCount != 0 {
            incVec(vec: &scores, inc: groupCount * -2, beg: nil, end: nil)
        }

        var index2 = separatorCount
        var lastGroupLimit: Int? = nil
        var basepathFound = false

        // score each group further
        for group in groupAlist {
            let groupStart = group[0]
            let wordCount = group[1]
            // this is the number of effective word groups
            let wordsLength = group.count - 2
            var basepathP = false

            if wordsLength != 0 && !basepathFound {
                basepathFound = false
                basepathP = true
            }

            var num: Int
            if basepathP {
                // ++++ basepath separator-count boosts
                var boost = 0
                if separatorCount > 1 {
                    boost = separatorCount - 1
                }
                // ++++ basepath word count penalty
                let penalty = -wordCount
                num = 35 + boost + penalty
            }
            // ++++ non-basepath penalties
            else {
                if index2 == 0 {
                    num = -3
                } else {
                    num = -5 + (index2 - 1)
                }
            }

            incVec(vec: &scores, inc: num, beg: groupStart + 1, end: lastGroupLimit)

            var cddrGroup = group  // clone
            cddrGroup.removeFirst()
            cddrGroup.removeFirst()

            var wordIndex = wordsLength - 1
            var lastWord = (lastGroupLimit != nil) ? lastGroupLimit! : strLen

            for word in cddrGroup {
                // ++++  beg word bonus AND
                scores[word] += 85

                var index3 = word
                var charI = 0

                while index3 < lastWord {
                    scores[index3] += (-3 * wordIndex) - charI
                    charI += 1
                    index3 += 1
                }

                lastWord = word
                wordIndex -= 1
            }

            lastGroupLimit = groupStart + 1
            index2 -= 1
        }

        return scores
    }

    /// Return sublist bigger than `val` from sorted `sortedList`.
    ///
    /// If `val` is nil, return entire list.
    static func biggerSublist(sortedList: [Int]?, val: Int?) -> [Int]? {
        if sortedList == nil {
            return nil
        }

        if val == nil {
            return sortedList
        }

        var result: [Int]? = []

        for sub: Int in sortedList! {
            if sub > val! {
                result?.append(sub)
            }
        }

        return result
    }

    static func findBestMatch(
        imatch: inout [Result], strInfo: [Int: [Int]], heatmap: [Int], greaterThan: Int?,
        query: String, queryLen: Int, qIndex: Int, matchCache: inout [Int: [Result]]
    ) {
        let greaterNum = (greaterThan != nil) ? greaterThan! : 0
        let hashKey = qIndex + (greaterNum * queryLen)
        let hashVal = Util.dictGet(result: matchCache, key: hashKey)

        if hashVal != nil {
            imatch.removeAll()
            for val in hashVal! {
                imatch.append(val)
            }
        } else {
            let uchar = Util.charAt(str: query, index: qIndex)!
            let ichar = Util.char2Int(ch: uchar)
            let sortedList = Util.dictGet(result: strInfo, key: ichar)
            let indexes = biggerSublist(sortedList: sortedList, val: greaterThan)
            var tempScore: Int
            var bestScore = Int.min

            if qIndex >= queryLen - 1 {
                // At the tail end of the recursion, simply generate all possible
                // matches with their scores and return the list to parent.
                for index in indexes! {
                    var indices: [Int] = []
                    indices.append(index)
                    imatch.append(Result.init(indices: indices, score: heatmap[index], tail: 0))
                }
            } else {
                for index in indexes! {
                    var elemGroup: [Result] = []

                    findBestMatch(
                        imatch: &elemGroup, strInfo: strInfo, heatmap: heatmap, greaterThan: index,
                        query: query, queryLen: queryLen, qIndex: qIndex + 1,
                        matchCache: &matchCache)

                    for elem in elemGroup {
                        let caar = elem.indices[0]
                        let cadr = elem.score
                        let cddr = elem.tail

                        if (caar - 1) == index {
                            tempScore = cadr + heatmap[index] + (min(cddr, 3) * 15) + 60
                        } else {
                            tempScore = cadr + heatmap[index]
                        }

                        // We only care about the optimal match, so only forward the match
                        // with the best score to parent
                        if tempScore > bestScore {
                            bestScore = tempScore

                            imatch.removeAll()

                            var indices: [Int] = elem.indices
                            indices.insert(index, at: 0)
                            var tail = 0
                            if (caar - 1) == index {
                                tail = cddr + 1
                            }
                            imatch.append(
                                Result.init(indices: indices, score: tempScore, tail: tail))
                        }
                    }
                }
            }

            // Calls are cached to avoid exponential time complexity
            let imatchCloned = imatch
            Util.dictSet(result: &matchCache, key: hashKey, val: imatchCloned)
        }
    }

    public class Result {
        var indices: [Int]
        var score: Int
        var tail: Int

        init(indices: [Int], score: Int, tail: Int) {
            self.indices = indices
            self.score = score
            self.tail = tail
        }
    }

    /// Return best score matching `query` against `str`.
    public static func score(str: String, query: String) -> Result? {
        if str.isEmpty || query.isEmpty {
            return nil
        }

        let strInfo = getHashForString(str: str)
        let heatmap = getHeatmapStr(str: str, groupSeparator: nil)

        let queryLen = query.count
        let fullMatchBoost = (1 < queryLen) && (queryLen < 5)

        var matchCache: [Int: [Result]] = [:]
        var optimalMatch: [Result] = []

        findBestMatch(
            imatch: &optimalMatch, strInfo: strInfo, heatmap: heatmap, greaterThan: nil,
            query: query,
            queryLen: queryLen, qIndex: 0, matchCache: &matchCache)

        if optimalMatch.count == 0 {
            return nil
        }

        let result: Result = optimalMatch[0]
        let caar = result.indices.count

        if fullMatchBoost && caar == str.count {
            result.score += 10000
        }

        return result
    }
}
