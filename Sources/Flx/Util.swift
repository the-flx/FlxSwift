//
//  Util.swift
//  Flx
//
//  Created by Jen-Chieh Shen on 12/29/24.
//

class Util {
    static func char2Int(ch: Character?) -> Int? {
        return Int(String(ch!.asciiValue!))
    }

    /// Return the character object in `str` by `index`.
    static func charAt(str: String?, index: Int) -> Character? {
        if str == nil {
            return nil
        }
        let _str = str!
        if let strIndex = _str.index(_str.startIndex, offsetBy: index, limitedBy: _str.endIndex) {
            return _str[strIndex]
        }
        return nil
    }

    static func dictSet(result: inout [Int: [Flx.Result]], key: Int?, val: [Flx.Result]?) {
        if key == nil || val == nil {
            return
        }

        result[key!] = val
    }

    static func dictGet<T>(result: [Int: [T]], key: Int?) -> [T]? {
        return result[key!]
    }

    static func dictInsert(result: inout [Int: [Int]], key: Int?, val: Int?) {
        if key == nil || val == nil {
            return
        }

        if result[key!] == nil {
            result[key!] = []
        }

        result[key!]?.insert(val!, at: 0)
    }
}
