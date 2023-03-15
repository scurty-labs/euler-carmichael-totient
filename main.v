module main

import math

// I need a beer. Uhg.

fn greatest_common_divisor(x int, y int) int {
	if x == 0 {
		return y
	}
	return greatest_common_divisor(y % x, x)
}

// eulers method
fn euler_totient(n int) int {
	mut result := 1
	for i := 2; i < n; i+=1 {
		if greatest_common_divisor(i, n) == 1 {
			result += 1
		}
	}
	return result
}

// carmichaels method
fn carmichael_totient(n int) int {

	if n <= 2 {
		return 1
	}

	mut k := 2
	mut a := 1
	mut array := []int{}

	for greatest_common_divisor(a, n) != 1 {
		a = a + 1 // use a+=1
	}

	for greatest_common_divisor(a, n) == 1 && a<=n {
		array << a
		a += 1
		for greatest_common_divisor(a, n) != 1 {
			a += 1
		}
	}

	mut counter := array.len
	for counter > 0 {
		//println(counter)
		for a_value in array {
			if math.powi(a_value, k) % n == 1 {
				counter -= 1

				if counter < 0 {
				 	break
				}

			}else{
				counter = array.len
				k+=1
			}
		}
	}

	return k
}

fn main() {

	for n := 1; n <= 12; n+=1 {
		euler := euler_totient(n)
		carmichael := carmichael_totient(n)
		println('Euler: $n == $euler | Carmichael: $carmichael')
	}

}
