# swift-chime-34

A small Swift tool that computes text statistics for chime.

## Goal
- Provide quick text metrics for chime documents.
- Report top word frequencies for fast inspection.

## Usage
swift main.swift data/sample.txt --top 5

## Output
- lines: total line count
- words: total word count
- chars: total character count
- top words: most frequent tokens (case-insensitive)

## Notes
- Only ASCII letters and digits are treated as word characters.
