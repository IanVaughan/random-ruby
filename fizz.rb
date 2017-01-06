(1..100).each do |i|
  case
  when (i % 3) == 0 && (i % 5) == 0 then  puts("FizzBuzz")
  when (i % 5) == 0 then puts("Buzz")
  when (i % 3) == 0 then puts("Fizz")
  else
    puts i
  end
end
