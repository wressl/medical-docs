require 'date'

# Health Goals

# Goals are tasks that need to be done
# either once or periodically
# and are dependent on general demographics
# like age and sex
# or on a specific health condition
# such as fatty liver, hypertension, or diabetes

# Some examples of goals:
# 1) Every woman between the age of 25 - 70 should have a PAP smear every 3 years
# 2) Everyone between the ages of 50-74 should have a FIT test every 1-2 years
# 3) Every woman between the age of 50 - 74 should have a Mammogram every 2 years
# 4) Everyone should have a tetanus vaccine at least every 10 years
# 5) Everyone should consider a Shingles vaccine after the age of 50
# 6) Everyone should have a pneumonia vaccine after the age of 65
# 7) Everyone with diabetes should have an A1C every 3 months
# 8) Everyone with hypertension should have their kidney function checked at least once a year
#
# Obviously there may be exceptions and there are some complications that arise:
# What if the PAP smear is abnormal?
# What if there was a colonoscopy instead of a FIT
# What if there is a family history of breast cancer?
# Does every well controlled diabetic really need an A1C every 3 months?


class Goal
  # descriptive name
  @name = ""

  # lab name that needs checking
  @lab = ""

  # default to any sex
  @sex = ""


  # health condition for which this goal applies
  @condition = ""

  # freq is defined in years
  def initialize(pt, name, freq = "",
                 min_age = "", max_age = "",
                 sex = "", condition = "", lab = "")
    @pt = pt
    @date = Date.today
    @name = name
    @sex = sex
    # default to no frequency
    # if defined this will be in days
    @frequency = ""

    @sex_range = ""
    if @sex == "M"
      @sex_range = "males "
    elsif @sex == "F"
      @sex_range = "females "
    end

    # default to any age from 0 - 150
    # unlikely to see anyone outside of this range
    @age = Array.new
    @age[0] = 0
    if min_age != ""
      @age[0] = min_age.to_i
    end
    @age[1] = 150
    if max_age != ""
      @age[1] = max_age.to_i
    end
    @age_range = ""
    if (min_age != "") && (max_age != "")
      @age_range = "from age #{@age[0]} to #{@age[1]} "
    elsif (min_age != "")
      @age_range = "from age #{@age[0]} "
    elsif (max_age != "")
      @age_range = "until age #{@age[1]} "
    end

    @condition = condition
    @cond_range = ""
    if @condition != ""
      @cond_range = "with #{@condition} "
    end


    @years = ""
    @interval = "once "
    if freq != ""
      @years = freq.to_i
      if @years == 1
        @interval = "every year "
      else
        @interval = "every #{@years} years "
      end
      # convert years to days
      @frequency = freq.to_f * 365.25
    end

    # combine it all to a verbose description of the inclusion criteria
    @inclusion = "#{@sex_range}#{@age_range}#{@cond_range}#{@interval}" 

    @lab = lab
    # lab name is the descriptive name by default
    if @lab == ""
      @lab = @name
    end

    #    puts "Initialized Goal #{@name} Freq #{@frequency} days from age #{@age[0]} to #{@age[1]} 
    #          for condition #{@condition} and lab #{@lab}"
  end

  # change the "current" date to consider goals
  def date_set(date)
    @date = date
  end

  # check if goal applies to the patient
  def applies?
    cur_age = @pt.age_get(@date).to_i
    #puts "checking for current age #{cur_age} between #{@age[0]} and #{@age[1]}"
    return false unless (cur_age >= @age[0]) && (cur_age <= @age[1])

    # if specified, check correct sex
    if @sex != ""
      #puts "checking for sex equal to #{@sex}"
      return false unless @sex == @pt.sex_get()
    end

    # if specified, check correct condition
    if @condition != ""
      #puts "checking for condition present: #{@condition}"
      return false unless @pt.condition?(@condition)
    end

    return true
  end

  # check if goal has been met
  # note that this will check if the goal is met
  # regardless if it applies
  def met?
    # check that the lab value exists
    return false unless @pt.lab_exists?(@lab)

    # if frequency defined
    if @frequency != ""
      # check the date on the latest lab value
      latest = @pt.lab_date_get(@lab,0)
      days = @frequency.to_i
      #puts "Latest date is #{latest}, adding #{days}, compared to #{@date}"
      return false unless (latest + days) >= @date
    end

    return true
  end

  # some debugging messages
  def msg_out (msg)
    # puts "At #{@date} the goal #{@name} #{msg}"
    @pt.out_add("For date #{@date} the goal #{@name} #{msg} (#{@inclusion})")
  end

  def msg_met
    msg_out("is met")
  end

  def msg_not_met
    msg_out("is NOT met")
    @pt.action_add("Discuss meeting the goal for #{@name}")
  end

  def msg_not_apply
    # puts "At #{@date} the goal #{@name} does NOT apply"
  end

  # a more complete check of whether a goal applies and
  # if it does, whether the goal is met
  def check
    if applies?
      if met?
        msg_met
      else
        msg_not_met
      end
    else
      msg_not_apply
    end
  end
