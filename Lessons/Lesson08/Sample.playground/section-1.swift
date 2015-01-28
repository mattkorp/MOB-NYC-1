// Playground - noun: a place where people can play

let numbers = [0, 1, 2, 3, 4]

func addTwoInts(i1: Int, i2: Int) -> Int {
    return i1 + i2
}

numbers.reduce(0, combine: addTwoInts)

let strings = ["some", "collection", "of", "strings!"]

func concat(s1: String, s2: String) -> String {
    return s1 + " " + s2
}
strings.reduce("SeedValue", combine: concat)
func stringLengths(length: Int, s1: String) -> Int {
    return length + countElements(s1)
}
strings.reduce(0, combine: stringLengths)

let closureConcat = {(s1: String, s2: String) -> String in
    return s1 + " " + s2
}

concat("hi", "there")
strings.reduce("SeedValue", combine: closureConcat)
strings.reduce("SeedValue", combine: {(s1: String, s2: String) -> String in
    return s1 + s2
})
strings.reduce("SeedValue", combine: {(s1, s2) in
    return s1 + s2
})
strings.reduce("SeedValue", combine: {
    return $0 + $1
})
strings.reduce("SeedValue", combine: +)



