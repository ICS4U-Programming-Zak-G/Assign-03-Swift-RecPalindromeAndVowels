//
//  RecPalindromeAndVowels.swift
//
//  Created by Zak Goneau
//  Created on 2025-05-08
//  Version 1.0
//  Copyright (c) 2025 Zak Goneau. All rights reserved.
//
//  Perform recursion to make a number into a palindrome or check the number of vowels in a string.

// Import library
import Foundation

// Function definition to make number a palindrome
func recPalindrome(number: Int, counter: Int) -> Int {
    // Set base case once number is a palindrome
    if (fullPalindrome(number: number)) {

        // Return counter
        return counter
    } else {
        // Increment counter
        let newCounter = counter + 1

        // Call function recursively
        return recPalindrome(number: number + recRevNum(number: number, reverseNum: 0), counter: newCounter)
    }
}

// Function definition to check if number is a palindrome
func fullPalindrome(number: Int) -> Bool {
    // Set base case, if numbers negative
    if (number < 0) {
        // Return false
        return false
    
    // Otherwise check if number is palindrome
    } else {
        // Get reverse number
        let reverseNum = recRevNum(number: number, reverseNum: 0)

        // Check if number is equal to reverse number
        return number == reverseNum
    }
}

// Function definition to reverse a number
func recRevNum(number: Int, reverseNum: Int) -> Int {
    // Set base case once number is 0
    if (number == 0) {
        // Return the reversed number
        return reverseNum
    
    // Otherwise, reverse the number recursively
    } else {
        // Get remainder
        let remainder = number % 10

        // Get reverse number
        let newReverseNum = (reverseNum * 10) + remainder

        // Call function recursively and divide number by 10
        return recRevNum(number: number / 10, reverseNum: newReverseNum)
    }
}

// Function definition to find vowels in a string
func recVowels(word: String, vowels: Int) -> Int {
    // Set base case, if word count is 0, return vowel count
    if (word.count == 0) {
        return vowels
    
    // Otherwise, check if first letter is a vowel
    } else {
        // Get first letter of word
        let firstLetter = word[word.startIndex]

        // Convert first letter to lowercase
        let firstLetterLower = String(firstLetter).lowercased()

        // Check if first letter is a vowel
        if (firstLetterLower == "a" || firstLetterLower == "e" || firstLetterLower == "i" || firstLetterLower == "o" || firstLetterLower == "u") {
            // Increment vowel count
            let newVowels = vowels + 1

            // Call function recursively with rest of word with incremented vowel count
            return recVowels(word: String(word.dropFirst()), vowels: newVowels)
        
        // Otherwise, if first letter is not a vowel
        } else {
            // Call function recursively with rest of word
            return recVowels(word: String(word.dropFirst()), vowels: vowels)
        }
    }
}

// Main function
func main() {
    // Declare output file
    let outputFile = "output.txt"

    // Initialize output string
    var outputStr = ""

    // Introduce program to user
    print("This program uses recursion to make a number into a palindrome "
        + "(1) or checks the number of vowels in a string(2).")
    print("The results will be written to a file called output.txt.\n")

    // Get user input
    print("Please enter your choice (1 or 2): ")

    // Ensure valid input
    guard let choice = readLine(), let choiceNum = Int(choice) else {
        //Add to output string invalid choice
        outputStr += "Invalid choice. Please enter 1 or 2.\n"

        // Write to output file
        _ = try? outputStr.write(toFile: outputFile, atomically: true, encoding: .utf8)

        // Exit program
        exit(1)
    }

    // Check if choice is 1
    if (choiceNum == 1) {
        // Declare integers file
        let integersFile = "integers.txt"

        // Try to read the integers file
        guard let integers = FileHandle(forReadingAtPath: integersFile) else {

            // Tell user input file couldn't be opened
            outputStr += ("Couldn't open integers file")

            // Exit function
            exit(1)
        }

        // Read lines from input file
        let integersData = integers.readDataToEndOfFile()

        // Convert data to string
        guard let inputString = String(data: integersData, encoding: .utf8) else {

            // Tell user couldn't convert data to string
            print("Couldn't convert data to string")

            // Exit function
            exit(1)
        }

        // Split string by new lines
        let lines = inputString.components(separatedBy: "\n")

        // Loop through each line
        for line in lines {
            // Convert line to integer
            guard let number = Int(line) else {
                // Add to output string invalid number
                outputStr += "\(line) must be an integer.\n"

                // Continue to next line
                continue
            }

            // Check if number is negative
            if (number < 0) {
                // Add to output string negative number
                outputStr += "\(number) cannot be negative.\n"

                // Continue to next line
                continue
            
            // Check if number is a single digit
            } else if (number < 10) {
                // Add to output string single digit number
                outputStr += "\(number) is automatically a palindrome.\n"

                // Continue to next line
                continue

            // Otherwise, check if number is a palindrome
            } else {
                // Initialize counter
                let counter = 0

                // Call function to make number a palindrome
                let palindromeResult = recPalindrome(number: number, counter: counter)

                // Add result to output string
                outputStr += "It took \(palindromeResult) tries to make \(number) a palindrome.\n"
            }
        }

    // Check if choice is 2
    } else if (choiceNum == 2) {
        // Declare words file
        let wordsFile = "words.txt"

        // Try to read the words file
        guard let words = FileHandle(forReadingAtPath: wordsFile) else {

            // Tell user input file couldn't be opened
            outputStr += ("Couldn't open words file")

            // Exit function
            exit(1)
        }

        // Read lines from input file
        let wordsData = words.readDataToEndOfFile()

        // Convert data to string
        guard let inputString = String(data: wordsData, encoding: .utf8) else {

            // Tell user couldn't convert data to string
            print("Couldn't convert data to string")

            // Exit function
            exit(1)
        }

        // Split string by new lines
        let lines = inputString.components(separatedBy: "\n")

        // Loop through each line
        for line in lines {
            // Check if word is only letters
            // https://www.programiz.com/swift-programming/library/array/allsatisfy
            if (line.allSatisfy { character in character.isLetter}) == false {
                // Add to output string invalid word
                outputStr += "\(line) must only contain letters.\n"

                // Continue to next line
                continue
            }

            // Check if word is empty
            if (line.isEmpty) {
                // Add to output string empty word
                outputStr += "The word is empty.\n"

                // Continue to next line
                continue
            }

            // Call function to count vowels
            let vowelCount = recVowels(word: line, vowels: 0)

            // Add result to output string
            outputStr += "The number of vowels in \(line) is \(vowelCount).\n"
        }

    // Otherwise, invalid choice
    } else {
        // Add to output string invalid choice
        outputStr += "Your choice was not 1 or 2.\n"
    }

    // Write to output file
    _ = try? outputStr.write(toFile: outputFile, atomically: true, encoding: .utf8)

    // Print success message
    print("The results have been written to \(outputFile).")
}

// Call main
main()
