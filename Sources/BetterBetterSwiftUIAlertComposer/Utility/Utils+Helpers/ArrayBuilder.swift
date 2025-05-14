import Foundation

/// Allows to build Arrays in SwiftUI style
/// ❤️ https://gist.github.com/rjchatfield/72629b22fa915f72bfddd96a96c541eb
@resultBuilder
struct ArrayBuilder<Element> {
    static func buildPartialBlock(first: Element) -> [Element] { [first] }
    static func buildPartialBlock(first: [Element]) -> [Element] { first }
    static func buildPartialBlock(accumulated: [Element], next: Element) -> [Element] { accumulated + [next] }
    static func buildPartialBlock(accumulated: [Element], next: [Element]) -> [Element] { accumulated + next }
    
    // Empty Case
    static func buildBlock() -> [Element] { [] }
    // If/Else
    static func buildEither(first: [Element]) -> [Element] { first }
    static func buildEither(second: [Element]) -> [Element] { second }
    // Just ifs
    static func buildIf(_ element: [Element]?) -> [Element] { element ?? [] }
    // fatalError()
    static func buildPartialBlock(first: Never) -> [Element] {}
    // For in
    static func buildArray(_ components: [[Element]]) -> [Element] { components.flatMap { $0 } }
}

extension Array {
    init(@ArrayBuilder<Element> builder: () -> [Element]) {
        self.init(builder())
    }
}
