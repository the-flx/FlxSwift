import Testing

@testable import Flx

@Test func testWord() async throws {
    #expect(Flx.isWord(ch: "C") == true)
    #expect(Flx.isWord(ch: "c") == true)
    #expect(Flx.isWord(ch: " ") == false)
}

@Test func testCapital() async throws {
    #expect(Flx.isCapital(ch: "C") == true)
    #expect(Flx.isCapital(ch: "c") == false)
    #expect(Flx.isCapital(ch: " ") == false)
}

@Test func testIncVec() async throws {
    var arr: [Int] = [1, 2, 3]
    Flx.incVec(vec: &arr, inc: 1, beg: 0, end: 3)
    #expect(arr == [2, 3, 4])
}

@Test func testGetHashForString() async throws {
    #expect(
        Flx.getHashForString(str: "switch-to-buffer") == [
            114: [15],
            101: [14],
            102: [12, 13],
            117: [11],
            98: [10],
            45: [6, 9],
            111: [8],
            116: [3, 7],
            104: [5],
            99: [4],
            105: [2],
            119: [1],
            115: [0],
        ])
}
