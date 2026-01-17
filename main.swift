import Foundation

func tokenize(_ text: String) -> [String] {
    let pattern = "[A-Za-z0-9]+"
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let range = NSRange(text.startIndex..<text.endIndex, in: text)
    return regex.matches(in: text.lowercased(), options: [], range: range).map {
        String(text.lowercased()[Range($0.range, in: text.lowercased())!])
    }
}

let args = CommandLine.arguments
if args.count < 2 {
    fputs("usage: swift main.swift <path> [--top N]\n", stderr)
    exit(1)
}
var top = 10
var path: String?
var i = 1
while i < args.count {
    if args[i] == "--top", i + 1 < args.count {
        top = Int(args[i + 1]) ?? 10
        i += 2
    } else if path == nil {
        path = args[i]
        i += 1
    } else {
        i += 1
    }
}
let text = try String(contentsOfFile: path!, encoding: .utf8)
let lines = text.isEmpty ? 0 : text.filter { $0 == "\n" }.count + 1
let words = tokenize(text)
var counts: [String: Int] = [:]
for w in words { counts[w, default: 0] += 1 }
let sorted = counts.sorted { a, b in
    if a.value == b.value { return a.key < b.key }
    return a.value > b.value
}

print("lines: \(lines)")
print("words: \(words.count)")
print("chars: \(text.count)")
print("top words:")
for (word, count) in sorted.prefix(top) {
    print("  \(word): \(count)")
}
