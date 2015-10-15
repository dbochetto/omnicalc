class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

def count1(strng)
    strng.gsub(/[!?@.,;:"'+-='"$@&]/, "")
    lst = strng.downcase.split(" ")
    words = {}
    lst.each do |x|
        if words.has_key?(x) == false
            words[x] = 1
        else
            words[x] = words[x] + 1
        end
    end
    return words
end


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ", "").length

    @word_count = @text.split(" ").length

    var1 = count1(@text) 

    @occurrences = var1[(@special_word.downcase)]
                   


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    
    rate = @apr/100/12
    months = @years*12

    month_pay = (rate*@principal*(1+rate)**months) / ((1+rate)**months - 1)

    @monthly_payment = month_pay

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @weeks / 52 #how do we deal with leap years??? 

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    def sum_num(lst)
        total = 0
        lst.each do |x|
            total = total + x
            end 
        return total
    end

    def variance(lst)
        total = 0
        count = lst.length
        lst.each do |x|
            total = total + x
        end
        std_tot = 0
        mean = total / count
        lst.each do |y|
            std1 = (y-mean)**2
            std_tot = std_tot + std1
        end
        var = std_tot / count
        return var
    end

# the next function makes a hash out of the @numbers array

def count2(lst)
words = {}
    lst.each do |x|
        if words.has_key?(x) == false
            words[x] = 1
        else
            words[x] = words[x] + 1
        end
    end
    return words
end

# this variable stores the hash into a variable

lst1 = count2(@numbers)

#this next function then performs analysis on the hash created in the previous function

def count3(var1)
maxim = 0
maxim_key = nil
var1.each do |y,z|
       if var1[y] > maxim
           maxim = var1[y]
           maxim_key = y
        else
        maxim = maxim
        maxim_key = maxim_key
        end
    end
 return maxim_key
end


x = @numbers.length
y = @numbers.sort

if x.even? == true
    median = (y[x/2 - 1] + y[x/2]) / 2
else
    median = y[(x-1)/2]
end


    @sorted_numbers = y

    @count = x

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[(@count-1)]

    @range = @maximum - @minimum

    @median = median

    @sum = sum_num(@numbers)

    @mean = @sum / @count

    @variance = variance(@numbers)

    @standard_deviation = @variance**(0.5)

    @mode = count3(lst1)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
