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
