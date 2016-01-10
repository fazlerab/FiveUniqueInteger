//
//  main.swift
//  FiveUniqueInteger
//
//  Created by fazlerab on 1/8/16.
//  Copyright © 2016 Fazle Rab. All rights reserved.
//



/*
 * Find 5 unique integers between 1 and 9 that will satisfy the following equation:
 *
 *        y
 *    x + ⏤ + 23 * w - q = 98
 *        z
 */

import Foundation

var iterationCount:Int = 0;

func evaluateEquation(digits:[Int]) -> Void {
    let x = digits[0]
    let y = digits[1]
    let z = digits[2]
    let w = digits[3]
    let q = digits[4]
    
    var result:Double = Double(x)
    result += Double(y) / Double(z)
    result += 23.0
    result *= Double(w)
    result -= Double(q)
    
    if result == 98.0 {
        print("[x=\(x), y=\(y), z=\(z), w=\(w), q=\(q)] satisfies the eqation.")
    }
}


// First attempt quick
func permutateFiveDigits() {
    var digits:[Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    for xi in 0..<digits.count {
        let x = digits.removeAtIndex(xi)
        
        for yi in 0..<digits.count {
            let y = digits.removeAtIndex(yi);
            
            for zi in 0..<digits.count {
                let z = digits.removeAtIndex(zi)
                
                for wi in 0..<digits.count {
                    let w = digits.removeAtIndex(wi);
                    
                    for qi in 0..<digits.count {
                        let q = digits[qi]
                        evaluateEquation([x, y, z, w, q]);
                        iterationCount++;
                    }
                    digits.insert(w, atIndex: wi)
                }
                digits.insert(z, atIndex: zi)
            }
            digits.insert(y, atIndex: yi)
        }
        digits.insert(x, atIndex: xi)
    }
}



// Recursion using two arrays
func permutateRecursivelyDigitsOfLength(digitLength:Int, var _ aPermutation:[Int], var _ digits:[Int], _ evaluateFunction:([Int]) -> Void) {
    if (aPermutation.count == digitLength) {
        evaluateFunction(aPermutation)
    } else {
        for i in 0..<digits.count {
            let ithDigit = digits.removeAtIndex(i)
            aPermutation.append(ithDigit)
            
            permutateRecursivelyDigitsOfLength(digitLength, aPermutation, digits, evaluateFunction)
            
            aPermutation.removeLast();
            digits.insert(ithDigit, atIndex: i);
        }
    }
    
    iterationCount++;
}

// Recursion using one array
func permutateRecursivelyDigits(var digits:[Int], index:Int, length:Int, evaluateFunction:([Int]) -> Void) {
    if (index == length) {
        evaluateFunction(digits);
    }
    else {
        for i in index..<digits.count {
            // Swap indexed digit with ith digit
            let origIndexVal = digits[index]
            digits[index] = digits[i]
            digits[i] = origIndexVal
        
            //permutate staring index+1 to length
            permutateRecursivelyDigits(digits, index:index + 1, length:length, evaluateFunction:evaluateFunction)
            
            // Restore swap
            digits[i] = digits[index]
            digits[index] = origIndexVal
        }
    }
    iterationCount++
}

iterationCount = 0
print("Running permutateFiveDigits")
permutateFiveDigits();
print("Number of iteration = \(iterationCount), \n")

iterationCount = 0
print("Running permutateRecursivelyDigitsFoLength")
permutateRecursivelyDigitsOfLength(5, [], [1, 2, 3, 4, 5, 6, 7, 8, 9], evaluateEquation)
print("Number of iteration = \(iterationCount), \n")

iterationCount = 0
print("Running permutateRecursivelyDigits")
permutateRecursivelyDigits([1, 2, 3, 4, 5, 6,7, 8, 9], index:0, length:5, evaluateFunction:evaluateEquation)
print("Number of iteration = \(iterationCount), \n")

