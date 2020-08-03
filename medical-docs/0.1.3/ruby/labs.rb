# Class to manage lab values
class Labs
  def initialize
    @LabValues = Hash.new
    @LabNorm = Hash.new
    @LabUnits = Hash.new
    @age  = ""
    @sex  = ""

    units_set("Height", "cm")
    units_set("Weight", "kg")

    norm_set("FIT", "Neg")

    units_set("A1C", "%")
    norm_set("A1C", "<6.5")

    units_set("Fasting", "mmol/L")
    norm_set("Fasting", "3.3-6.0")

    units_set("LDL", "mmol/L")
    norm_set("LDL", "<2.84","<18")
    norm_set("LDL", "<3.41",">17")

    # normal is arbitrary but
    # certainly below 1.0 is not good
    units_set("HDL", "mmol/L")
    norm_set("HDL", ">0.9")

    units_set("Non-HDL", "mmol/L")
    norm_set("Non-HDL", "", "<18")
    norm_set("Non-HDL", "<4.2", ">17")

    units_set("SBP", "mmHg")
    norm_set("SBP", "<135")

    units_set("DBP", "mmHg")
    norm_set("DBP", "<85")

    units_set("eGFR", "ml/min/1.73m^2")
    norm_set("eGFR", ">59")

    units_set("ACR", "mg/mmol")
    norm_set("ACR", "<4", "<3")
    norm_set("ACR", "<3", ">2")

    units_set("Urine RBC", "/hpf")
    norm_set("Urine RBC", "<3", "<16")
    norm_set("Urine RBC", "<6", ">15")

    units_set("PSA", "ug/L")
    norm_set("PSA", "<2.6", "<50")
    norm_set("PSA", "<3.6", "50-59")
    norm_set("PSA", "<4.6", "60-69")
    norm_set("PSA", "<6.6", ">69")

    units_set("Total Chol", "mmol/L")
    norm_set("Total Chol", "2.36-5.32", "0")
    norm_set("Total Chol", "2.70-5.89", "1-17")
    norm_set("Total Chol", "<6.22", ">17")

    units_set("ALT", "u/L")
    norm_set("ALT", "<35", "<18")
    norm_set("ALT", "<60", ">17", "M")
    norm_set("ALT", "<40", ">17", "F")

    units_set("AST", "u/L")
    norm_set("AST", "10-65", "0")
    norm_set("AST", "10-55", "1-3")
    norm_set("AST", "10-45", "4-10")
    norm_set("AST", "8-40", ">10", "M")
    norm_set("AST", "8-32", ">10", "F")

    units_set("GGT", "u/L")
    norm_set("GGT", "8-35", "", "F")
    norm_set("GGT", "11-63", "", "M")

    units_set("ALP", "u/L")
    norm_set("ALP", "40-390", "0-5")
    norm_set("ALP", "45-450", "6-10")
    norm_set("ALP", "55-480", "11-12","M")
    norm_set("ALP", "60-480", "11-12","F")
    norm_set("ALP", "55-540", "13-14","M")
    norm_set("ALP", "45-300", "13-14","F")
    norm_set("ALP", "50-420", "15-16","M")
    norm_set("ALP", "30-160", "15-16","F")
    norm_set("ALP", "40-200", "17-18","M")
    norm_set("ALP", "30-120", "17-18","F")
    norm_set("ALP", "30-150", "19-20","M")
    norm_set("ALP", "30-115", "19-20","F")
    norm_set("ALP", "30-130", "21-49","M")
    norm_set("ALP", "30-115", "21-49","F")
    norm_set("ALP", "30-145", ">49")

    units_set("Lipase", "u/L")
    norm_set("Lipase", "0-60", "<16")
    norm_set("Lipase", "0-80", ">15")

  end


  # set the units for a given lab
  # this is an info field
  # we don't try to convert units for comparison
  def units_set(name, units)
    @LabUnits[name] = units
  end

  # return the units for a given lab
  def units(name)
    if @LabUnits.key?(name)
      return @LabUnits[name]
    else
      # no units recorded
      return ""
    end
  end

  # set the age to be used when considering
  # normal ranges for labs
  def age_set(age)
    @age = age.to_i
  end

  # set the sex to be used when considering
  # normal ranges for labs
  def sex_set(sex)
    @sex = sex
  end

  # set the normal for a given lab
  # some labs have different normals depending on age and sex
  # some labs have numerical ranges
  # some labs are a text value like "Negative" or "LSIL"
  def norm_set(name, range, ages = "", sex = "")
    # create entry for normal ranges if none exists
    if !@LabNorm.key?(name)
      @LabNorm[name] = Array.new
    end
    entry = Array.new
    entry[0] = range
    entry[1] = Array.new
    entry[1][0] = ages
    entry[1][1] = sex
    @LabNorm[name] << entry
  end

  # set the normal range for a lab, overriding the
  # default settings that would normally apply
  # this allows setting a specific range for the
  # current patient based on their history
  def norm_override(name, range)
    # overwrite any previous entries
    @LabNorm[name] = Array.new
    # create a new entry
    norm_set(name, range)
  end

  def in_range?(value, range)
    # assume it matches
    match = true

    # if any range defined
    if range != ""
      # ex: 10-20 (matches ages from 10 to 20 inclusive)
      if range =~ /([\d\.]+)\s*\-\s*([\d\.]+)/
        min_val = $1.to_f
        max_val = $2.to_f
        value = value.to_f
        if (value < min_val) || (value > max_val)
          match = false
        end
      # ex: >64 (matches 64.00001 and above)
      elsif range =~ /\>\s*([\d\.]+)/
        min_val = $1.to_f
        value = value.to_f
        if value <= min_val
          match = false
        end
      # ex: <18 (matches 17.999 and below)
      elsif range =~ /<\s*([\d\.]+)/
        max_val = $1.to_f
        value = value.to_f
        if value >= max_val
          match = false
        end
      # doesn't appear to be a range so should be
      # a single value
      elsif value != range
        match = false
      end
    end

    return match
  end

  # find normal range for current sex and age
  def norm_find(name)
    range = ""

    # if any normal ranges defined
    if @LabNorm.key?(name)
      # this will return the last range that is
      # a match - usually there should only
      # be one range that matches anyway

      ranges = @LabNorm[name]
      # each range entry is a two element array
      # the first element is the range and the
      # second is the conditions under which the
      # range applies
      ranges.each { |desc|
        cond = desc[1]
        # conditions are a 2 element array too
        # first element describes an age range
        # and the second describes the sex
        ages = cond[0]
        sex = cond[1]
        # if the sex is blank or matches current
        if (sex == "") || (sex == @sex)
          # compare the age range to the current
          if in_range?(@age, ages)
            range = desc[0]
          end
        end
      }
    end
    return range
  end

  # compare the given value to the normal range
  # using the currently set age and sex
  def normal?(name, value)
    # find the range that applies
    range = norm_find(name)

    return in_range?(value, range)
  end

  # get a normal range with units
  def normal_range(name)
    # range text
    range = norm_find(name)
    # range units
    my_units = units(name)

    return "#{range} #{my_units}"
  end

  # lab values are kept in hash of arrays
  # each item of the array is an array:
  # [value, date]
  def add(name, value, date)
    # puts "Adding Lab: #{name} #{value} #{date}"
    if !@LabValues.key?(name)
      @LabValues[name] = Array.new
    end
    # find index to insert at based on date
    # stored in reverse chronological order
    index = 0
    @LabValues[name].each { |entry|
      last_date = entry[1]
      if date == last_date
        # strange ... two entries for the same date
        last_val = entry[0]
        if last_val != value
          puts "Labs same date, different values for #{name}: #{date} #{value} vs #{last_val}"
        else
          # puts "Labs same date, same value for #{name}: #{date} #{value} vs #{last_val}"
        end
        # don't insert this value, generally not useful
        return
      elsif date < last_date
        index += 1
      end
    }
    @LabValues[name].insert(index, [value, date])
  end

  # labs are added in reverse chronically order
  # so index 0 is the most recent
  # index 1 is the second most recent and so on
  # if the index doesn't exist, will return ""
  def get(name, index)
    retval = ""
    if @LabValues.key?(name)
      if !@LabValues[name][index].nil?
        retval = @LabValues[name][index][0]
      end
    end
    return retval
  end

  def exists?(name)
    if @LabValues.key?(name)
      return true
    end
    return false
  end

  def date_get(name, index)
    retval = ""
    if @LabValues.key?(name)
      if !@LabValues[name][index].nil?
        retval = @LabValues[name][index][1]
      end
    end
    return retval
  end


  def dump
    @LabValues.each do |key, value|
      puts "Key is #{key}"
      @LabValues[key].each { |x| puts x }
    end
  end

end
