-- File: text_stats.lua
-- Language: Lua (Save with extension .lua for GitHub auto-detection)

local TextStats = {}

function TextStats.analyze(input_text)
    local word_count = 0
    local char_count = #input_text
    local frequency = {}

    -- Extract words and compute frequencies
    for word in input_text:gmatch("%w+") do
        word = word:lower()
        word_count = word_count + 1
        frequency[word] = (frequency[word] or 0) + 1
    end

    return {
        chars = char_count,
        words = word_count,
        freq = frequency
    }
end

function TextStats.print_report(stats)
    print("---------------------------------")
    print("       TEXT ANALYSIS REPORT      ")
    print("---------------------------------")
    print(string.format("Total Characters: %d", stats.chars))
    print(string.format("Total Words:      %d", stats.words))
    print("\nTop Word Frequencies:")

    local sorted_words = {}
    for word, count in pairs(stats.freq) do
        table.insert(sorted_words, { word = word, count = count })
    end

    table.sort(sorted_words, function(a, b) return a.count > b.count end)

    for i = 1, math.min(5, #sorted_words) do
        local item = sorted_words[i]
        print(string.format("  %-12s : %d", item.word, item.count))
    end
    print("---------------------------------")
end

-- Example Usage
local sample_text = "Lua is a powerful, efficient, lightweight, embeddable scripting language. Lua is cross-platform and easy to learn."
local results = TextStats.analyze(sample_text)
TextStats.print_report(results)
