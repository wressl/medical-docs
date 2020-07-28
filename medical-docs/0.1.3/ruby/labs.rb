# Class to manage lab values
class Labs
  def initialize
    @LabValues = Hash.new
    @LabNorm = Hash.new
    @LabUnits = Hash.new
  end

  # set the units for a given lab
  def units_set(name, units)
    @LabUnits[name] = units
  end

  # return the units for a given lab
  def units(name)
    if !@LabUnits.key?(name)
      return @LabUnits[name]
    else
      # no units recorded
      return ""
    end
  end

  # set the normal for a given lab
  # some labs have different normals depending on age and sex
  # some labs have numerical ranges
  # some labs are a text value like "Negative" or "LSIL"
  def norm_set(name, range, ages = "", sex = "")

  end

  # lab values are kept in hash of arrays
  # each item of the array is an array:
  # [value, date]
  def add(name, value, date)
    # puts "Adding Lab: #{name} #{value} #{date}"
    if !@LabValues.key?(name)
      @LabValues[name] = Array.new
    end
    @LabValues[name] << [value, date]
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