end

# Height once over age of 18
class Goal_Height < Goal
  def initialize (pt)
    super(pt, "Height", "", 18)
  end
end

# Weight every 3 years
class Goal_Weight < Goal
  def initialize (pt)
    super(pt, "Weight", 3)
  end
end

# Blood Pressure once a year
class Goal_BloodPressure < Goal
  def initialize (pt)
    super(pt, "Blood Pressure", 1)
    @lab = "SBP"
  end
end

# Tobacco inquiry once a year
class Goal_Tobacco < Goal
  def initialize (pt)
    super(pt, "Tobacco", 1)
  end
end

# Alcohol inquiry once a year
class Goal_Alcohol < Goal
  def initialize (pt)
    super(pt, "Alcohol", 1)
  end
end

# Diet inquiry once a year
class Goal_Diet < Goal
  def initialize (pt)
    super(pt, "Diet", 1)
  end
end

# Exercise inquiry once a year
class Goal_Exercise < Goal
  def initialize (pt)
    super(pt, "Exercise", 1)
  end
end

# Influenza vaccine once a year
class Goal_Influenza < Goal
  def initialize (pt)
    super(pt, "Flu Vaccine", 1)
  end
end

# Tetanus every 10 years starting at age 24, assuming last standard
# childhood vaccination was at age 14
class Goal_Tetanus < Goal
  def initialize (pt)
    super(pt, "Tetanus", 10, 24)
  end
end


# Pneumovax once for over 65
class Goal_Pneumovax < Goal
  def initialize (pt)
    super(pt, "Pneumovax", "", 65)
  end
end

# Prevnar once for over 50
class Goal_Prevnar < Goal
  def initialize (pt)
    super(pt, "Prevnar", "", 50)
  end
end

# Shingrix once for over 50
class Goal_Shingrix < Goal
  def initialize (pt)
    super(pt, "Shingrix", "", 50)
  end
end

# PAP every 3 years from 25 - 69 yo for females
class Goal_PAP < Goal
  def initialize (pt)
    super(pt, "PAP Smear", 3, 25, 69, "F")
  end
end

# Mammogram every 2 years from 50 - 74 yo
class Goal_Mammo < Goal
  def initialize (pt)
    super(pt, "Mammography", 2, 50, 74, "F")
  end
end


# FIT every 2 years from 50 - 74 yo
# except of course if you have had a colonoscopy
# in which case we need to repeat the colonoscopy
# at the specified interval unless the colonoscopy was clear
# in which case going back to FIT is recommended
class Goal_FIT < Goal
  def initialize (pt)
    super(pt, "FIT", 2, 50, 74)
  end
  def met?
    # check if colonoscopy on record
    name = "Colonoscopy"
    if @pt.lab_exists?(name)
      @lab = name
      @name = name
      value = @pt.lab_get(@lab,0)
      # convert months to days
      @years = value.to_i
      @frequency = @years * 365.25
      @inclusion = "Repeat in #{@years} years"
    end
    return super
  end
end

# Abdominal Aortic Aneurysm Screen once for Males over 65
class Goal_AAA < Goal
  def initialize (pt)
    super(pt, "AAA Screening", "", 65, "", "M")
  end
end

# Goals of Care Discussion once over age of 75
class Goal_GOC < Goal
  def initialize (pt)
    super(pt, "Goals of Care", "", 75)
  end
end

# Diabetes Test every 5 years
class Goal_Diabetes < Goal
  def initialize (pt)
    super(pt, "A1C", 5, 40, 74)
  end
end

# Cholesterol Test every 5 years
class Goal_Cholesterol < Goal
  def initialize (pt)
    super(pt, "Cholesterol", 5, 40, 74)
  end
end


# this is a list of all goals
class Goals
  def initialize (pt)
    @goals = Array.new

    @goals << Goal_Height.new(pt)
    @goals << Goal_Weight.new(pt)
    @goals << Goal_BloodPressure.new(pt)
    @goals << Goal_Tobacco.new(pt)
    @goals << Goal_Alcohol.new(pt)
    @goals << Goal_Diet.new(pt)
    @goals << Goal_Exercise.new(pt)
    @goals << Goal_Influenza.new(pt)
    @goals << Goal_Tetanus.new(pt)
    @goals << Goal_Pneumovax.new(pt)
    @goals << Goal_Prevnar.new(pt)
    @goals << Goal_Shingrix.new(pt)
    @goals << Goal_PAP.new(pt)
    @goals << Goal_Mammo.new(pt)
    @goals << Goal_FIT.new(pt)
    @goals << Goal_AAA.new(pt)
    @goals << Goal_GOC.new(pt)
    @goals << Goal_Diabetes.new(pt)
    @goals << Goal_Cholesterol.new(pt)
  end

  def date_set(date)
    @goals.each { |goal| goal.date_set(date) }
  end

  def check
    @goals.each { |goal| goal.check }
  end
end
