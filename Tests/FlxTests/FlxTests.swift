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
